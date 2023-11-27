<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StatusMember extends Model
{
    use HasFactory;

    protected $fillable = [
        'status',
        'id_member',
        'tanggal_mulai',
        'tanggal_berakhir',
    ];

    // Tambahkan relasi dengan tabel User
    public function user()
    {
        return $this->belongsTo(User::class, 'id_member');
    }
}
