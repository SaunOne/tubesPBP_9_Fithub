<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('history', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_user')->constrained('users');
            $table->foreignId('id_tempat_gym')->constrained('tempat_gym');
            $table->dateTime('waktu_mulai_latihan');
            $table->dateTime('waktu_selesai_latihan');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('history');
    }
};
