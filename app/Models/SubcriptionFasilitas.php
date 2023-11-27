<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SubscriptionFasilitas extends Model
{
    use HasFactory;

    protected $table = 'subscription_fasilitas';

    protected $fillable = [
        'id_paket_membership',
        'id_fasilitas',
    ];

    // Tambahkan relasi dengan tabel PaketMembership, jika diperlukan
    public function paketMembership()
    {
        return $this->belongsTo(PaketMembership::class, 'id_paket_membership');
    }

    // Tambahkan relasi dengan tabel Fasilitas, jika diperlukan
    public function fasilitas()
    {
        return $this->belongsTo(Fasilitas::class, 'id_fasilitas');
    }
}
