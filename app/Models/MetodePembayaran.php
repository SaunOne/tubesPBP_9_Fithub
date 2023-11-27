<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MetodePembayaran extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_metode_pembayaran',
    ];

    // Tambahkan relasi dengan tabel TransaksiSubscription, jika diperlukan
    public function transaksiSubscriptions()
    {
        return $this->hasMany(TransaksiSubscription::class, 'id_metode_pembayaran');
    }
}
