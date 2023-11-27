<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('subscription_fasilitas', function (Blueprint $table) {
            $table->foreignId('id_paket_membership')->constrained('paket_membership');
            $table->foreignId('id_fasilitas')->constrained('fasilitas');
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('subscription_fasilitas');
    }
};
