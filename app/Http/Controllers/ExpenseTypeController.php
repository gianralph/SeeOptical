<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Division;
use App\Models\ExpenseType;
use Inertia\Inertia;
use DB; 

class ExpenseTypeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $expensetype = ExpenseType::select(
            'expensetypes.*',
            DB::raw("IF(expensetypes.status = 'A', 'Active', 'Inactive') AS statustext"),
            DB::raw("getemployeename(b.employeeid, 'fl') AS createdby"),
            DB::raw("getemployeename(c.employeeid, 'fl') AS updatedby"), 
            'expensetypes.created_at as datecreated',
            'expensetypes.updated_at as dateupdated'
        )
        ->leftJoin('users as b', 'expensetypes.created_by', 'b.id')
        ->leftJoin('users as c', 'expensetypes.updated_by', 'c.id')
        ->where('expensetypes.status', 'A')
        ->orderBy('expensetypes.expensetype')
        ->get();
    
        return Inertia::render('ExpenseTypes', ['expensetypes' => $expensetype]);
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
        $article = ExpenseType::create([

            'expensetype' => $request->expensetype,
            'status' =>  substr($request->status, 0, 1),
            'acronym' => $request->acronym,
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
        $article = ExpenseType::findOrFail($id);
    
        // Update the record with the provided data
        $article->update([
            'expensetype' => $request->expensetype,
            'status' => substr($request->status, 0, 1),
            'acronym' => $request->acronym,
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
