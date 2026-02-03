<?php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable; // ⬅️ PENTING
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasApiTokens, Notifiable;

    protected $table = 'tb_user';
    protected $primaryKey = 'id_user';
    public $timestamps = false;

    protected $fillable = [
        'nama_lengkap',
        'username',
        'password',
        'role'
    ];

    protected $hidden = [
        'password'
    ];
}

