<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Section;
use App\Models\Division;
use Inertia\Inertia;
use DB; 

class SectionController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $items = Section::select('sections.*',DB::raw("IF(sections.STATUS = 'A', 'Active', 'Inactive') AS statustext"),
        'sections.section as description',
        DB::raw("getemployeename(b.employeeid, 'fl') AS createdby"),
        DB::raw("getemployeename(c.employeeid, 'fl') AS updatedby"), 
        'sections.created_at as datecreated',
        'sections.updated_at as dateupdated',
        'd.division',
        )
        ->leftJoin('users as b', 'sections.created_by','b.id')
        ->leftJoin('users as c', 'sections.updated_by','c.id')
        ->leftJoin('divisions as d','sections.divisionid','d.id')
        ->where('sections.status', 'A')
        ->orderBy('section')
        ->get();   

        $divisions = Division::select('id', 'division as description')
        ->where('status', 'A')
        ->orderBy('division')
        ->get();

        
        return Inertia::render('Sections', ['items' => $items,'divisions' => $divisions]);
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
        $divisionid = $data['params']['divisionid'] ?? null; 
        $status = $data['params']['status'] ?? null; 

        if ($id === '') {
            $article = Section::create([
                'section' => $description, 
                'divisionid' => $divisionid,     
                'status' =>substr($status, 0, 1),
                'created_by' => auth()->id(),// Variable or value for the 'created_by' column
                         // Status value
            ]);
        }
        else{
            $article = Section::where('id', $id)->update([
                'section' => $description,
                'divisionid' => $divisionid,   
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
