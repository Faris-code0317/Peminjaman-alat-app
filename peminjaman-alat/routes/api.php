
<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\KategoriController;
use App\Http\Controllers\Api\AlatController;
use App\Http\Controllers\Api\PeminjamanController;
use App\Http\Controllers\Api\AuthController;

Route::post('/login', [AuthController::class, 'login']);

Route::put('/peminjaman/{id}/setujui', [PeminjamanController::class, 'setujui']);
Route::put('/peminjaman/{id}/kembalikan', [PeminjamanController::class, 'kembalikan']);
Route::get('/peminjaman/{id}', [PeminjamanController::class, 'show']);


Route::get('/kategori', [KategoriController::class, 'index']);
Route::post('/kategori', [KategoriController::class, 'store']);
Route::get('/kategori/{id}', [KategoriController::class, 'show']);
Route::put('/kategori/{id}', [KategoriController::class, 'update']);
Route::delete('/kategori/{id}', [KategoriController::class, 'destroy']);

Route::get('/alat', [AlatController::class, 'index']);
Route::post('/alat', [AlatController::class, 'store']);
Route::get('/alat/{id}', [AlatController::class, 'show']);
Route::put('/alat/{id}', [AlatController::class, 'update']);
Route::delete('/alat/{id}', [AlatController::class, 'destroy']);

Route::get('/peminjaman', [PeminjamanController::class, 'index']);
Route::post('/peminjaman', [PeminjamanController::class, 'store']);
Route::put('/peminjaman/{id}/kembali', [PeminjamanController::class, 'kembali']);

Route::get(
    '/peminjaman/user/{id_user}',
    [PeminjamanController::class, 'byUser']
);

