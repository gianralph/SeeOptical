<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\Section;
use Illuminate\Http\Request;
use Inertia\Inertia;
use DB;

class EmployeeController extends Controller
{
    public function index()
    {
        $employees = Employee::all();
        
        $sections = Section::select('sections.id', DB::raw("CONCAT(divisions.division, ' / ', sections.section) AS description"))
        // ->leftJoin('divisions', function ($join) {
        //     $join->on('sections.divisionid', '=', 'divisions.id')
        //          ->where('sections.status', '=', 'A')
        //          ->where('divisions.status','A');
        // })
        ->leftJoin('divisions','sections.divisionid','divisions.id')
        ->where('divisions.status', 'A')
        ->where('sections.status', 'A')
        ->get();


        return Inertia::render('Employees', ['employees' => $employees,'sections' => $sections]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'lastname' => 'required|string|max:255',
            'firstname' => 'required|string|max:255',
            'middlename' => 'nullable|string|max:255',
            'suffix' => 'nullable|string|max:255',
            // 'position' => 'required|string|max:255',
            'status' => 'required|string|max:255',
        ]);

        Employee::create([
            'lastname' => $request->lastname,
            'firstname' => $request->firstname,
            'middlename' => $request->middlename,
            'suffix' => $request->suffix,
            'position' => $request->position,
            'sectionid' => $request->sectionid,
            'status' => $request->status,
            'created_by' => auth()->id(),
            'updated_by' => auth()->id(),
        ]);



        return redirect()->route('employees.index');
    }

    public function update(Request $request, Employee $employee)
    {
        $request->validate([
            'lastname' => 'required|string|max:255',
            'firstname' => 'required|string|max:255',
            'middlename' => 'nullable|string|max:255',
            'suffix' => 'nullable|string|max:255',
            'position' => 'required|string|max:255',
            'status' => 'required|string|max:255',
        ]);

        $employee->update([
            'lastname' => $request->lastname,
            'firstname' => $request->firstname,
            'middlename' => $request->middlename,
            'suffix' => $request->suffix,
            'position' => $request->position,
            'sectionid' => $request->sectionid,
            'status' => $request->status,
            'updated_by' => auth()->id(),
        ]);

        return redirect()->route('employees.index');
    }

    public function destroy(Employee $employee)
    {
        $employee->delete();

        return redirect()->route('employees.index');
    }
}
