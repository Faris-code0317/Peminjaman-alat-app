<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Models\LogAktivitas;




class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        $user = User::where('username', $request->username)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'message' => 'Username atau password salah'
            ], 401);
        }

         if ($user->role !== 'peminjam') {
             return response()->json([
                 'message' => 'Username atau password salah'
             ], 401);
         }

        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json([
            'message' => 'Login berhasil',
            'token'   => $token,
            'user'    => $user
        ]);
    }

    public function register(Request $request)
    {
        $request->validate([
            'nama_lengkap' => 'required|string|max:100',
            'username'     => 'required|string|unique:tb_user,username',
            'password'     => 'required|string|min:6|confirmed'
        ]);

        DB::beginTransaction();

        try {

            $user = User::create([
                'nama_lengkap' => $request->nama_lengkap,
                'username'     => $request->username,
                'password'     => Hash::make($request->password),
                'role'         => 'peminjam'
            ]);

            // ✅ Simpan log aktivitas
            LogAktivitas::create([
                'id_user'   => $user->id_user,
                'nama_user' => $user->nama_lengkap,
                'role'      => $user->role,
                'aktivitas' => 'Registrasi Akun',
                'keterangan'=> 'User baru melakukan registrasi',
                'created_at'=> Carbon::now('Asia/Jakarta')
            ]);

            DB::commit();

            return response()->json([
                'message' => 'Registrasi berhasil, silakan login'
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'error' => $e->getMessage()
            ], 400);
        }
    }

    // public function register(Request $request)
    // {
    //     $request->validate([
    //         'nama_lengkap' => 'required|string|max:100',
    //         'username'     => 'required|string|unique:tb_user,username',
    //         'password'     => 'required|string|min:6|confirmed'
    //     ]);

    //     $user = User::create([
    //         'nama_lengkap' => $request->nama_lengkap,
    //         'username'     => $request->username,
    //         'password'     => Hash::make($request->password),
    //         'role'         => 'peminjam'
    //     ]);

    //     return response()->json([
    //         'message' => 'Registrasi berhasil',
    //         'user'    => $user
    //     ], 201);
    // }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logout berhasil, token tidak berlaku lagi'
        ]);
    }

}
