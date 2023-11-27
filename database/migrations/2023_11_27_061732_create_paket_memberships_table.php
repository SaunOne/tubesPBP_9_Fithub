<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('paket_membership', function (Blueprint $table) {
            $table->id();
            $table->string('nama_membership');
            $table->integer('harga');
            $table->string('subscription');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('paket_membership');
    }
};
