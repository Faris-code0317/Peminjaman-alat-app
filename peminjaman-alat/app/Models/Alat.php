<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Alat extends Model
{
    protected $table = 'tb_alat';
    protected $primaryKey = 'id_alat';
    public $timestamps = false;

    protected $fillable = [
        'nama_alat',
        'stok',
        'id_kategori',
        'gambar'
    ];

    public function kategori()
    {
        return $this->belongsTo(Kategori::class, 'id_kategori', 'id_kategori');
    }
}

