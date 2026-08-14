<?php

use App\Events\UserUpdated;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\VisitController;
use App\Http\Controllers\PatientController;


// use App\Http\Controllers\ChartController;

Route::get('/', function () {
    return Inertia::render('Auth/Login', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});


Route::get('/test-broadcast', function () {
    $users = \App\Models\User::all();
    broadcast(new UserUpdated($users));
    return 'Broadcast test sent!';
});


Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return Inertia::render('Dashboard');
    })->name('dashboard');

    Route::get('/employees', function () {
        return Inertia::render('Employees');
    })->name('employees');
Route::post('/patients', [PatientController::class, 'store'])
    ->name('patients.store');

    Route::get('/patients', [PatientController::class, 'index'])
    ->name('patients.index');

Route::get('/patients/{id}', [PatientController::class, 'show'])
    ->name('patients.show');


    
 
   

Route::get(
    '/visits/patient/{patientId}/latest',
    [VisitController::class, 'latestPatientVisit']
)->name('visits.patient.latest');


    Route::resource('employees', EmployeeController::class);
    Route::resource('visits', VisitController::class);
    // Route::resource('clients', ClientController::class);
    // Route::resource('ppes', PPEController::class);
    // Route::resource('myppes', MyppeController::class);
    // Route::resource('transactions', TransactionController::class);
    // Route::resource('articles', ArticleController::class);
    // Route::resource('statuslists', StatuslistController::class);
    // Route::resource('locations', LocationController::class);
    // Route::resource('ppetypes', PpetypeController::class);
    // Route::resource('mytransactions', MytransactionController::class);
    // Route::resource('brands', BrandController::class);
    // // Route::resource('fundclusters', FundclusterController::class);
    // Route::resource('suppliers', SupplierController::class);
    // Route::resource('unitofmeasurements', UnitofmeasurementController::class);
    // Route::resource('signatories', SignatoryController::class);
    // Route::resource('inventories', InventoryController::class);
    // Route::resource('returnreceipts', ReturnreceiptController::class);
    // Route::resource('documenttracker', DocumentController::class);
    // Route::resource('iirup', IirupController::class);
    // Route::resource('divisions', DivisionController::class);
    // Route::resource('sections', SectionController::class);
    // Route::resource('ppesettings', PpesettingController::class);
    // Route::resource('fundclusters', FundclusterController::class);
    // Route::resource('paps', PapController::class);
    // Route::resource('expensetypes', ExpenseTypeController::class);
    // Route::resource('expenselineitems', LineItemBudgetController::class);









});
Route::group(['middleware' => 'administrator'], function () {
    Route::get('/users', function () {
        return Inertia::render('Users');
    })->name('users');
    Route::resource('users', UserController::class);
});



