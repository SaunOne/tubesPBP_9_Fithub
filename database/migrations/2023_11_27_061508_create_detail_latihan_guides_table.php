<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('detail_latihan_guide', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_guide')->constrained('guide_gym');
            $table->string('nama_gerakan');
            $table->integer('durasi');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('detail_latihan_guide');
    }
};
