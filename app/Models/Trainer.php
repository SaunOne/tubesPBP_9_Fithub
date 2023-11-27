<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Trainer extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_lokasi',
        'experient',
        'age',
        'visi',
        'rating',
        'status',
    ];

    public function lokasi()
    {
        return $this->belongsTo(TempatGym::class, 'id_lokasi');
    }

    // Tambahkan relasi dengan tabel JadwalTrainer, jika diperlukan
    public function jadwalTrainers()
    {
        return $this->hasMany(JadwalTrainer::class, 'id_trainer');
    }
}
