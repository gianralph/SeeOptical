<?php

namespace App\Http\Controllers;

use App\Models\GlassesInventory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Inertia\Inertia;

class GlassesInventoryController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | INDEX
    |--------------------------------------------------------------------------
    */

    public function index(Request $request)
    {
        $inventory = GlassesInventory::query()
            ->orderBy('brand')
            ->orderBy('model')
            ->orderBy('code')
            ->get();

        return Inertia::render('GlassesInventory', [
            'inventory' => $inventory,
        ]);
    }


    /*
    |--------------------------------------------------------------------------
    | STORE
    |--------------------------------------------------------------------------
    */

public function store(Request $request)
{
    $id = $request->input('id');

    /*
    |--------------------------------------------------------------------------
    | UPDATE
    |--------------------------------------------------------------------------
    */
    if ($id) {
        $inventory = GlassesInventory::findOrFail($id);

        $validated = $request->validate([
            'id' => 'required|integer|exists:glasses_inventory,id',

            'code' => [
                'required',
                'string',
                'max:50',
                Rule::unique('glasses_inventory', 'code')
                    ->ignore($inventory->id),
            ],

            'brand' => 'nullable|string|max:100',
            'model' => 'nullable|string|max:100',
            'description' => 'required|string|max:255',
            'color' => 'nullable|string|max:100',

            'quantity' => 'required|integer|min:0',

            'available_quantity' => [
                'required',
                'integer',
                'min:0',
                'lte:quantity',
            ],

            'cost_price' => 'required|numeric|min:0',
            'selling_price' => 'required|numeric|min:0',
            'is_active' => 'required|boolean',
        ]);

        unset($validated['id']);

        $inventory->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Glasses inventory updated successfully.',
            'inventory' => $inventory->fresh(),
        ]);
    }

    /*
    |--------------------------------------------------------------------------
    | CREATE
    |--------------------------------------------------------------------------
    */

    $validated = $request->validate([
        'code' => [
            'required',
            'string',
            'max:50',
            Rule::unique('glasses_inventory', 'code'),
        ],

        'brand' => 'nullable|string|max:100',
        'model' => 'nullable|string|max:100',
        'description' => 'required|string|max:255',
        'color' => 'nullable|string|max:100',

        'quantity' => 'required|integer|min:0',

        'available_quantity' => [
            'required',
            'integer',
            'min:0',
            'lte:quantity',
        ],

        'cost_price' => 'required|numeric|min:0',
        'selling_price' => 'required|numeric|min:0',
        'is_active' => 'required|boolean',
    ]);

    $inventory = GlassesInventory::create($validated);

    return response()->json([
        'success' => true,
        'message' => 'Glasses inventory added successfully.',
        'inventory' => $inventory,
    ], 201);
}


    /*
    |--------------------------------------------------------------------------
    | UPDATE
    |--------------------------------------------------------------------------
    */

    public function update(Request $request, $id)
    {
        $inventory = GlassesInventory::findOrFail($id);

        $validated = $request->validate([
            'code' => [
                'required',
                'string',
                'max:50',
                'unique:glasses_inventory,code,' . $id,
            ],

            'brand' => [
                'nullable',
                'string',
                'max:100',
            ],

            'model' => [
                'nullable',
                'string',
                'max:100',
            ],

            'description' => [
                'required',
                'string',
                'max:255',
            ],

            'color' => [
                'nullable',
                'string',
                'max:100',
            ],

            'quantity' => [
                'required',
                'integer',
                'min:0',
            ],

            'available_quantity' => [
                'required',
                'integer',
                'min:0',
            ],

            'cost_price' => [
                'required',
                'numeric',
                'min:0',
            ],

            'selling_price' => [
                'required',
                'numeric',
                'min:0',
            ],

            'is_active' => [
                'nullable',
                'boolean',
            ],
        ]);

        if (
            $validated['available_quantity'] >
            $validated['quantity']
        ) {
            return back()->withErrors([
                'available_quantity' =>
                    'Available quantity cannot be greater than total quantity.',
            ]);
        }

        $inventory->update($validated);

        return redirect()
            ->route('glasses-inventory.index')
            ->with('success', 'Glasses inventory successfully updated.');
    }


    /*
    |--------------------------------------------------------------------------
    | TOGGLE STATUS
    |--------------------------------------------------------------------------
    */

    public function toggleStatus($id)
    {
        $inventory = GlassesInventory::findOrFail($id);

        $inventory->is_active = !$inventory->is_active;
        $inventory->save();

        return response()->json([
            'message' => $inventory->is_active
                ? 'Glasses frame activated.'
                : 'Glasses frame deactivated.',

            'inventory' => $inventory,
        ]);
    }


    /*
    |--------------------------------------------------------------------------
    | API - ACTIVE INVENTORY
    |--------------------------------------------------------------------------
    */

    public function active()
    {
        $inventory = GlassesInventory::query()
            ->where('is_active', 1)
            ->where('available_quantity', '>', 0)
            ->orderBy('brand')
            ->orderBy('model')
            ->get();

        return response()->json([
            'inventory' => $inventory,
        ]);
    }


    /*
    |--------------------------------------------------------------------------
    | API - SHOW
    |--------------------------------------------------------------------------
    */

    public function show($id)
    {
        $inventory = GlassesInventory::findOrFail($id);

        return response()->json([
            'inventory' => $inventory,
        ]);
    }
    public function list()
{
    $inventory = GlassesInventory::query()
        ->orderBy('brand')
        ->orderBy('model')
        ->orderBy('code')
        ->get();

    return response()->json([
        'inventory' => $inventory,
    ]);
}
}
