<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExpenseType extends Model
{
    use HasFactory;
    protected $table = 'expensetypes';
    protected $fillable = ['expensetype','acronym','created_by','updated_by','status'];
}
