<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\LoginController;
use App\Http\Controllers\Admin\KategoriController;
use App\Http\Controllers\Admin\AlatController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\PeminjamanAdminController;
use App\Http\Controllers\Petugas\PetugasController;
use App\Http\Controllers\Admin\LogAktivitasController;



/*
|--------------------------------------------------------------------------
| LOGIN
|--------------------------------------------------------------------------
*/
Route::get('/login', [LoginController::class, 'form'])->name('login');
Route::post('/login', [LoginController::class, 'login']);

/*
|--------------------------------------------------------------------------
| ADMIN
|--------------------------------------------------------------------------
*/
Route::middleware(['login', 'admin'])->group(function () {

    Route::get('/admin', function () {
        return view('admin.index');
    });

    Route::get('/admin/table', function () {
        return view('admin.alat');
    });

    // KATEGORI
    Route::resource('/admin/kategori', KategoriController::class)->except(['show']);

    // ALAT
    Route::resource('/admin/alat', AlatController::class)->except(['show']);

    // USER
    Route::resource('/admin/user', UserController::class)->except(['show']);

    // PEMINJAMAN
    Route::get('/admin/peminjaman/aktif', [PeminjamanAdminController::class, 'aktif']);
    Route::get('/admin/peminjaman/selesai', [PeminjamanAdminController::class, 'selesai']);
    Route::delete('/admin/peminjaman/{id}', [PeminjamanAdminController::class, 'destroy']);

    Route::get('/admin/log-aktivitas', [LogAktivitasController::class, 'index'])
        ->name('admin.log.index');
    Route::delete('/admin/log-aktivitas/{id}',[LogAktivitasController::class, 'destroy']
        )->name('admin.log.destroy');
    Route::get('/admin/log-cache', [LogAktivitasController::class, 'cache'])
        ->name('admin.log.cache');
    Route::get('/admin/log-cache', [LogAktivitasController::class, 'indexCache'])
    ->name('admin.logcache.index');
});

/*
|--------------------------------------------------------------------------
| PETUGAS
|--------------------------------------------------------------------------
*/
Route::middleware(['login', 'petugas'])->group(function () {

    Route::get('/petugas', function () {
        return view('petugas.index');
    });

    Route::get('/petugas/alat', [PetugasController::class, 'alat']);
    Route::get('/petugas/peminjaman', [PetugasController::class, 'peminjaman'])->name('petugas.peminjaman');
    Route::post('/petugas/peminjaman/{id}/setujui', [PetugasController::class, 'setujui']);
    Route::post('/petugas/peminjaman/{id}/tolak', [PetugasController::class, 'tolak']);

    Route::get('/petugas/peminjaman-aktif', [PetugasController::class, 'peminjamanAktif'])->name('petugas.peminjaman.aktif');
    Route::post('/petugas/peminjaman-aktif/{id}/kembalikan', [PetugasController::class, 'kembalikan']);

    Route::get('/petugas/peminjaman-selesai', [PetugasController::class, 'peminjamanSelesai'])->name('petugas.peminjaman.selesai');
});



/*
|--------------------------------------------------------------------------
| HOME
|--------------------------------------------------------------------------
*/
Route::get('/', function () {
    return view('welcome');
});
