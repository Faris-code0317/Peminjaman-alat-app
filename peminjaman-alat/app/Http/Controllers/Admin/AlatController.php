<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Alat;
use App\Models\Kategori;
use App\Models\DetailPeminjaman;
use Illuminate\Support\Facades\Storage;

class AlatController extends Controller
{
    public function index(Request $request)
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
        return view('admin.alat.index', compact('alat', 'kategori'));
    }

    public function create()
    {
        $kategori = Kategori::all();
        return view('admin.alat.create', compact('kategori'));
    }

    // ✅ STORE (TAMBAH ALAT + LOG)
    public function store(Request $request)
    {
        $request->validate([
            'nama_alat' => 'required',
            'id_kategori' => 'required|exists:tb_kategori,id_kategori',
            'stok' => 'required|integer|min:0',
            'gambar' => 'required|image|mimes:jpg,jpeg,png|max:2048'
        ]);


        $gambar = $request->file('gambar');
        $namaFile = time() . '_' . $gambar->getClientOriginalName();
        $gambar->storeAs('alat', $namaFile, 'public');

        $alat = Alat::create([
            'nama_alat' => $request->nama_alat,
            'id_kategori' => $request->id_kategori,
            'stok' => $request->stok,
            'gambar' => $namaFile
        ]);

        // ✅ LOG
        logAktivitas(
            session('user'),
            'Tambah alat',
            'Menambahkan alat: ' . $alat->nama_alat
        );

        return redirect('/admin/alat')->with('success', 'Alat berhasil ditambahkan');
    }

    public function edit($id)
    {
        $alat = Alat::findOrFail($id);
        $kategori = Kategori::all();

        return view('admin.alat.edit', compact('alat', 'kategori'));
    }

    public function update(Request $request, $id)
    {
        $alat = Alat::findOrFail($id);

        $request->validate([
            'nama_alat' => 'required',
            'id_kategori' => 'required|exists:tb_kategori,id_kategori',
            'stok' => 'required|integer|min:0',
            'gambar' => 'nullable|image|mimes:jpg,jpeg,png|max:2048'
        ]);

        // ===============================
        // JIKA ADA GAMBAR BARU
        // ===============================
        if ($request->hasFile('gambar')) {

            // hapus gambar lama
            if ($alat->gambar && Storage::disk('public')->exists('alat/' . $alat->gambar)) {
                Storage::disk('public')->delete('alat/' . $alat->gambar);
            }

            // simpan gambar baru
            $file = $request->file('gambar');
            $namaFile = time() . '_' . $file->getClientOriginalName();
            $file->storeAs('alat', $namaFile, 'public');

            $alat->gambar = $namaFile;
        }

        // ===============================
        // UPDATE DATA (SELALU JALAN)
        // ===============================
        $alat->update([
            'nama_alat' => $request->nama_alat,
            'id_kategori' => $request->id_kategori,
            'stok' => $request->stok,
            'gambar' => $alat->gambar
        ]);

        logAktivitas(
            session('user'),
            'Update alat',
            'Mengubah data alat: ' . $alat->nama_alat
        );

        return redirect('/admin/alat')->with('success', 'Alat berhasil diupdate');
    }


    // DELETE (HAPUS ALAT + LOG)
    public function destroy($id)
    {
        $alat = Alat::findOrFail($id);
        // ❗ Cek apakah alat pernah / sedang dipinjam
        $dipakai = DetailPeminjaman::where('id_alat', $id)->exists();

        if ($dipakai) {
            return redirect('/admin/alat')
                ->with('error', 'Alat tidak bisa dihapus karena masih memiliki riwayat peminjaman');
        }

        // ===============================
        //  HAPUS GAMBAR JIKA ADA
        // ===============================
        if ($alat->gambar && Storage::disk('public')->exists('alat/' . $alat->gambar)) {
            Storage::disk('public')->delete('alat/' . $alat->gambar);
        }

        $nama = $alat->nama_alat;
        $alat->delete();

        // LOG
        logAktivitas(
            session('user'),
            'Hapus alat',
            'Menghapus alat: ' . $nama
        );

        return redirect('/admin/alat')->with('success', 'Alat berhasil dihapus');
    }

}
