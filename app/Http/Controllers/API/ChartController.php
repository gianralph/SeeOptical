<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use DB;
use Illuminate\Support\Carbon;


class ChartController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
        //
    }

    public function getPPEData()
{
    $results = DB::table('ppes')
                ->select(DB::raw('COUNT(ppes.id) AS count'),
                           'ppetypes.ppetype AS ppetype',
                           'statuslist.statuslist AS statuslist')
        ->join('ppetypes', 'ppes.ppetypeid', '=', 'ppetypes.id')
        ->join('statuslist', 'ppes.ppestatusid', '=', 'statuslist.id')
        ->where('ppes.status', '=', 'A')
        ->groupBy('ppetypes.ppetype', 'statuslist.statuslist')
        ->get();

    return response()->json($results);
}

    // public function getPPEData()
    // {
    //     $result = DB::table('ppes')
    //         ->select(DB::raw('COUNT(ppes.id) as count, articles.article'))
    //         ->leftJoin('articles', 'ppes.articleid', '=', 'articles.id')
    //         ->where('ppes.status', 'A')
    //         ->groupBy('articleid')
    //         ->get();

    //     // Return the data as a JSON response
    //     return response()->json($result);
    // }


    public function getppecount()
    {

        $result = DB::table('ppes')
        ->where('status', '<>', 'C')
        ->where('status', '<>', 'I')
        ->count();

        // Return the data as a JSON response
        return $result;
    }
  


    public function getdailytransactions()
    {

        $startdate = Carbon::today()->startOfDay();
        $enddate = Carbon::today()->endOfDay();


        $result = DB::table('ppetransactions')
        ->whereBetween('created_at', [$startdate, $enddate])
        ->count();

        // Return the data as a JSON response
        return $result;
    }

    public function getmyppeunits()
    {

        $result = DB::table('ppes')
        ->where('employeeid', auth()->user()->employeeid)
        ->where('status', '<>', 'C')
        ->where('status', '<>', 'I')
        ->count();


        // Return the data as a JSON response
        return $result;
    }

    public function getmyppevaluation()
    {

        $result = DB::table('ppes')
        ->where('employeeid', auth()->user()->employeeid)
        ->where('status', '<>', 'C')
        ->where('status', '<>', 'I')
        ->sum('acquisitionamount');


        // Return the data as a JSON response
        return $result;
    }

    public function getPast7DaysTransactionCounts()
    {
        $startDate = Carbon::now()->subDays(15);
        $endDate = Carbon::now();
    
        $transactions = DB::table('ppetransactions')->select(
            DB::raw('DATE_FORMAT(created_at, "%b %d") as day'),  // %b for abbreviated month name, %d for day of the month
            DB::raw('COUNT(*) as count')
        )
        ->whereBetween('created_at', [$startDate, $endDate])
        ->groupBy(DB::raw('DATE_FORMAT(created_at, "%b %d")'))
        ->orderBy('day', 'asc')
        ->get();
    
        return response()->json($transactions);
    }


    public function getPpeCountGroupedPerCondition(Request $request)
    {

        $selectedstatus = $request->input('selectedstatus') ?? null;


        // dd($selectedstatus);
        $data = DB::table('ppes')
        ->select(DB::raw('COUNT(*) AS counter, conditions.condition'))
        ->leftJoin('conditions', 'ppes.conditionid', '=', 'conditions.id')
        ->where('ppes.status', 'A')
        ->whereIn('ppes.ppestatusid', $selectedstatus) // Add the whereIn clause
        ->groupBy('conditionid')
        ->get();

    return response()->json($data);
    }

    public function getPpeRecentAcquisitions() {
        $ppes = DB::table('ppes')
        ->select('ppes.*','articles.article as title')
        ->leftJoin('articles', 'ppes.articleid', '=', 'articles.id')
        ->where('ppes.status', 'A')
        ->orderBy('ppes.dateacquired', 'desc')
        ->limit(4)
        ->get();

        return $ppes;    
    }
    public function getPpeStatusList() {
        $status = DB::table('statuslist')->where('status', 'A')->get();
        return $status; 
    }

}
