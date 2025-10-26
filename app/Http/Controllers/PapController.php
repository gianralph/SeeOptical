<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Division;
use App\Models\FundCluster;
use App\Models\Pap;
use Inertia\Inertia;
use DB; 

class PapController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $pap = Pap::select(
            'paps.*',
            DB::raw("IF(paps.status = 'A', 'Active', 'Inactive') AS statustext"),
            DB::raw("getemployeename(b.employeeid, 'fl') AS createdby"),
            DB::raw("getemployeename(c.employeeid, 'fl') AS updatedby"), 
            'paps.created_at as datecreated',
            'paps.updated_at as dateupdated'
        )
        ->leftJoin('users as b', 'paps.created_by', 'b.id')
        ->leftJoin('users as c', 'paps.updated_by', 'c.id')
        ->where('paps.status', 'A')
        ->orderBy('paps.pap')
        ->get();
    
        return Inertia::render('Paps', ['paps' => $pap]);
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
        $article = Pap::create([

            'pap' => $request->pap,
            'status' =>  substr($request->status, 0, 1),
            'acronym' => $request->acronym,
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
        $article = Pap::findOrFail($id);
    
        // Update the record with the provided data
        $article->update([
            'pap' => $request->pap,
            'status' => substr($request->status, 0, 1),
            'acronym' => $request->acronym,
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
