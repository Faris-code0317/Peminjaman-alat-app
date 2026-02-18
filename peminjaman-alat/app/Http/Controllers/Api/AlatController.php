<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Alat;
use Illuminate\Http\Request;

class AlatController extends Controller
{
    public function index()
    {
        $alat = Alat::with('kategori')->get();

        $alat->transform(function ($item) {
            $item->gambar = url('/api/image/' . $item->gambar);
            return $item;
        });

        return response()->json([
            'message' => 'Data alat',
            'data' => $alat
        ]);
    }

    public function store(Request $request)
    {
        $alat = Alat::create([
            'nama_alat'   => $request->nama_alat,
            'stok'        => $request->stok,
            'id_kategori' => $request->id_kategori
        ]);

        return response()->json([
            'message' => 'Alat berhasil ditambahkan',
            'data' => $alat
        ]);
    }

    public function show($id)
    {
        $alat = Alat::with('kategori')->find($id);

        if (!$alat) {
            return response()->json([
                'message' => 'Alat tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'message' => 'Detail alat',
            'data' => $alat
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $alat = Alat::find($id);

        if (!$alat) {
            return response()->json([
                'message' => 'Alat tidak ditemukan'
            ], 404);
        }

        $alat->update($request->only([
            'nama_alat',
            'stok',
            'id_kategori'
        ]));

        return response()->json([
            'message' => 'Alat berhasil diupdate',
            'data' => $alat
        ]);
    }

    public function destroy($id)
    {
        Alat::destroy($id);

        return response()->json([
            'message' => 'Alat berhasil dihapus'
        ]);
    }
}
