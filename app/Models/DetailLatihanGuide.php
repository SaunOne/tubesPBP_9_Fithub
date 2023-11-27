<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailLatihanGuide extends Model
{
    use HasFactory;

    protected $fillable = [
        'id_guide',
        'nama_gerakan',
        'durasi',
    ];

    public function guideGym()
    {
        return $this->belongsTo(GuideGym::class, 'id_guide');
    }
}
