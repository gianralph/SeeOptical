<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Visit extends Model
{
    protected $table = 'visits';

    protected $fillable = [
        'patient_id',
        'doctor_id',
        'visit_date',
        'visit_time',
        'visit_type',
        'chief_complaint',
        'visual_acuity_od',
        'visual_acuity_os',
        'iop_od',
        'iop_os',
        'external_exam',
        'anterior_segment',
        'fundus_exam',
        'other_findings',
        'diagnosis',
        'treatment',
        'notes',
        'follow_up_date',
    ];

    protected $casts = [
        'visit_date' => 'date',
        'follow_up_date' => 'date',
        'iop_od' => 'decimal:2',
        'iop_os' => 'decimal:2',
    ];

    public function patient(): BelongsTo
    {
        return $this->belongsTo(Patient::class);
    }

    public function doctor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'doctor_id');
    }
}