<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Peminjaman;
use App\Models\DetailPeminjaman;
use App\Models\Alat;
use Carbon\Carbon;

class PeminjamanController extends Controller
{
    // GET semua peminjaman
    public function index()
    {
        return response()->json(
            Peminjaman::with([
                'user',
                'detail.alat.kategori'
            ])->get()
        );
    }

    public function show($id)
    {
        $peminjaman = Peminjaman::with([
            'user',
            'detail.alat'
        ])->find($id);

        if (!$peminjaman) {
            return response()->json([
                'message' => 'Data peminjaman tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'message' => 'Detail peminjaman',
            'data' => $peminjaman
        ], 200);
    }

    // POST pinjam alat
   public function store(Request $request)
    {
        DB::beginTransaction();

        try {
            $request->validate([
                'id_user' => 'required|exists:tb_user,id_user',
                'alat' => 'required|array',
                'alat.*.id_alat' => 'required|exists:tb_alat,id_alat',
                'alat.*.jumlah' => 'required|integer|min:1'
            ]);

            // 1️⃣ Buat data peminjaman (STATUS MENUNGGU)
            $peminjaman = Peminjaman::create([
                'id_user' => $request->id_user,
                'tanggal_pinjam' => Carbon::now('Asia/Jakarta'),
                'status' => 'menunggu'
            ]);

            // 2️⃣ Simpan detail peminjaman (TANPA UBAH STOK)
            foreach ($request->alat as $item) {
                $alat = Alat::findOrFail($item['id_alat']);

                    if ($item['jumlah'] > $alat->stok) {
                        return response()->json([
                            'success' => false,
                            'message' => 'Stok alat tidak mencukupi'
                        ], 400);
                    }

                $exists = Peminjaman::where('id_user', $request->id_user)
                        ->whereIn('status', ['menunggu', 'dipinjam'])
                        ->whereHas('detail', function ($q) use ($item) {
                            $q->where('id_alat', $item['id_alat']);
                        })
                        ->exists();

                    if ($exists) {
                        return response()->json([
                            'success' => false,
                            'message' => 'Kamu masih memiliki peminjaman aktif untuk alat ini'
                        ], 400);
                    }

                DetailPeminjaman::create([
                    'id_peminjaman' => $peminjaman->id_peminjaman,
                    'id_alat' => $alat['id_alat'],
                    'jumlah' => $item['jumlah'],
                ]);
            }

            DB::commit();


            return response()->json([
                'message' => 'Peminjaman berhasil dibuat, menunggu persetujuan petugas',
                'data' => $peminjaman
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 400);
        }
    }

    public function kembalikan($id)
    {
        DB::beginTransaction();

        try {
            $peminjaman = Peminjaman::with('detail.alat')->findOrFail($id);

            // DEBUG 1: cek status
            if (trim($peminjaman->status) !== 'dipinjam') {
                return response()->json([
                    'message' => 'Status bukan dipinjam',
                    'status' => $peminjaman->status
                ], 400);
            }

            // DEBUG 2: cek detail
            if ($peminjaman->detail->count() === 0) {
                throw new \Exception('Detail peminjaman kosong');
            }

            foreach ($peminjaman->detail as $detail) {
                if (!$detail->alat) {
                    throw new \Exception('Relasi alat tidak ditemukan');
                }

                // Tambah stok
                $detail->alat->stok += $detail->jumlah;
                $detail->alat->save();
            }

            // Update status
            $peminjaman->update([
                'status' => 'dikembalikan',
                'tanggal_kembali' => now()
            ]);

            DB::commit();

            return response()->json([
                'message' => 'Pengembalian berhasil'
            ], 200);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function setujui($id)
    {
        DB::beginTransaction();

        try {
            $peminjaman = Peminjaman::with('detail.alat')->findOrFail($id);

            if ($peminjaman->status !== 'menunggu') {
                return response()->json([
                    'message' => 'Peminjaman tidak bisa disetujui'
                ], 400);
            }

            foreach ($peminjaman->detail as $d) {
                if ($d->alat->stok < $d->jumlah) {
                    throw new \Exception('Stok tidak mencukupi');
                }

                $d->alat->decrement('stok', $d->jumlah);
            }

            $peminjaman->update(['status' => 'dipinjam']);

            DB::commit();

            return response()->json([
                'message' => 'Peminjaman berhasil disetujui'
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'error' => $e->getMessage()
            ], 400);
        }
    }

    public function byUser($id_user)
    {
        $data = Peminjaman::with('detail.alat')
                ->where('id_user', $id_user)
                ->orderBy('created_at', 'desc')
                ->get();

        return response()->json([
            'success' => true,
            'message' => 'Data peminjaman user',
            'data' => $data
        ]);
    }

    public function detail($id)
    {
        // $peminjaman = Peminjaman::with(['alat', 'user'])
        //     ->find($id);

        $peminjaman = Peminjaman::with([
            'user',
            'detail.alat'
        ])->find($id);

        if (!$peminjaman) {
            return response()->json([
                'success' => false,
                'message' => 'Peminjaman tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Detail peminjaman',
            'data' => $peminjaman
        ]);
    }
}
