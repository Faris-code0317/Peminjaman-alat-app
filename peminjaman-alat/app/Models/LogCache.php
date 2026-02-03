<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LogCache extends Model
{
    protected $table = 'log_cache';
    protected $primaryKey = 'id_cache';
    public $timestamps = false;

    protected $fillable = [
    'nama_user',
    'role',
    'aktivitas',
    'keterangan',
    'created_at',
    'deleted_at',
    'deleted_by'
    ];
}
