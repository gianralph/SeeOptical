<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Division;
use Inertia\Inertia;
use DB; 

class DivisionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $items = Division::select('divisions.*',DB::raw("IF(divisions.STATUS = 'A', 'Active', 'Inactive') AS statustext"),
        'divisions.division as description',
        DB::raw("getemployeename(b.employeeid, 'fl') AS createdby"),
        DB::raw("getemployeename(b.employeeid, 'fl') AS updatedby"), 
        'divisions.created_at as datecreated',
        'divisions.updated_at as dateupdated',
        )
        ->leftJoin('users as b', 'divisions.created_by','b.id')
        ->leftJoin('users as c', 'divisions.updated_by','c.id')
        ->where('divisions.status', 'A')
        ->orderBy('division')
        ->get();   
        
        return Inertia::render('Divisions', ['items' => $items]);
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
    public function store(Request $request)
    {
        $json = file_get_contents('php://input');
        $data = json_decode($json, true);

        $id = $data['params']['id'] ?? null; 
        $description = $data['params']['description'] ?? null; 
        $status = $data['params']['status'] ?? null; 

        if ($id === '') {
            $article = Division::create([
                'division' => $description,     
                'status' =>substr($status, 0, 1),
                'created_by' => auth()->id(),// Variable or value for the 'created_by' column
                         // Status value
            ]);
        }
        else{
            $article = Division::where('id', $id)->update([
                'division' => $description,
                'status' => substr($status, 0, 1),
                'updated_by' => auth()->id(),
            ]);
        }
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
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
