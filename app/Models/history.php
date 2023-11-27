<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class History extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_user',
        'id_tempat_gym',
        'waktu_mulai_latihan',
        'waktu_selesai_latihan',
    ];

    // Tambahkan relasi dengan tabel User
    public function user()
    {
        return $this->belongsTo(User::class, 'id_user');
    }

    // Tambahkan relasi dengan tabel TempatGym
    public function tempatGym()
    {
        return $this->belongsTo(TempatGym::class, 'id_tempat_gym');
    }
}
