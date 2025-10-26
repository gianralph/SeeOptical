<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FundCluster extends Model
{
    use HasFactory;
    protected $table = 'funds';
    protected $fillable = ['fund','amount','iscontinuing','fundyear','created_by','updated_by','status'];
}
