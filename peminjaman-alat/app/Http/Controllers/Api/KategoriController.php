<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Kategori;
use Illuminate\Http\Request;

class KategoriController extends Controller
{
    public function index()
    {
        return response()->json(Kategori::all());
    }

    public function store(Request $request)
    {
        $request->validate([
            'nama_kategori' => 'required|string|max:100'
        ]);

        $kategori = Kategori::create([
            'nama_kategori' => $request->nama_kategori
        ]);

        return response()->json([
            'message' => 'Kategori berhasil ditambahkan',
            'data' => $kategori
        ], 201);
    }

    public function show($id)
{
    $kategori = Kategori::find($id);

    if (!$kategori) {
        return response()->json([
            'message' => 'Kategori tidak ditemukan'
        ], 404);
    }

    return response()->json([
        'message' => 'Detail kategori',
        'data' => $kategori
    ], 200);
}


    public function update(Request $request, $id)
    {
        $kategori = Kategori::findOrFail($id);
        $kategori->update([
            'nama_kategori' => $request->nama_kategori
        ]);

        return response()->json([
            'message' => 'Kategori berhasil diupdate',
            'data' => $kategori
        ]);
    }

    public function destroy($id)
    {
        Kategori::destroy($id);

        return response()->json([
            'message' => 'Kategori berhasil dihapus'
        ]);
    }
}

