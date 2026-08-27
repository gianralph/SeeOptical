<?php

namespace App\Http\Controllers;

use App\Models\Patient;
use App\Models\User;
use App\Models\Visit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class VisitController extends Controller
{
public function index(Request $request)
{
    $search = $request->input('search');

    $visits = DB::table('visits as v')
        ->leftJoin('patients as p', 'p.id', '=', 'v.patient_id')
        ->leftJoin('doctors as d', 'd.id', '=', 'v.doctor_id')
        ->leftJoin('employees as e', 'e.id', '=', 'd.user_id')
        ->leftJoin(
            'chief_complaints as cc',
            'cc.id',
            '=',
            'v.chief_complaint_id'
        )
        ->leftJoin(
            'glasses_orders as go',
            'go.visit_id',
            '=',
            'v.id'
        )
        ->leftJoin(
            'glasses_inventory as gi',
            'gi.id',
            '=',
            'go.frame_id'
        )
        ->select(
            'v.*',

            DB::raw("
                CONCAT(
                    p.last_name,
                    ', ',
                    p.first_name
                ) as patient_name
            "),

            DB::raw("
                CONCAT(
                    e.firstname,
                    ' ',
                    e.lastname
                ) as doctor_name
            "),

            'cc.name as chief_complaint',

            // Glasses order
            'go.id as glasses_order_id',
            'go.frame_id as glasses_frame_id',
            'go.serial_no as glasses_serial',
            'go.additional_features as glasses_features',
            'go.unit_price as glasses_price',
            'go.status as glasses_status',

            // Inventory
            'gi.code as glasses_code',
            'gi.brand as glasses_brand',
            'gi.model as glasses_model',
            'gi.description as glasses_description',
            'gi.color as glasses_color'
        )
        ->orderByDesc('v.visit_date')
        ->orderByDesc('v.visit_time')
        ->get();

    // Patients
    $patients = DB::table('patients')
        ->where('is_active', 1)
        ->select(
            'id',
            DB::raw("
                TRIM(CONCAT(
                    COALESCE(last_name, ''),
                    ', ',
                    COALESCE(first_name, ''),
                    CASE
                        WHEN middle_name IS NOT NULL
                             AND middle_name != ''
                        THEN CONCAT(
                            ' ',
                            LEFT(middle_name, 1),
                            '.'
                        )
                        ELSE ''
                    END,
                    CASE
                        WHEN suffix IS NOT NULL
                             AND suffix != ''
                        THEN CONCAT(' ', suffix)
                        ELSE ''
                    END
                )) AS description
            ")
        )
        ->orderBy('last_name')
        ->orderBy('first_name')
        ->get();

    // Doctors
    $doctors = DB::table('doctors')
        ->join(
            'employees',
            'employees.id',
            '=',
            'doctors.user_id'
        )
        ->where('doctors.is_active', 1)
        ->where('employees.status', 'A')
        ->select(
            'doctors.id',
            'doctors.license_no',
            'doctors.specialization',
            DB::raw("
                TRIM(CONCAT(
                    COALESCE(employees.firstname, ''),
                    ' ',
                    COALESCE(employees.middlename, ''),
                    ' ',
                    COALESCE(employees.lastname, ''),
                    CASE
                        WHEN employees.suffix IS NOT NULL
                             AND employees.suffix != ''
                        THEN CONCAT(
                            ' ',
                            employees.suffix
                        )
                        ELSE ''
                    END
                )) AS description
            ")
        )
        ->orderBy('employees.lastname')
        ->orderBy('employees.firstname')
        ->get();

    // Chief complaints
    $chiefComplaints = DB::table('chief_complaints')
        ->where('is_active', 1)
        ->orderBy('name')
        ->get();

    // Glasses inventory
    $glassesInventory = DB::table('glasses_inventory')
        ->where('is_active', 1)
        ->where('available_quantity', '>', 0)
        ->select(
            'id',
            'code',
            'brand',
            'model',
            'description',
            'color',
            'quantity',
            'available_quantity',
            'cost_price',
            'selling_price',
            DB::raw("
                CONCAT(
                    code,
                    ' - ',
                    COALESCE(brand, ''),
                    CASE
                        WHEN model IS NOT NULL
                             AND model != ''
                        THEN CONCAT(' ', model)
                        ELSE ''
                    END,
                    ' - ',
                    description,
                    CASE
                        WHEN color IS NOT NULL
                             AND color != ''
                        THEN CONCAT(' (', color, ')')
                        ELSE ''
                    END
                ) AS display_name
            ")
        )
        ->orderBy('brand')
        ->orderBy('model')
        ->get();

    return Inertia::render('Visits', [
        'visits' => $visits,
        'patients' => $patients,
        'doctors' => $doctors,
        'chiefComplaints' => $chiefComplaints,
        'glassesInventory' => $glassesInventory,
        'search' => $search,
    ]);
}

public function store(Request $request)
{
    $validated = $request->validate([
        'id' => [
            'nullable',
            'integer',
            'exists:visits,id',
        ],

        'patient_id' => [
            'required',
            'exists:patients,id',
        ],

        'doctor_id' => [
            'required',
            'exists:doctors,id',
        ],

        'chief_complaint_id' => [
            'nullable',
            'integer',
            'exists:chief_complaints,id',
        ],

        'visit_date' => [
            'required',
            'date',
        ],

        'visit_time' => [
            'nullable',
    'date_format:H:i',
        ],

        'visit_type' => [
            'required',
            'string',
            'max:100',
        ],

        'visual_acuity_od' => [
            'nullable',
            'string',
            'max:50',
        ],

        'visual_acuity_os' => [
            'nullable',
            'string',
            'max:50',
        ],

        'iop_od' => [
            'nullable',
            'numeric',
            'min:0',
            'max:100',
        ],

        'iop_os' => [
            'nullable',
            'numeric',
            'min:0',
            'max:100',
        ],

        'external_exam' => [
            'nullable',
            'string',
        ],

        'anterior_segment' => [
            'nullable',
            'string',
        ],

        'fundus_exam' => [
            'nullable',
            'string',
        ],

        'other_findings' => [
            'nullable',
            'string',
        ],

        'diagnosis' => [
            'nullable',
            'string',
        ],

        'treatment' => [
            'nullable',
            'string',
        ],

        'notes' => [
            'nullable',
            'string',
        ],

        'follow_up_date' => [
            'nullable',
            'date',
        ],
        'ordered_glasses' => [
    'nullable',
    'boolean',
],
'ordered_glasses' => [
    'nullable',
    'boolean',
],

'frame_id' => [
    'nullable',
    'integer',
    'exists:glasses_inventory,id',
],

'glasses_serial' => [
    'nullable',
    'string',
    'max:100',
],

'glasses_features' => [
    'nullable',
    'string',
],
'unit_price' => [
    'nullable',
    'numeric',
    'min:0',
],
    ]);
    

DB::transaction(function () use ($validated) {

    $visitData = [
        'patient_id' => $validated['patient_id'],
        'doctor_id' => $validated['doctor_id'],
        'chief_complaint_id' => $validated['chief_complaint_id'] ?? null,

        'visit_date' => $validated['visit_date'],
        'visit_time' => $validated['visit_time'] ?? null,
        'visit_type' => $validated['visit_type'],

        'visual_acuity_od' => $validated['visual_acuity_od'] ?? null,
        'visual_acuity_os' => $validated['visual_acuity_os'] ?? null,

        'iop_od' => $validated['iop_od'] ?? null,
        'iop_os' => $validated['iop_os'] ?? null,

        'external_exam' => $validated['external_exam'] ?? null,
        'anterior_segment' => $validated['anterior_segment'] ?? null,
        'fundus_exam' => $validated['fundus_exam'] ?? null,
        'other_findings' => $validated['other_findings'] ?? null,

        'diagnosis' => $validated['diagnosis'] ?? null,
        'treatment' => $validated['treatment'] ?? null,
        'notes' => $validated['notes'] ?? null,
        'follow_up_date' => $validated['follow_up_date'] ?? null,

        'updated_at' => now(),
    ];

    if (!empty($validated['id'])) {

        DB::table('visits')
            ->where('id', $validated['id'])
            ->update($visitData);

        $visitId = $validated['id'];

    } else {

        $visitData['created_at'] = now();

        $visitId = DB::table('visits')
            ->insertGetId($visitData);
    }

/*
|--------------------------------------------------------------------------
| ORDERED GLASSES
|--------------------------------------------------------------------------
*/

if (!empty($validated['ordered_glasses'])) {

    $existingOrder = DB::table('glasses_orders')
        ->where('visit_id', $visitId)
        ->first();

    /*
    |--------------------------------------------------------------------------
    | Restore previous inventory if frame was changed
    |--------------------------------------------------------------------------
    */

    if (
        $existingOrder &&
        $existingOrder->frame_id &&
        $existingOrder->frame_id != ($validated['frame_id'] ?? null)
    ) {
        DB::table('glasses_inventory')
            ->where('id', $existingOrder->frame_id)
            ->increment('available_quantity');
    }

    /*
    |--------------------------------------------------------------------------
    | Reserve new frame
    |--------------------------------------------------------------------------
    */

    $frameId = $validated['frame_id'] ?? null;

    if ($frameId) {

        $frame = DB::table('glasses_inventory')
            ->where('id', $frameId)
            ->lockForUpdate()
            ->first();

        if (!$frame) {
            throw \Illuminate\Validation\ValidationException::withMessages([
                'frame_id' => 'Selected glasses frame was not found.',
            ]);
        }

        /*
        |--------------------------------------------------------------------------
        | Only decrease inventory when:
        | - this is a new order, OR
        | - the frame was changed
        |--------------------------------------------------------------------------
        */

        $shouldReserve =
            !$existingOrder ||
            $existingOrder->frame_id != $frameId;

        if ($shouldReserve) {

            if ($frame->available_quantity <= 0) {
                throw \Illuminate\Validation\ValidationException::withMessages([
                    'frame_id' => 'The selected glasses frame is out of stock.',
                ]);
            }

            DB::table('glasses_inventory')
                ->where('id', $frameId)
                ->decrement('available_quantity');
        }
    }

    /*
    |--------------------------------------------------------------------------
    | Price
    |--------------------------------------------------------------------------
    |
    | The Vue sends unit_price.
    | If no price was supplied, use inventory selling_price.
    |--------------------------------------------------------------------------
    */

    $unitPrice = $validated['unit_price'] ?? 0;

    if ($unitPrice === null && $frameId) {

        $unitPrice = DB::table('glasses_inventory')
            ->where('id', $frameId)
            ->value('selling_price');
    }

    /*
    |--------------------------------------------------------------------------
    | Create / Update Glasses Order
    |--------------------------------------------------------------------------
    */

    if ($existingOrder) {

        DB::table('glasses_orders')
            ->where('id', $existingOrder->id)
            ->update([
                'frame_id' => $frameId,
                'description' => $validated['glasses_description'] ?? null,
                'serial_no' => $validated['glasses_serial'] ?? null,
                'additional_features' => $validated['glasses_features'] ?? null,
                'unit_price' => $unitPrice ?? 0,
                'updated_at' => now(),
            ]);

        $glassesOrderId = $existingOrder->id;

    } else {

        $glassesOrderId = DB::table('glasses_orders')
            ->insertGetId([
                'visit_id' => $visitId,
                'frame_id' => $frameId,
                'description' => $validated['glasses_description'] ?? null,
                'serial_no' => $validated['glasses_serial'] ?? null,
                'additional_features' => $validated['glasses_features'] ?? null,
                'unit_price' => $unitPrice ?? 0,
                'status' => 'Ordered',
                'ordered_at' => now(),
                'created_at' => now(),
                'updated_at' => now(),
            ]);

        /*
        |--------------------------------------------------------------------------
        | Initial Tracking
        |--------------------------------------------------------------------------
        */

        DB::table('glasses_order_tracking')
            ->insert([
                'glasses_order_id' => $glassesOrderId,
                'status' => 'Ordered',
                'remarks' => 'Glasses order created.',
                'created_at' => now(),
            ]);
    }

} else {

    /*
    |--------------------------------------------------------------------------
    | Remove Ordered Glasses
    |--------------------------------------------------------------------------
    */

    $existingOrder = DB::table('glasses_orders')
        ->where('visit_id', $visitId)
        ->first();

    if ($existingOrder) {

        /*
        |--------------------------------------------------------------------------
        | Return frame to available inventory
        |--------------------------------------------------------------------------
        */

        if ($existingOrder->frame_id) {

            DB::table('glasses_inventory')
                ->where('id', $existingOrder->frame_id)
                ->increment('available_quantity');
        }

        /*
        |--------------------------------------------------------------------------
        | Delete order
        |--------------------------------------------------------------------------
        */

        DB::table('glasses_orders')
            ->where('id', $existingOrder->id)
            ->delete();
    }
}
});

    return redirect()
        ->route('visits.index')
        ->with(
            'success',
            !empty($validated['id'])
                ? 'Patient visit successfully updated.'
                : 'Patient visit successfully recorded.'
        );
}

    public function destroy($id)
    {
        DB::transaction(function () use ($id) {

            DB::table('visit_chief_complaints')
                ->where('visit_id', $id)
                ->delete();

            DB::table('visits')
                ->where('id', $id)
                ->delete();
        });

        return redirect()
            ->route('visits.index')
            ->with('success', 'Patient visit successfully deleted.');
    }
    public function latestPatientVisit($patientId)
{
    $visit = DB::table('visits')
        ->where('patient_id', $patientId)
        ->orderByDesc('visit_date')
        ->orderByDesc('visit_time')
        ->first([
            'id',
            'visit_date',

            // Visual Assessment
            'visual_acuity_od',
            'visual_acuity_os',

            // Eye Examination
            'iop_od',
            'iop_os',
            'external_exam',
            'anterior_segment',
            'fundus_exam',
            'other_findings',

            // Other historical information if needed
            'diagnosis',
            'treatment',
            'notes',
        ]);

    return response()->json($visit);
}
}