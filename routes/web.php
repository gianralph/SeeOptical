<?php

use App\Events\UserUpdated;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\VisitController;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\GlassesOrderController;
use App\Http\Controllers\GlassesInventoryController;
use App\Http\Controllers\ClinicDashboardController;



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
    '/glasses-inventory',
    [GlassesInventoryController::class, 'index']
)->name('glasses-inventory.index');

Route::post(
    '/glasses-inventory',
    [GlassesInventoryController::class, 'store']
)->name('glasses-inventory.store');

Route::put(
    '/glasses-inventory/{id}',
    [GlassesInventoryController::class, 'update']
)->name('glasses-inventory.update');

Route::put(
    '/glasses-inventory/{id}/toggle-status',
    [GlassesInventoryController::class, 'toggleStatus']
)->name('glasses-inventory.toggle-status');

Route::get(
    '/api/glasses-inventory/active',
    [GlassesInventoryController::class, 'active']
);

Route::get(
    '/api/glasses-inventory/{id}',
    [GlassesInventoryController::class, 'show']
);
Route::get(
    '/api/glasses-inventory',
    [GlassesInventoryController::class, 'list']
);
   

Route::get(
    '/visits/patient/{patientId}/latest',
    [VisitController::class, 'latestPatientVisit']
)->name('visits.patient.latest');



Route::get('/glasses-orders', [
    GlassesOrderController::class,
    'index'
])->name('glasses-orders.index');

Route::get('/glasses-orders/{id}/tracking', [
    GlassesOrderController::class,
    'tracking'
])->name('glasses-orders.tracking');

Route::post('/glasses-orders/{id}/status', [
    GlassesOrderController::class,
    'updateStatus'
])->name('glasses-orders.status');
Route::post(
    '/glasses-orders/{id}/return',
    [GlassesOrderController::class, 'returnOrder']
);

Route::resource('glasses-orders', GlassesOrderController::class);
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



Route::get('/dashboard', [
    ClinicDashboardController::class,
    'index'
])->name('dashboard');

Route::get('/api/dashboard/stats', [
    ClinicDashboardController::class,
    'stats'
]);

Route::get('/api/dashboard/visits-last-7-days', [
    ClinicDashboardController::class,
    'visitsLast7Days'
]);

Route::get('/api/dashboard/recent-visits', [
    ClinicDashboardController::class,
    'recentVisits'
]);

Route::get('/api/dashboard/upcoming-follow-ups', [
    ClinicDashboardController::class,
    'upcomingFollowUps'
]);

Route::get('/api/dashboard/upcoming-birthdays', [
    ClinicDashboardController::class,
    'upcomingBirthdays'
]);

Route::get('/api/dashboard/low-stock-glasses', [
    ClinicDashboardController::class,
    'lowStockGlasses'
]);

Route::get('/api/dashboard/glasses-order-summary', [
    ClinicDashboardController::class,
    'glassesOrderSummary'
]);







});
Route::group(['middleware' => 'administrator'], function () {
    Route::get('/users', function () {
        return Inertia::render('Users');
    })->name('users');
    Route::resource('users', UserController::class);
});



