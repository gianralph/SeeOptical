<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\User;

use App\Http\Controllers\API\ChartController;
use App\Http\Controllers\API\DivisionController;
use App\Http\Controllers\API\SectionController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
Route::post('/sanctum/token', function (Request $request) {
    $request->validate([
        'email' => 'required',
        'password' => 'required',
        'device_name' => 'required',
    ]);

    $user = User::where('email', $request->email)->first();

    if (! $user || ! Hash::check($request->password, $user->password)) {
        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }

    return $user->createToken($request->device_name)->plainTextToken;
});


Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    
    Route::apiResource('divisions', DivisionController::class);
    Route::apiResource('sections', SectionController::class);







    Route::get('/getPpeAssignmentCount', [AssignmentController::class, 'getPpeAssignmentCount']);
    

    Route::get('/loaddivisions', [DivisionController::class, 'loaddivisions']);
    Route::get('/loadsections', [SectionController::class, 'loadsections']);


    Route::get('/ppedata', [ChartController::class, 'getPPEData']);
    Route::get('/getdailytransactions', [ChartController::class, 'getdailytransactions']);
    Route::get('/getmyppeunits', [ChartController::class, 'getmyppeunits']);
    Route::get('/getmyppevaluation', [ChartController::class, 'getmyppevaluation']);
    Route::get('/getppecount', [ChartController::class, 'getppecount']);
    Route::get('/getPast7DaysTransactionCounts', [ChartController::class, 'getPast7DaysTransactionCounts']);
    Route::get('/getPpeCountGroupedPerCondition', [ChartController::class, 'getPpeCountGroupedPerCondition']);
    Route::get('/getPpeRecentAcquisitions', [ChartController::class, 'getPpeRecentAcquisitions']);
    Route::get('/getPpeStatusList', [ChartController::class, 'getPpeStatusList']);
    

    
});










