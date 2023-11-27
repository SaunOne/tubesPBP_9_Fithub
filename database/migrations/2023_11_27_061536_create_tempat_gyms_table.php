<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('tempat_gym', function (Blueprint $table) {
            $table->id();
            $table->string('nama_tempat');
            $table->string('domisili');
            $table->string('lokasi');
            $table->time('open');
            $table->time('close');
            $table->string('phone');
            $table->integer('rating');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('tempat_gym');
    }
};
