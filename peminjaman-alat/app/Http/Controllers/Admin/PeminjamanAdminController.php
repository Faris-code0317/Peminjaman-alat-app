<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Peminjaman;
use App\Models\DetailPeminjaman;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Models\Alat;

class PeminjamanAdminController extends Controller
{
    // ==============================
    // 📌 PEMINJAMAN AKTIF
    // ==============================
    public function aktif(Request $request)
    {
        $search = $request->search;

        $peminjaman = Peminjaman::orderBy('created_at', 'desc')
            ->with(['user', 'detail.alat'])
            ->whereIn('status', ['menunggu', 'dipinjam'])
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->whereHas('user', function ($u) use ($search) {
                    $u->whereRaw('LOWER(nama_lengkap) LIKE ?', ["%{$search}%"]);
                });
            })
            ->when($request->id_alat, function ($q) use ($request) {
                $q->whereHas('detail', function ($d) use ($request) {
                    $d->where('id_alat', $request->id_alat);
                });
            })
            ->when($request->status, function ($q) use ($request) {
                $q->where('status', $request->status);
            })
            ->when($request->from && $request->to, function ($q) use ($request) {
                $q->whereBetween('created_at', [
                    $request->from.' 00:00:00',
                    $request->to.' 23:59:59'
                ]);
            })
            ->paginate(10)
            ->withQueryString();

            $alat = Alat::all();
        return view('admin.peminjaman.aktif', compact('peminjaman', 'alat'));
    }

    // ==============================
    // 📌 PEMINJAMAN SELESAI
    // ==============================
    public function selesai(Request $request)
    {
        $search = $request->search;

        $peminjaman = Peminjaman::orderBy('created_at', 'desc')
            ->with(['user', 'detail.alat'])
            ->whereIn('status', ['dikembalikan', 'ditolak'])
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->whereHas('user', function ($u) use ($search) {
                    $u->whereRaw('LOWER(nama_lengkap) LIKE ?', ["%{$search}%"]);
                });
            })
            ->when($request->id_alat, function ($q) use ($request) {
                $q->whereHas('detail', function ($d) use ($request) {
                    $d->where('id_alat', $request->id_alat);
                });
            })
            ->when($request->status, function ($q) use ($request) {
                $q->where('status', $request->status);
            })
            ->when($request->from && $request->to, function ($q) use ($request) {
                $q->whereBetween('created_at', [
                    $request->from.' 00:00:00',
                    $request->to.' 23:59:59'
                ]);
            })
            ->paginate(10)
            ->withQueryString();

            $alat = Alat::all();
        return view('admin.peminjaman.selesai', compact('peminjaman', 'alat'));
    }

    // ==============================
    // 📌 HAPUS PEMINJAMAN (ADMIN)
    // ==============================
    public function destroy($id)
    {
        $peminjaman = Peminjaman::findOrFail($id);

        if ($peminjaman->status !== 'ditolak' && $peminjaman->status !== 'dikembalikan') {
            return back()->with('error', 'Peminjaman belum dikembalikan');
        }

        $peminjaman->delete();

        // LOG
        $user = session('user');
        logAktivitas(
            $user,
            'Hapus peminjaman',
            'Menghapus peminjaman ID ' . $id
        );

        return back()->with('success', 'Data peminjaman berhasil dihapus');
    }

    // ==============================
    // 📌 AJUKAN PEMINJAMAN
    // ==============================
    public function store(Request $request)
    {
        DB::beginTransaction();

        try {
            $request->validate([
                'id_user' => 'required|exists:tb_user,id_user',
                'alat' => 'required|array'
            ]);

            $peminjaman = Peminjaman::create([
                'id_user' => $request->id_user,
                'tanggal_pinjam' => now(),
                'status' => 'menunggu'
            ]);

            foreach ($request->alat as $item) {
                DetailPeminjaman::create([
                    'id_peminjaman' => $peminjaman->id_peminjaman,
                    'id_alat' => $item['id_alat'],
                    'jumlah' => $item['jumlah']
                ]);
            }

            // LOG
            $user = session('user');
            logAktivitas(
                $user,
                'Ajukan peminjaman',
                'Mengajukan peminjaman ID ' . $peminjaman->id_peminjaman
            );

            DB::commit();

            return response()->json([
                'message' => 'Peminjaman berhasil diajukan',
                'data' => $peminjaman
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 400);
        }
    }

    // ==============================
    // 📌 SETUJUI PEMINJAMAN
    // ==============================
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

            foreach ($peminjaman->detail as $detail) {
                $alat = $detail->alat;

                if ($alat->stok < $detail->jumlah) {
                    throw new \Exception(
                        'Stok alat ' . $alat->nama_alat . ' tidak mencukupi'
                    );
                }

                $alat->stok -= $detail->jumlah;
                $alat->save();
            }

            $peminjaman->status = 'dipinjam';
            $peminjaman->save();

            // LOG
            $user = session('user');
            logAktivitas(
                $user,
                'Setujui peminjaman',
                'Menyetujui peminjaman ID ' . $id
            );

            DB::commit();

            return response()->json([
                'message' => 'Peminjaman disetujui'
            ]);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 400);
        }
    }

    // ==============================
    // 📌 PENGEMBALIAN
    // ==============================
    public function kembalikan($id)
    {
        DB::beginTransaction();

        try {
            $peminjaman = Peminjaman::with('detail.alat')->findOrFail($id);

            if ($peminjaman->status !== 'dipinjam') {
                return response()->json([
                    'message' => 'Peminjaman belum dipinjam'
                ], 400);
            }

            foreach ($peminjaman->detail as $detail) {
                $alat = $detail->alat;
                $alat->stok += $detail->jumlah;
                $alat->save();
            }

            $peminjaman->status = 'dikembalikan';
            $peminjaman->tanggal_kembali = now();
            $peminjaman->save();

            // LOG
            $user = session('user');
            logAktivitas(
                $user,
                'Pengembalian alat',
                'Mengembalikan peminjaman ID ' . $id
            );

            DB::commit();

            return response()->json([
                'message' => 'Peminjaman berhasil dikembalikan'
            ]);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'error' => $e->getMessage()
            ], 400);
        }
    }
}
