<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\KategoriController;
use App\Http\Controllers\Api\AlatController;
use App\Http\Controllers\Admin\LogAktivitasController;
use App\Http\Controllers\Api\PeminjamanController;

/*
|--------------------------------------------------------------------------
| AUTH
|--------------------------------------------------------------------------
*/
Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

/*
|--------------------------------------------------------------------------
| PROTECTED (HARUS LOGIN)
|--------------------------------------------------------------------------
*/
Route::middleware('auth:sanctum')->group(function () {

    // ================= USER =================
    Route::get('/alat', [AlatController::class, 'index']);
    Route::post('/peminjaman', [PeminjamanController::class, 'store']);
    Route::get('/peminjaman/user/{id}', [PeminjamanController::class, 'byUser']);

    // ================= PETUGAS / ADMIN =================
    Route::put('/peminjaman/{id}/setujui', [PeminjamanController::class, 'setujui']);
    Route::put('/peminjaman/{id}/kembalikan', [PeminjamanController::class, 'kembalikan']);

    // ================= ADMIN ONLY =================
    Route::middleware('role:admin')->group(function () {

        // KATEGORI
        Route::apiResource('/kategori', KategoriController::class);

        Route::post('/alat', [AlatController::class, 'store']);
        Route::put('/alat/{id}', [AlatController::class, 'update']);
        Route::delete('/alat/{id}', [AlatController::class, 'destroy']);
        // LOG
        Route::get('/log-aktivitas', [LogAktivitasController::class, 'index']);
    });
});


//
//<?php

//use Illuminate\Support\Facades\Route;
//use App\Http\Controllers\Api\KategoriController;
//use App\Http\Controllers\Api\AlatController;
//use App\Http\Controllers\Api\PeminjamanController;
//use App\Http\Controllers\Api\AuthController;
//
//Route::post('/login', [AuthController::class, 'login']);
//
//Route::put('/peminjaman/{id}/setujui', [PeminjamanController::class, 'setujui']);
//Route::put('/peminjaman/{id}/kembalikan', [PeminjamanController::class, 'kembalikan']);
//Route::get('/peminjaman/{id}', [PeminjamanController::class, 'show']);
//
//
//Route::get('/kategori', [KategoriController::class, 'index']);
//Route::post('/kategori', [KategoriController::class, 'store']);
//Route::get('/kategori/{id}', [KategoriController::class, 'show']);
//Route::put('/kategori/{id}', [KategoriController::class, 'update']);
//Route::delete('/kategori/{id}', [KategoriController::class, 'destroy']);
//
//Route::get('/alat', [AlatController::class, 'index']);
//Route::post('/alat', [AlatController::class, 'store']);
//Route::get('/alat/{id}', [AlatController::class, 'show']);
//Route::put('/alat/{id}', [AlatController::class, 'update']);
//Route::delete('/alat/{id}', [AlatController::class, 'destroy']);
//
//Route::get('/peminjaman', [PeminjamanController::class, 'index']);
//Route::post('/peminjaman', [PeminjamanController::class, 'store']);
//Route::put('/peminjaman/{id}/kembali', [PeminjamanController::class, 'kembali']);
//
//Route::get(
//    '/peminjaman/user/{id_user}',
//    [PeminjamanController::class, 'byUser']
//);

