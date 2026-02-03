<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\LogAktivitas;
use App\Models\LogCache;
use Illuminate\Support\Facades\Auth;


class LogAktivitasController extends Controller
{
    public function index(Request $request)
    {
        $query = LogAktivitas::query();

        // // 🔍 SEARCH NAMA USER
        // if ($request->filled('nama')) {
        //     $query->where('nama_user', 'ILIKE', '%' . $request->nama . '%');
        // }

        // // 🎭 FILTER ROLE
        // if ($request->filled('role')) {
        //     $query->where('role', $request->role);
        // }

        // // 📅 FILTER TANGGAL
        // if ($request->filled('tanggal')) {
        //     $query->whereDate('created_at', $request->tanggal);
        // }

        // // 📆 FILTER BULAN
        // if ($request->filled('bulan')) {
        //     $query->whereMonth('created_at', $request->bulan);
        // }

        // // 📆 FILTER TAHUN
        // if ($request->filled('tahun')) {
        //     $query->whereYear('created_at', $request->tahun);
        // }

        $search = $request->search;

        $log = LogAktivitas::orderBy('created_at', 'desc')
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->where(function ($sub) use ($search) {
                    $sub->whereRaw('LOWER(nama_user) LIKE ?', ["%{$search}%"])
                        ->orWhereRaw('LOWER(aktivitas) LIKE ?', ["%{$search}%"])
                        ->orWhereRaw('LOWER(keterangan) LIKE ?', ["%{$search}%"]);
                });
            })
            ->when($request->role, function ($q) use ($request) {
                $q->where('role', $request->role);
            })
            ->when($request->from && $request->to, function ($q) use ($request) {
                $q->whereBetween('created_at', [
                    $request->from.' 00:00:00',
                    $request->to.' 23:59:59'
                ]);
            })
            ->paginate(10)
            ->withQueryString();

        return view('admin.log.index', compact('log'));

    }

    public function destroy($id)
    {
        $log = LogAktivitas::findOrFail($id);

        LogCache::create([
            'nama_user'  => $log->nama_user,
            'role'       => $log->role,
            'aktivitas'  => $log->aktivitas,
            'keterangan' => $log->keterangan,
            'created_at' => $log->created_at,
            'deleted_at' => now(),
            'deleted_by' => Auth::check()
                 ? Auth::user()->nama_lengkap
                 : 'System',
        ]);

        $log->delete();

        return back()->with('success', 'Log berhasil dihapus & dipindahkan ke arsip');
    }

    public function cache()
    {
        $logCache = LogCache::orderBy('deleted_at', 'desc')->get();
        return view('admin.log.cache', compact('logCache'));
    }

    public function indexCache(Request $request)
    {
        $query = LogCache::query();
        $search = $request->search;

        $logCache = LogCache::orderBy('deleted_at', 'desc')
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->where(function ($sub) use ($search) {
                    $sub->whereRaw('LOWER(nama_user) LIKE ?', ["%{$search}%"])
                        ->orWhereRaw('LOWER(aktivitas) LIKE ?', ["%{$search}%"])
                        ->orWhereRaw('LOWER(keterangan) LIKE ?', ["%{$search}%"]);
                });
            })
            ->when($request->role, function ($q) use ($request) {
                $q->where('role', $request->role);
            })
            ->when($request->from && $request->to, function ($q) use ($request) {
                $q->whereBetween('created_at', [
                    $request->from.' 00:00:00',
                    $request->to.' 23:59:59'
                ]);
            })
            ->paginate(10)
            ->withQueryString();

        return view('admin.log.cache', compact('logCache'));
    }
}
