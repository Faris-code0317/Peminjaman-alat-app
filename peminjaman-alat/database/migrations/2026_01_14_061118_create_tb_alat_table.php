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
        Schema::create('tb_alat', function (Blueprint $table) {
        $table->id('id_alat');
        $table->string('nama_alat', 100);
        $table->integer('stok');
        $table->unsignedBigInteger('id_kategori');
    
        $table->foreign('id_kategori')
              ->references('id_kategori')
              ->on('tb_kategori')
              ->onDelete('restrict');
    });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tb_alat');
    }
};
