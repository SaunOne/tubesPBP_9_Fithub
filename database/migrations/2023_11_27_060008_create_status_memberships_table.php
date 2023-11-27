<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('status_membership', function (Blueprint $table) {
            $table->id();
            $table->enum('status', ['AKTIF', 'NONAKTIF']);
            $table->foreignId('id_member')->constrained('users');
            $table->date('tanggal_mulai');
            $table->date('tanggal_berakhir')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('status_member');
    }
};
