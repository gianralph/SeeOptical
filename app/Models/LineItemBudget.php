<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class LineItemBudget extends Model
{
    use HasFactory;
    protected $table = 'expenselineitems';
    protected $fillable = ['expenselineitem','expensetypeid','uacscode','created_by','updated_by','status'];
}
