<?php

namespace App\Http\Controllers\Web;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class LoginController extends Controller
{
    public function form()
    {
        return view('welcome');
    }

    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);

        $user = User::where('username', $request->username)
            ->where('password', $request->password)
            ->first();

        if (!$user) {
            return back()->with('error', 'Login gagal');
        }

        session(['user' => $user]);

        if ($user->role === 'admin') {
            return redirect('/admin');
        }

        if ($user->role === 'petugas') {
            return redirect('/petugas');
        }

        return redirect('/login');
    }
}

