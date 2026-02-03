<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pengembalian extends Model
{
    protected $table = 'tb_pengembalian';
    protected $primaryKey = 'id_pengembalian';
    public $timestamps = false;

    protected $fillable = [
        'id_peminjaman',
        'tanggal_kembali'
    ];

    public function peminjaman()
    {
        return $this->belongsTo(Peminjaman::class, 'id_peminjaman');
    }
}
