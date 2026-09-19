<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GlassesInventory extends Model
{
    protected $table = 'glasses_inventory';

    protected $fillable = [
        'code',
        'brand',
        'model',
        'description',
        'color',
        'quantity',
        'available_quantity',
        'cost_price',
        'selling_price',
        'is_active',
    ];

    protected $casts = [
        'quantity' => 'integer',
        'available_quantity' => 'integer',
        'cost_price' => 'decimal:2',
        'selling_price' => 'decimal:2',
        'is_active' => 'boolean',
    ];
}