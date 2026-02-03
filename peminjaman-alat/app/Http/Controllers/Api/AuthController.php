<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        $user = User::where('username', $request->username)
            ->where('password', $request->password) // sementara (belum hash)
            ->first();

        if (!$user) {
            return response()->json([
                'message' => 'Login gagal'
            ], 401);
        }

        return response()->json([
            'message' => 'Login berhasil',
            'user' => $user
        ]);
    }
}
