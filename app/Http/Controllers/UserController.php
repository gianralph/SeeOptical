<?php

namespace App\Http\Controllers;

use App\Events\UserUpdated;
use App\Models\User;
use App\Models\Area;
use Illuminate\Http\Request;
use Inertia\Inertia;
use DB;

class UserController extends Controller
{

    public function index()
    {
        $users = User::select('users.*')
            ->get();

        $employees = DB::table('employees')
            ->select('id', DB::raw("
            CONCAT(
                lastname, ', ', firstname, 
                IF(middlename IS NULL OR TRIM(middlename) = '', '', CONCAT(' ', middlename))
            ) AS description
        "))
            ->where('status', 'A')
            ->orderBy('description')
            ->get();


        return Inertia::render('Users', ['users' => $users, 'employees' => $employees]);
    }

    public function create()
    {
        return Inertia::render('Users');
    }

    public function store(Request $request)
    {
        $request->validate([
            // 'name' => 'required',
            'email' => 'required|email|unique:users',
            'password' => 'required|min:8',
        ]);

        $employeename = DB::select("SELECT getemployeename(?, ?) AS name", [$request->employeeid, 'fl']);
        $employeefullname = $employeename[0]->name;
        // dd($employeefullname);
        User::create([
            'name' => $employeefullname,
            'email' => $request->email,
            'type' => $request->type,
            'employeeid' => $request->employeeid,
            'password' => bcrypt($request->password),
        ]);

        // broadcast users after creating one :>
        $users = User::all();
        broadcast(new UserUpdated($users));

        return redirect()->route('users.index');
    }

    public function edit(User $user)
    {
        return Inertia::render('Users', ['user' => $user]);
    }

    public function update(Request $request, User $user)
    {

        $request->validate([
            // 'name' => 'required',
            'email' => 'required|email|unique:users,email,' . $user->id,
        ]);


        $employeename = DB::select("SELECT getemployeename(?, ?) AS name", [$request->employeeid, 'fl']);
        $employeefullname = $employeename[0]->name;

        // dd($employeefullname);

        User::where('id', $user->id)->update([
            'name' => $employeefullname,
            'email' => $request->email,
            'type' => $request->type,
            'employeeid' => $request->employeeid,
        ]);


        //        $data = $request->only('name', 'email','type','areaid');
        // $data = $request->only('name', 'email','type','employeeid');
        // $user->update($data);
    }

    public function destroy(User $user)
    {
        $user->delete();
        return redirect()->route('users.index');
    }
}
