<?php

use App\Models\LogAktivitas;

if (!function_exists('logAktivitas')) {
    function logAktivitas($user, $aktivitas, $keterangan = null)
    {
        LogAktivitas::create([
            'id_user'    => $user->id_user ?? null,
            'nama_user'  => $user->nama_lengkap ?? 'System',
            'role'       => $user->role ?? 'system',
            'aktivitas'  => $aktivitas,
            'keterangan' => $keterangan,
            'created_at' => now()
        ]);
    }
}
