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
        Schema::create('tb_peminjaman', function (Blueprint $table) {
        $table->id('id_peminjaman');
        $table->unsignedBigInteger('id_user');
        $table->timestamp('tanggal_pinjam');
        $table->string('status', 20);
    
        $table->foreign('id_user')
              ->references('id_user')
              ->on('tb_user')
              ->onDelete('cascade');
    });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_peminjaman');
    }
};
