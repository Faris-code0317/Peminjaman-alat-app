<?php

namespace App\Http\Controllers\Petugas;

use App\Http\Controllers\Controller;
use App\Models\Alat;
use App\Models\Peminjaman;
use Illuminate\Http\Request;
use App\Models\Kategori;
// use App\Models\DetailPeminjaman;
use Illuminate\support\facades\DB;
use Carbon\Carbon;

class PetugasController extends Controller
{
    public function alat(Request $request)
    {
        $search = $request->search;

        $alat = Alat::orderBy('created_at', 'desc')
            ->with('kategori')
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->where(function ($sub) use ($search) {
                    $sub->whereRaw('LOWER(nama_alat) LIKE ?', ["%{$search}%"]);
                });
            })
            ->when($request->id_kategori, function ($q) use ($request) {
                $q->where('id_kategori', $request->id_kategori);
            })
            ->when($request->from && $request->to, function ($q) use ($request) {
                $q->whereBetween('created_at', [
                    $request->from.' 00:00:00',
                    $request->to.' 23:59:59'
                ]);
            })
            ->paginate(10)
            ->withQueryString();
        $kategori = Kategori::all();
        return view('petugas.alat', compact('alat', 'kategori'));
    }

    public function peminjaman(Request $request)
    {
        $search = $request->search;

        $peminjaman = Peminjaman::orderBy('created_at', 'desc')
            ->with(['user', 'detail.alat'])
            ->whereIn('status', ['menunggu'])
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
            ->when($request->from && $request->to, function ($q) use ($request) {
                $q->whereBetween('created_at', [
                    $request->from.' 00:00:00',
                    $request->to.' 23:59:59'
                ]);
            })
            ->paginate(10)
            ->withQueryString();

        $alat = Alat::all();
        return view('petugas.peminjaman.setujui', compact('peminjaman', 'alat'));
    }

    public function peminjamanAktif(Request $request)
    {
        $search = $request->search;

        $peminjaman = Peminjaman::orderBy('created_at', 'desc')
            ->with(['user', 'detail.alat'])
            ->whereIn('status', ['pengembalian'])
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
            ->when($request->from && $request->to, function ($q) use ($request) {
                $q->whereBetween('tanggal_disetujui', [
                    $request->from.' 00:00:00',
                    $request->to.' 23:59:59'
                ]);
            })
            ->paginate(10)
            ->withQueryString();

        // $peminjaman = Peminjaman::with([
        //     'user',
        //     'detail.alat'
        // ])
        // ->orderBy('created_at', 'desc')
        // ->get();

        $alat = Alat::all();
        return view('petugas.peminjaman.aktif', compact('peminjaman', 'alat'));
    }

    public function peminjamanSelesai(Request $request)
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

        // $peminjaman = Peminjaman::with([
        //     'user',
        //     'detail.alat'
        // ])
        // ->orderBy('created_at', 'desc')
        // ->get();

        $alat = Alat::all();
        return view('petugas.peminjaman.selesai', compact('peminjaman', 'alat'));
    }

    // ✅ SETUJUI PEMINJAMAN
    public function setujui($id)
    {
        DB::beginTransaction();

        try {
            $peminjaman = Peminjaman::with('detail.alat')->findOrFail($id);

            if ($peminjaman->status !== 'menunggu') {
                return back()->with('error', 'Peminjaman tidak bisa disetujui');
            }

            foreach ($peminjaman->detail as $detail) {

                // 🔴 CEK AMAN
                if (!$detail->alat) {
                    throw new \Exception('Data alat tidak ditemukan');
                }

                if ($detail->alat->stok < $detail->jumlah) {
                    throw new \Exception(
                        'Stok ' . $detail->alat->nama_alat . ' tidak mencukupi'
                    );
                }

                // ✅ KURANGI STOK
                $detail->alat->stok -= $detail->jumlah;
                $detail->alat->save();
            }

            $peminjaman->status = 'dipinjam';
            $peminjaman->tanggal_disetujui = Carbon::now('Asia/Jakarta');
            $peminjaman->save();

            // LOG
            logAktivitas(
                session('user'),
                'Setujui peminjaman',
                'Menyetujui peminjaman ID ' . $peminjaman->id_peminjaman
            );

            DB::commit();
            return back()->with('success', 'Peminjaman berhasil disetujui');

        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', $e->getMessage());
        }
    }


    // 🔁 PENGEMBALIAN
    public function peminjamanPengembalian(Request $request)
    {
        $search = $request->search;

        $peminjaman = Peminjaman::orderBy('created_at', 'desc')
            ->with(['user', 'detail.alat'])
            ->where('status', 'pengembalian')
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->whereHas('user', function ($u) use ($search) {
                    $u->whereRaw('LOWER(nama_lengkap) LIKE ?', ["%{$search}%"]);
                });
            })
            ->paginate(10)
            ->withQueryString();

        $alat = Alat::all();

        return view('petugas.peminjaman.aktif', compact('peminjaman', 'alat'));
    }

    public function kembalikan($id)
    {
        DB::beginTransaction();

        try {

            $peminjaman = Peminjaman::with('detail.alat')->findOrFail($id);

            if ($peminjaman->status !== 'pengembalian') {
                return back()->with('error', 'Pengembalian belum diajukan oleh user');
            }

            $peminjaman->update([
                'status' => 'dikembalikan',
                'tanggal_kembali' => Carbon::now('Asia/Jakarta')
            ]);

            foreach ($peminjaman->detail as $d) {
                $d->alat->increment('stok', $d->jumlah);
            }

            logAktivitas(
                session('user'),
                'Konfirmasi Pengembalian',
                'Mengkonfirmasi pengembalian peminjaman ID ' . $peminjaman->id_peminjaman
            );

            DB::commit();

            return redirect('/petugas/peminjaman-aktif')
                ->with('success', 'Pengembalian berhasil dikonfirmasi');

        } catch (\Exception $e) {

            DB::rollBack();

            return back()->with('error', $e->getMessage());
        }
    }

    // ❌ TOLAK PEMINJAMAN
    public function tolak($id)
    {
        $peminjaman = Peminjaman::findOrFail($id);

        if ($peminjaman->status !== 'menunggu') {
            return back()->with('error', 'Peminjaman tidak bisa ditolak');
        }

        request()->validate([
            'alasan' => 'required|string|min:5'
        ]);

        $peminjaman->update([
            'status' => 'ditolak',
            'alasan_ditolak' => request('alasan'),
            'tanggal_kembali' => Carbon::now('Asia/Jakarta')
        ]);

        logAktivitas(
            session('user'),
            'Tolak peminjaman',
            'Menolak peminjaman ID ' . $peminjaman->id_peminjaman .
            ' | Alasan: ' . request('alasan')
        );

        return back()->with('success', 'Peminjaman berhasil ditolak');
    }
}
