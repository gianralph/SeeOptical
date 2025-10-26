<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ExpenseType;
use App\Models\LineItemBudget;
use Inertia\Inertia;
use DB; 

class LineItemBudgetController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $expenselineitem = LineItemBudget::select(
            'expenselineitems.*',
            DB::raw("IF(expenselineitems.status = 'A', 'Active', 'Inactive') AS statustext"),
            DB::raw("getemployeename(b.employeeid, 'fl') AS createdby"),
            DB::raw("getemployeename(c.employeeid, 'fl') AS updatedby"), 
            'expensetypes.expensetype as expensetype',
            'expenselineitems.created_at as datecreated',
            'expenselineitems.updated_at as dateupdated'
        )
        ->leftJoin('users as b', 'expenselineitems.created_by', 'b.id')
        ->leftJoin('users as c', 'expenselineitems.updated_by', 'c.id')
        ->leftJoin('expensetypes', 'expenselineitems.expensetypeid', 'expensetypes.id')
        ->where('expenselineitems.status', 'A')
        ->orderBy('expenselineitems.expenselineitem')
        ->get();
        
        $expensetypes = ExpenseType::where('status', 'A')->get();
    
        return Inertia::render('LineItemBudgets', ['expenselineitems' => $expenselineitem, 'expensetypes' => $expensetypes]);
    }
    

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    // public function store(Request $request)
    // {
    //     $json = file_get_contents('php://input');
    //     $data = json_decode($json, true);

    //     $id = $data['params']['id'] ?? null; 
    //     $description = $data['params']['fund'] ?? null; 
    //     $status = $data['params']['status'] ?? null; 

    //         $article = FundCluster::create([
    //             'fund' => $description,     
    //             'status' =>substr($status, 0, 1),
    //             'created_by' => auth()->id(),// Variable or value for the 'created_by' column
    //                      // Status value
    //         ]);
    // }
    public function store(Request $request)
    {
        // dd($request->input('fund'));
        $article = LineItemBudget::create([

            'expenselineitem' => $request->expenselineitem,
            'status' =>  substr($request->status, 0, 1),
            'expensetypeid' => $request->expensetypeid,
            'uacscode'=> $request->uacscode,
            'created_by' => auth()->id(), // Automatically fetch the authenticated user's ID
        ]);
    }
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        // Find the record by ID
        $article = LineItemBudget::findOrFail($id);
    
        // Update the record with the provided data
        $article->update([
            'expenselineitem' => $request->expenselineitem,
            'status' => substr($request->status, 0, 1),
            'expensetypeid' => $request->expensetypeid,
            'uacscode' => $request->uacscode,
            'updated_by' => auth()->id(), // Automatically fetch the authenticated user's ID
        ]);
    }
    

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
