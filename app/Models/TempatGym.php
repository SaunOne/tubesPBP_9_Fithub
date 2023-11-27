<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TempatGym extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_tempat',
        'domisili',
        'lokasi',
        'open',
        'close',
        'phone',
        'rating',
    ];

    // Tambahkan relasi dengan tabel Trainer, jika diperlukan
    public function trainers()
    {
        return $this->hasMany(Trainer::class, 'id_lokasi');
    }
}
