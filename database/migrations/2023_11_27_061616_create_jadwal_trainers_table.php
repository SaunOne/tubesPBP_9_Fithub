<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('jadwal_trainer', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_trainer')->constrained('trainer');
            $table->string('hari');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('jadwal_trainer');
    }
};
