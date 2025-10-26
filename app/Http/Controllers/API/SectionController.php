<?php

namespace App\Http\Controllers\API;


use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Section;
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
        ->orderBy('section')
        ->get();   

        return $items;
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
        //
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
        
            $items = Section::where('id', $id)->update([
                'status' => 'I',
                'updated_by' => auth()->id(),
            ]);
            return $items;
    }

    public function loadsections(Request $request) {

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
        
        return $items;
    }

}
