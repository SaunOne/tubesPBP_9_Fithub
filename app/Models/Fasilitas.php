<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Fasilitas extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_fasilitas',
    ];

    // Tambahkan relasi dengan tabel SubscriptionFasilitas, jika diperlukan
    public function subscriptionFasilitas()
    {
        return $this->hasMany(SubscriptionFasilitas::class, 'id_fasilitas');
    }
}
