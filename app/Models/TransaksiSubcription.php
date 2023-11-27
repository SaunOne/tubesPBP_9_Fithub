<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransaksiSubscription extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_user',
        'id_paket_membership',
        'tanggal',
        'id_metode_pembayaran',
    ];

    // Tambahkan relasi dengan tabel User, jika diperlukan
    public function user()
    {
        return $this->belongsTo(User::class, 'id_user');
    }

    // Tambahkan relasi dengan tabel PaketMembership, jika diperlukan
    public function paketMembership()
    {
        return $this->belongsTo(PaketMembership::class, 'id_paket_membership');
    }

    // Tambahkan relasi dengan tabel MetodePembayaran, jika diperlukan
    public function metodePembayaran()
    {
        return $this->belongsTo(MetodePembayaran::class, 'id_metode_pembayaran');
    }
}
