<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Division;
use App\Models\FundCluster;
use Inertia\Inertia;
use DB; 

class FundclusterController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $fund = FundCluster::select(
            'funds.*',
            DB::raw("IF(funds.status = 'A', 'Active', 'Inactive') AS statustext"),
            DB::raw("getemployeename(b.employeeid, 'fl') AS createdby"),
            DB::raw("getemployeename(c.employeeid, 'fl') AS updatedby"), 
            'funds.created_at as datecreated',
            'funds.updated_at as dateupdated'
        )
        ->leftJoin('users as b', 'funds.created_by', 'b.id')
        ->leftJoin('users as c', 'funds.updated_by', 'c.id')
        ->where('funds.status', 'A')
        ->orderBy('funds.fund')
        ->get();
    
        return Inertia::render('FundClusters', ['funds' => $fund]);
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
        $article = FundCluster::create([

            'fund' => $request->fund,
            'status' =>  substr($request->status, 0, 1),
            'fundyear' => $request->fundyear,
            'amount'=> $request->amount,
            'iscontinuing' => $request->iscontinuing ? '1' : '0',
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
        $article = FundCluster::findOrFail($id);
    
        // Update the record with the provided data
        $article->update([
            'fund' => $request->fund,
            'status' => substr($request->status, 0, 1),
            'fundyear' => $request->fundyear,
            'amount' => $request->amount,
            'iscontinuing' => $request->iscontinuing ? '1' : '0',
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
