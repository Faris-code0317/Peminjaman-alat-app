<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LogAktivitas extends Model
{
    protected $table = 'tb_log_aktivitas';
    protected $primaryKey = 'id_log';
    public $timestamps = false;

    protected $fillable = [
        'id_user',
        'nama_user',
        'role',
        'aktivitas',
        'keterangan',
        'created_at'
    ];
}
