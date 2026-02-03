<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Peminjaman extends Model
{
    protected $table = 'tb_peminjaman';
    protected $primaryKey = 'id_peminjaman';
    public $timestamps = false;

    protected $fillable = [
        'id_user',
        'tanggal_pinjam',
        'tanggal_kembali',
        'status',
        'alasan_ditolak'
    ];

    protected $casts = [
        'tanggal_pinjam' => 'datetime',
        'tanggal_kembali' => 'datetime',
        'tanggal_disetujui' => 'datetime'
    ];

    public function detail()
    {
        return $this->hasMany(
            DetailPeminjaman::class,
            'id_peminjaman',
            'id_peminjaman'
        );
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'id_user', 'id_user');
    }

    public function alat()
    {
        return $this->belongsTo(Alat::class, 'id_alat');
    }

}
