<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pap extends Model
{
    use HasFactory;
    protected $table = 'paps';
    protected $fillable = ['pap','acronym','uacscode','created_by','updated_by','status'];
}
