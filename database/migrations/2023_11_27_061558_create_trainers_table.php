<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('trainer', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_lokasi')->constrained('tempat_gym');
            $table->string('experient');
            $table->integer('age');
            $table->text('visi');
            $table->integer('rating');
            $table->enum('status', ['FREE', 'MEMBER']);
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('trainer');
    }
};
