<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Peminjaman;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->search;

        // $log = LogAktivitas::orderBy('created_at', 'desc')
        //     ->when($search, function ($q) use ($search) {
        //         $search = strtolower($search);
        //         $q->where(function ($sub) use ($search) {
        //             $sub->whereRaw('LOWER(nama_user) LIKE ?', ["%{$search}%"])
        //                 ->orWhereRaw('LOWER(aktivitas) LIKE ?', ["%{$search}%"])
        //                 ->orWhereRaw('LOWER(keterangan) LIKE ?', ["%{$search}%"]);
        //         });
        //     })
        //     ->when($request->role, function ($q) use ($request) {
        //         $q->where('role', $request->role);
        //     })
        //     ->when($request->from && $request->to, function ($q) use ($request) {
        //         $q->whereBetween('created_at', [
        //             $request->from.' 00:00:00',
        //             $request->to.' 23:59:59'
        //         ]);
        //     })
        //     ->paginate(10)
        //     ->withQueryString();

        $user = User::orderBy('created_at', 'desc')
            ->whereIn('role', ['peminjam'])
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->where(function ($sub) use ($search) {
                    $sub->whereRaw('LOWER(username) LIKE ?', ["%{$search}%"])
                        ->orWhereRaw('LOWER(nama_lengkap) LIKE ?', ["%{$search}%"]);
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

        $admin = User::orderBy('created_at','desc')
            ->whereIn('role', ['admin', 'petugas'])
            ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->where(function ($sub) use ($search) {
                    $sub->whereRaw('LOWER(username) LIKE ?', ["%{$search}%"])
                        ->orWhereRaw('LOWER(nama_lengkap) LIKE ?', ["%{$search}%"]);
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

        return view('admin.user.index', compact('admin','user'));
    }

    public function create()
    {
        return view('admin.user.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_lengkap' => 'required',
            'username' => 'required|unique:tb_user,username',
            'password' => 'required|min:6',
            'role' => 'required|in:admin,petugas,peminjam'
        ]);

        $user = User::create([
            'nama_lengkap' => $request->nama_lengkap,
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'role' => $request->role
        ]);

        // ✅ LOG
        logAktivitas(
            session('user'),
            'Tambah user',
            'Menambahkan user: ' . $user->nama_lengkap
        );

        return redirect('/admin/user')->with('success', 'User berhasil ditambahkan');
    }

    public function edit($id)
    {
        $user = User::findOrFail($id);
        return view('admin.user.edit', compact('user'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'nama_lengkap' => 'required',
            'role' => 'required|in:admin,petugas,peminjam'
        ]);

        $user = User::findOrFail($id);

        $data = [
            'nama_lengkap' => $request->nama_lengkap,
            'role' => $request->role
        ];

        if ($request->password) {
            $data['password'] = Hash::make($request->password);
        }

        $user->update($data);

        // ✅ LOG
        logAktivitas(
            session('user'),
            'Update user',
            'Mengubah user: ' . $user->nama_lengkap
        );

        return redirect('/admin/user')->with('success', 'User berhasil diupdate');
    }

    public function destroy($id)
    {
        // ❗ Cegah hapus user yang punya peminjaman
        $dipakai = Peminjaman::where('id_user', $id)->exists();

        if ($dipakai) {
            return redirect('/admin/user')
                ->with('error', 'User tidak bisa dihapus karena memiliki data peminjaman');
        }

        $user = User::findOrFail($id);
        $nama = $user->nama_lengkap;
        $user->delete();

        // ✅ LOG
        logAktivitas(
            session('user'),
            'Hapus user',
            'Menghapus user: ' . $nama
        );

        return redirect('/admin/user')->with('success', 'User berhasil dihapus');
    }
}
