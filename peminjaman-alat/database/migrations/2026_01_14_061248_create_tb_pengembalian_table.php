<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('tb_pengembalian', function (Blueprint $table) {
        $table->id('id_pengembalian');
        $table->unsignedBigInteger('id_peminjaman')->unique();
        $table->timestamp('tanggal_kembali');
    
        $table->foreign('id_peminjaman')
              ->references('id_peminjaman')
              ->on('tb_peminjaman')
              ->onDelete('cascade');
    });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_pengembalian');
    }
};
