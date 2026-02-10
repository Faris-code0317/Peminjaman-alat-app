<?php

namespace App\Http\Controllers\Petugas;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Peminjaman;
use Barryvdh\DomPDF\Facade\Pdf;
use App\Models\Alat;
use App\Models\Kategori;

class LaporanController extends Controller
{
    public function peminjaman(Request $request)
    {
        $from = $request->from;
        $to   = $request->to;

        $peminjaman = Peminjaman::orderBy('tanggal_kembali', 'desc')
            ->with('user', 'detail.alat')
            ->whereBetween('tanggal_pinjam', [$from, $to])
            ->get();

        $alat = Alat::with('kategori')
            ->get();
        $kategori = Kategori::all();
        $pdf = PDF::loadView(
            'petugas.laporan.peminjaman',
            compact('peminjaman','alat','kategori', 'from', 'to')
        );

        return $pdf->stream('laporan-peminjaman.pdf');
    }

    public function index(Request $request)
    {
        $search = $request->search;

        $peminjaman = Peminjaman::orderBy('created_at', 'desc')
            ->with(['user', 'detail.alat'])
            // ->whereIn('status', ['dikembalikan', 'ditolak', 'menunggu', 'dipinjam'])
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

            $alat = Alat::with('kategori')
                ->get();
            $kategori = Kategori::all();
        return view('petugas.laporan.index', compact('peminjaman', 'alat', 'kategori'));
    }
}
