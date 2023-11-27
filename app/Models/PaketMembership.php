<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PaketMembership extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_membership',
        'harga',
        'subscription',
    ];

    // Tambahkan relasi dengan tabel TransaksiSubscription, jika diperlukan
    public function transaksiSubscriptions()
    {
        return $this->hasMany(TransaksiSubscription::class, 'id_paket_membership');
    }

    // Tambahkan relasi dengan tabel SubscriptionFasilitas, jika diperlukan
    public function subscriptionFasilitas()
    {
        return $this->hasMany(SubscriptionFasilitas::class, 'id_paket_membership');
    }
}
