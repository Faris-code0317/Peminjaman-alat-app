<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Carbon\Carbon;
use App\Models\LogAktivitas;


class UserApiController extends Controller
{
    public function me(Request $request)
    {
        return response()->json([
            'success' => true,
            'data' => $request->user()
        ]);
    }

    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'nama_lengkap' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:tb_user,username,'
                . $user->id_user . ',id_user',
        ]);

        $user->update([
            'nama_lengkap' => $request->nama_lengkap,
            'username' => $request->username,
        ]);

        LogAktivitas::create([
            'id_user'   => $user->id_user,
            'nama_user' => $user->nama_lengkap,
            'role'      => $user->role,
            'aktivitas' => 'Update Profile',
            'keterangan'=> 'Mengubah data profile',
            'created_at'=> Carbon::now('Asia/Jakarta')
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Profile berhasil diperbarui',
            'data' => $user
        ]);
    }

    public function changePassword(Request $request)
    {
        $request->validate([
            'old_password' => 'required',
            'new_password' => 'required|min:6',
        ]);

        $user = $request->user();

        if (!Hash::check($request->old_password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Password lama salah'
            ], 400);
        }

        $user->update([
            'password' => Hash::make($request->new_password)
        ]);

        LogAktivitas::create([
            'id_user'   => $user->id_user,
            'nama_user' => $user->nama_lengkap,
            'role'      => $user->role,
            'aktivitas' => 'Mengubah password',
            'keterangan'=> 'User mengubah password akun',
            'created_at'=> Carbon::now('Asia/Jakarta')
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Password berhasil diubah'
        ]);
    }
}
