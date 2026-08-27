<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class GlassesOrderController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | INDEX
    |--------------------------------------------------------------------------
    */

    public function index(Request $request)
    {
        $year = $request->input('year', now()->year);

        $orders = DB::table('glasses_orders as go')
            ->join('visits as v', 'v.id', '=', 'go.visit_id')
            ->join('patients as p', 'p.id', '=', 'v.patient_id')
            ->leftJoin(
                'glasses_inventory as gi',
                'gi.id',
                '=',
                'go.frame_id'
            )
            ->select(
                'go.id',
                'go.visit_id',
                'go.frame_id',

                'go.description',
                'go.serial_no',
                'go.additional_features',
                'go.unit_price',

                'go.status',
                'go.ordered_at',
                'go.sent_to_lab_at',
                'go.on_route_at',
                'go.received_at',
                'go.released_at',

                'go.created_at',
                'go.updated_at',

                'v.patient_id',

                DB::raw("
                    CONCAT(
                        p.last_name,
                        ', ',
                        p.first_name
                    ) as patient_name
                "),

                'gi.code as frame_code',
                'gi.brand as frame_brand',
                'gi.model as frame_model',
                'gi.description as frame_description',
                'gi.color as frame_color'
            )
            ->whereYear('go.created_at', $year)
            ->orderByDesc('go.created_at')
            ->get()
            ->map(function ($order) {

                $order->tracking = $this->getTracking($order->id);

                $order->glasses_status = $order->status;

                return $order;
            });

        return Inertia::render('GlassesOrders', [
            'orders' => $orders,
            'year' => $year,
        ]);
    }


    /*
    |--------------------------------------------------------------------------
    | API / LIST
    |--------------------------------------------------------------------------
    */

    public function list(Request $request)
    {
        $year = $request->input('year', now()->year);

        $orders = DB::table('glasses_orders as go')
            ->join('visits as v', 'v.id', '=', 'go.visit_id')
            ->join('patients as p', 'p.id', '=', 'v.patient_id')
            ->leftJoin(
                'glasses_inventory as gi',
                'gi.id',
                '=',
                'go.frame_id'
            )
            ->select(
                'go.*',

                'v.patient_id',

                DB::raw("
                    CONCAT(
                        p.last_name,
                        ', ',
                        p.first_name
                    ) as patient_name
                "),

                'gi.code as frame_code',
                'gi.brand as frame_brand',
                'gi.model as frame_model',
                'gi.description as frame_description',
                'gi.color as frame_color'
            )
            ->whereYear('go.created_at', $year)
            ->orderByDesc('go.created_at')
            ->get();

        foreach ($orders as $order) {

            $order->glasses_status = $order->status;

            $order->tracking = $this->getTracking($order->id);
        }

        return response()->json([
            'orders' => $orders,
        ]);
    }


    /*
    |--------------------------------------------------------------------------
    | UPDATE STATUS
    |--------------------------------------------------------------------------
    */

    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => [
                'required',
                'string',
                'in:Ordered,Sent to Lab,On Route to Clinic,On Clinic,Given to Patient',
            ],

            'remarks' => [
                'nullable',
                'string',
            ],
        ]);

        $order = DB::table('glasses_orders')
            ->where('id', $id)
            ->first();

        if (!$order) {
            return response()->json([
                'message' => 'Glasses order not found.',
            ], 404);
        }
//         if ($order->status === 'Given to Patient') {
//     return response()->json([
//         'message' => 'This glasses order is already closed because it was given to the patient.',
//     ], 422);
// }

        $now = now();

        DB::transaction(function () use (
            $validated,
            $order,
            $now
        ) {

            $status = $validated['status'];

            /*
            |--------------------------------------------------------------------------
            | Determine timestamp field
            |--------------------------------------------------------------------------
            */

            $timestampField = match ($status) {
                'Ordered' => 'ordered_at',
                'Sent to Lab' => 'sent_to_lab_at',
                'On Route to Clinic' => 'on_route_at',
                'On Clinic' => 'received_at',
                'Given to Patient' => 'released_at',
                default => null,
            };

            /*
            |--------------------------------------------------------------------------
            | Update glasses order
            |--------------------------------------------------------------------------
            */

            $updateData = [
                'status' => $status,
                'updated_at' => $now,
            ];

            if ($timestampField) {
                $updateData[$timestampField] = $now;
            }

            DB::table('glasses_orders')
                ->where('id', $order->id)
                ->update($updateData);

            /*
            |--------------------------------------------------------------------------
            | Save tracking history
            |--------------------------------------------------------------------------
            |
            | auth()->id() = users.id
            |
            */

            DB::table('glasses_order_tracking')->insert([
                'glasses_order_id' => $order->id,
                'status' => $status,
                'remarks' => $validated['remarks'] ?? null,
                'created_by' => auth()->id(),
                'created_at' => $now,
            ]);
        });

        /*
        |--------------------------------------------------------------------------
        | Get updated order
        |--------------------------------------------------------------------------
        */

        $updatedOrder = DB::table('glasses_orders as go')
            ->join(
                'visits as v',
                'v.id',
                '=',
                'go.visit_id'
            )
            ->join(
                'patients as p',
                'p.id',
                '=',
                'v.patient_id'
            )
            ->leftJoin(
                'glasses_inventory as gi',
                'gi.id',
                '=',
                'go.frame_id'
            )
            ->where('go.id', $id)
            ->select(
                'go.*',

                'v.patient_id',

                DB::raw("
                    CONCAT(
                        p.last_name,
                        ', ',
                        p.first_name
                    ) as patient_name
                "),

                'gi.code as frame_code',
                'gi.brand as frame_brand',
                'gi.model as frame_model',
                'gi.description as frame_description',
                'gi.color as frame_color'
            )
            ->first();

        if (!$updatedOrder) {
            return response()->json([
                'message' => 'Unable to retrieve updated glasses order.',
            ], 404);
        }

        $updatedOrder->glasses_status = $updatedOrder->status;

        /*
        |--------------------------------------------------------------------------
        | Tracking with employee name
        |--------------------------------------------------------------------------
        */

        $updatedOrder->tracking = $this->getTracking($id);

        return response()->json([
            'message' => 'Glasses order status successfully updated.',
            'order' => $updatedOrder,
        ]);
    }


    /*
    |--------------------------------------------------------------------------
    | TRACKING
    |--------------------------------------------------------------------------
    */

    public function tracking($id)
    {
        return response()->json([
            'tracking' => $this->getTracking($id),
        ]);
    }
