<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetailPeminjaman extends Model
{
    protected $table = 'tb_detail_peminjaman';
    protected $primaryKey = 'id_detail';
    public $timestamps = false;

    protected $fillable = [
        'id_peminjaman',
        'id_alat',
        'jumlah',
    ];

    public function alat()
    {
        return $this->belongsTo(
            Alat::class,
            'id_alat',
            'id_alat'
        );
    }
}

