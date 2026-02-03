<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Kategori;

class KategoriController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->search;

        $kategori = Kategori::orderBy('created_at', 'desc')
        ->when($search, function ($q) use ($search) {
                $search = strtolower($search);
                $q->where(function ($sub) use ($search) {
                    $sub->whereRaw('LOWER(nama_kategori) LIKE ?', ["%{$search}%"]);
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

        return view('admin.kategori.index', compact('kategori'));
    }

    public function create()
    {
        return view('admin.kategori.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_kategori' => 'required'
        ]);

        // ✅ SIMPAN KE VARIABEL
        $kategori = Kategori::create([
            'nama_kategori' => $request->nama_kategori
        ]);

        // ✅ LOG
        logAktivitas(
            session('user'),
            'Tambah kategori',
            'Menambahkan kategori: ' . $kategori->nama_kategori
        );

        return redirect('/admin/kategori')->with('success', 'Kategori berhasil ditambahkan');
    }

    public function edit($id)
    {
        $kategori = Kategori::findOrFail($id);
        return view('admin.kategori.edit', compact('kategori'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'nama_kategori' => 'required'
        ]);

        $kategori = Kategori::findOrFail($id);
        $kategori->update([
            'nama_kategori' => $request->nama_kategori
        ]);

        // ✅ LOG
        logAktivitas(
            session('user'),
            'Update kategori',
            'Mengubah kategori: ' . $kategori->nama_kategori
        );

        return redirect('/admin/kategori')->with('success', 'Kategori berhasil diupdate');
    }

    public function destroy($id)
    {
        $kategori = Kategori::findOrFail($id);
        $nama = $kategori->nama_kategori;


        if ($kategori->alat()->exists()) {
            return back()->with(
                'error',
                'Kategori ini sedang digunakan oleh alat'
            );
        }

        $kategori->delete();

        // ✅ LOG
        logAktivitas(
            session('user'),
            'Hapus kategori',
            'Menghapus kategori: ' . $nama
        );

        return redirect('/admin/kategori')->with('success', 'Kategori berhasil dihapus');
    }
}
