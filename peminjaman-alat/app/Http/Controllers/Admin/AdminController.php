<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Kategori;
use App\Models\Alat;
use App\Models\Peminjaman;

class AdminController extends Controller
{
    public function kategori()
    {
        $kategori = Kategori::all();
        return view('admin.kategori', compact('kategori'));
    }

    public function alat()
    {
        $alat = Alat::with('kategori')->get();
        return view('admin.alat', compact('alat'));
    }

    public function peminjaman()
    {
        $peminjaman = Peminjaman::with('user')->get();
        return view('admin.peminjaman', compact('peminjaman'));
    }


}

