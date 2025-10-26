<?php

use App\Events\UserUpdated;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\UserController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\DivisionController;
use App\Http\Controllers\SectionController;
use App\Http\Controllers\FundclusterController;
use App\Http\Controllers\PapController;
use App\Http\Controllers\ExpenseTypeController;
use App\Http\Controllers\LineItemBudgetController;

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
    Route::get('/clients', function () {
        return Inertia::render('Clients');
    })->name('clients');
    Route::get('/ppes', function () {
        return Inertia::render('Ppes');
    })->name('ppes');
    Route::get('/myppes', function () {
        return Inertia::render('Myppe');
    })->name('myppes');
    Route::get('/transactions', function () {
        return Inertia::render('Transactions');
    })->name('transactions');
    Route::get('/mytransactions', function () {
        return Inertia::render('Mytransactions');
    })->name('mytransactions');
    Route::get('/inventories', function () {
        return Inertia::render('Inventory');
    })->name('inventories');
    Route::get('/returnreceipts', function () {
        return Inertia::render('ReturnReceipts');
    })->name('returnreceipts');
    Route::get('/documenttracker', function () {
        return Inertia::render('Documenttracker');
    })->name('documenttracker');
    Route::get('/iirup', function () {
        return Inertia::render('Iirup');
    })->name('iirup');
    Route::get('/batchupload', function () {
        return Inertia::render('Batchupload');
    })->name('batchupload');


    // Libraries
    Route::get('/articles', function () {
        return Inertia::render('Articles');
    })->name('articles');
    Route::get('/statuslists', function () {
        return Inertia::render('Statuslist');
    })->name('statuslists');
    Route::get('/locations', function () {
        return Inertia::render('Locations');
    })->name('locations');
    Route::get('/ppetypes', function () {
        return Inertia::render('Ppetypes');
    })->name('ppetypes');
    Route::get('/brands', function () {
        return Inertia::render('Brands');
    })->name('brands');
    // Route::get('/fundclusters', function () {
    //     return Inertia::render('Fundclusters');
    // })->name('fundclusters');
    Route::get('/suppliers', function () {
        return Inertia::render('Suppliers');
    })->name('suppliers');
    Route::get('/unitofmeasurements', function () {
        return Inertia::render('Unitofmeasurements');
    })->name('unitofmeasurements');
    Route::get('/signatories', function () {
        return Inertia::render('Signatories');
    })->name('signatories');
    Route::get('/divisions', function () {
        return Inertia::render('Divisions');
    })->name('divisions');
    Route::get('/sections', function () {
        return Inertia::render('Sections');
    })->name('sections');
    Route::get('/ppesettings', function () {
        return Inertia::render('Ppesettings');
    })->name('ppesettings');
    Route::get('/fundclusters', function () {
        return Inertia::render('FundClusters');
    })->name('fundclusters');
    Route::get('/paps', function () {
        return Inertia::render('Paps');
    })->name('paps');
    Route::get('/expensetypes', function () {
        return Inertia::render('ExpenseTypes');
    })->name('expensetypes');
    Route::get('/expenselineitems', function () {
        return Inertia::render('LineItemBudgets');
    })->name('expenselineitems');
 
   




    Route::resource('employees', EmployeeController::class);
    Route::resource('clients', ClientController::class);
    Route::resource('ppes', PPEController::class);
    Route::resource('myppes', MyppeController::class);
    Route::resource('transactions', TransactionController::class);
    Route::resource('articles', ArticleController::class);
    Route::resource('statuslists', StatuslistController::class);
    Route::resource('locations', LocationController::class);
    Route::resource('ppetypes', PpetypeController::class);
    Route::resource('mytransactions', MytransactionController::class);
    Route::resource('brands', BrandController::class);
    // Route::resource('fundclusters', FundclusterController::class);
    Route::resource('suppliers', SupplierController::class);
    Route::resource('unitofmeasurements', UnitofmeasurementController::class);
    Route::resource('signatories', SignatoryController::class);
    Route::resource('inventories', InventoryController::class);
    Route::resource('returnreceipts', ReturnreceiptController::class);
    Route::resource('documenttracker', DocumentController::class);
    Route::resource('iirup', IirupController::class);
    Route::resource('divisions', DivisionController::class);
    Route::resource('sections', SectionController::class);
    Route::resource('ppesettings', PpesettingController::class);
    Route::resource('fundclusters', FundclusterController::class);
    Route::resource('paps', PapController::class);
    Route::resource('expensetypes', ExpenseTypeController::class);
    Route::resource('expenselineitems', LineItemBudgetController::class);






    Route::get('/ppe-data', [ChartController::class, 'getPPEData'])->name('ppe.data');
    // Route::get('/fundclusters', [FundclusterController::class, 'index'])->name('FundClusters.index');

});
Route::group(['middleware' => 'administrator'], function () {
    Route::get('/users', function () {
        return Inertia::render('Users');
    })->name('users');
    Route::resource('users', UserController::class);
});