public function returnOrder(Request $request, $id)
{
    $validated = $request->validate([
        'status' => [
            'required',
            'string',
            'in:Returned - Defective,Returned - For Repair,Repair Completed,Replacement Issued,Returned to Patient',
        ],

        'remarks' => [
            'nullable',
            'string',
        ],
    ]);

    $order = DB::table('glasses_orders')
        ->where('id', $id)
        ->first();

    if (!$order) {
        return response()->json([
            'message' => 'Glasses order not found.',
        ], 404);
    }

    /*
    |--------------------------------------------------------------------------
    | Only completed orders can enter return / repair workflow
    |--------------------------------------------------------------------------
    */

    if ($order->status !== 'Given to Patient') {
        return response()->json([
            'message' =>
                'Only glasses already given to the patient can be returned.',
        ], 422);
    }

    /*
    |--------------------------------------------------------------------------
    | Save tracking event
    |--------------------------------------------------------------------------
    */

    DB::table('glasses_order_tracking')->insert([
        'glasses_order_id' => $order->id,
        'status' => $validated['status'],
        'remarks' => $validated['remarks'] ?? null,
        'created_by' => auth()->id(),
        'created_at' => now(),
    ]);

    /*
    |--------------------------------------------------------------------------
    | Get order again
    |--------------------------------------------------------------------------
    */

    $updatedOrder = DB::table('glasses_orders as go')
        ->join('visits as v', 'v.id', '=', 'go.visit_id')
        ->join('patients as p', 'p.id', '=', 'v.patient_id')
        ->leftJoin(
            'glasses_inventory as gi',
            'gi.id',
            '=',
            'go.frame_id'
        )
        ->where('go.id', $id)
        ->select(
            'go.*',

            'v.patient_id',

            DB::raw("
                CONCAT(
                    p.last_name,
                    ', ',
                    p.first_name
                ) as patient_name
            "),

            'gi.code as frame_code',
            'gi.brand as frame_brand',
            'gi.model as frame_model',
            'gi.description as frame_description',
            'gi.color as frame_color'
        )
        ->first();

    /*
    |--------------------------------------------------------------------------
    | IMPORTANT
    |--------------------------------------------------------------------------
    |
    | The original order status stays:
    |
    | Given to Patient
    |
    */

    $updatedOrder->glasses_status = $updatedOrder->status;

    /*
    |--------------------------------------------------------------------------
    | Tracking with employee name
    |--------------------------------------------------------------------------
    */

    $updatedOrder->tracking = DB::table(
        'glasses_order_tracking as got'
    )
        ->leftJoin(
            'users as u',
            'u.id',
            '=',
            'got.created_by'
        )
        ->leftJoin(
            'employees as e',
            'e.id',
            '=',
            'u.employeeid'
        )
        ->where(
            'got.glasses_order_id',
            $id
        )
        ->select(
            'got.id',
            'got.glasses_order_id',
            'got.status',
            'got.remarks',
            'got.created_by',
            'got.created_at',

            DB::raw("
                TRIM(
                    CONCAT(
                        COALESCE(e.firstname, ''),
                        ' ',
                        COALESCE(e.middlename, ''),
                        ' ',
                        COALESCE(e.lastname, ''),
                        CASE
                            WHEN e.suffix IS NOT NULL
                                 AND e.suffix != ''
                            THEN CONCAT(' ', e.suffix)
                            ELSE ''
                        END
                    )
                ) as created_by_name
            ")
        )
        ->orderByDesc('got.created_at')
        ->get();

    return response()->json([
        'message' => 'Return / repair record successfully saved.',
        'order' => $updatedOrder,
    ]);
}

    /*
    |--------------------------------------------------------------------------
    | GET TRACKING HISTORY
    |--------------------------------------------------------------------------
    */

    private function getTracking($orderId)
    {
        return DB::table('glasses_order_tracking as got')
            ->leftJoin(
                'users as u',
                'u.id',
                '=',
                'got.created_by'
            )
            ->leftJoin(
                'employees as e',
                'e.id',
                '=',
                'u.employeeid'
            )
            ->where(
                'got.glasses_order_id',
                $orderId
            )
            ->select(
                'got.id',
                'got.glasses_order_id',
                'got.status',
                'got.remarks',
                'got.created_by',
                'got.created_at',

                DB::raw("
                    NULLIF(
                        TRIM(
                            CONCAT(
                                COALESCE(e.firstname, ''),
                                ' ',
                                COALESCE(e.middlename, ''),
                                ' ',
                                COALESCE(e.lastname, ''),
                                CASE
                                    WHEN e.suffix IS NOT NULL
                                         AND e.suffix != ''
                                    THEN CONCAT(' ', e.suffix)
                                    ELSE ''
                                END
                            )
                        ),
                        ''
                    ) as created_by_name
                ")
            )
            ->orderByDesc('got.created_at')
            ->get();
    }
}