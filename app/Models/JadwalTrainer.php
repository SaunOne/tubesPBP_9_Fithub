<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class JadwalTrainer extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_trainer',
        'hari',
    ];

    // Tambahkan relasi dengan tabel Trainer
    public function trainer()
    {
        return $this->belongsTo(Trainer::class, 'id_trainer');
    }
}
