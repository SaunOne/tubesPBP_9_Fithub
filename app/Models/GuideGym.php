<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class GuideGym extends Model
{
    use HasFactory;

    protected $fillable = [
        'nama_guide',
        'level_gerakan',
        'deskripsi',
    ];

    public function detailLatihanGuide()
    {
        return $this->hasMany(DetailLatihanGuide::class, 'id_guide');
    }
}
