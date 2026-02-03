<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model; // ⬅️ INI YANG KURANG

class User extends Model
{
    protected $table = 'tb_user';
    protected $primaryKey = 'id_user';
    public $timestamps = false;

    protected $fillable = [
        'nama_lengkap',
        'username',
        'password',
        'role'
    ];
}
