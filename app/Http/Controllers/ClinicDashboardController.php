<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Inertia\Inertia;

class ClinicDashboardController extends Controller
{
    /**
     * Dashboard page
     */
    public function index()
    {
        return Inertia::render('Dashboard');
    }

    /**
     * Main dashboard statistics
     */
    public function stats()
    {
        $today = Carbon::today();

        $startOfWeek = Carbon::now()->startOfWeek();
        $endOfWeek = Carbon::now()->endOfWeek();

        $startOfMonth = Carbon::now()->startOfMonth();
        $endOfMonth = Carbon::now()->endOfMonth();

        /*
        |--------------------------------------------------------------------------
        | Visits
        |--------------------------------------------------------------------------
        */

        $patientsToday = DB::table('visits')
            ->whereDate('visit_date', $today)
            ->count();

        $patientsWeek = DB::table('visits')
            ->whereBetween('visit_date', [
                $startOfWeek->toDateString(),
                $endOfWeek->toDateString()
            ])
            ->count();

        $patientsMonth = DB::table('visits')
            ->whereBetween('visit_date', [
                $startOfMonth->toDateString(),
                $endOfMonth->toDateString()
            ])
            ->count();

        /*
        |--------------------------------------------------------------------------
        | Patients
        |--------------------------------------------------------------------------
        */

        $activePatients = DB::table('patients')
            ->where('is_active', 1)
            ->count();

        /*
        |--------------------------------------------------------------------------
        | Follow-ups
        |--------------------------------------------------------------------------
        */

        $followUpsToday = DB::table('visits')
            ->whereDate('follow_up_date', $today)
            ->count();

        $followUpsThisWeek = DB::table('visits')
            ->whereBetween('follow_up_date', [
                $today->toDateString(),
                $today->copy()->addDays(7)->toDateString()
            ])
            ->count();

        $overdueFollowUps = DB::table('visits')
            ->whereDate('follow_up_date', '<', $today)
            ->count();

        /*
        |--------------------------------------------------------------------------
        | Birthdays
        |--------------------------------------------------------------------------
        |
        | MySQL birthday comparison ignores the year.
        |
        */

        $birthdaysThisMonth = DB::table('patients')
            ->where('is_active', 1)
            ->whereNotNull('birth_date')
            ->whereMonth('birth_date', $today->month)
            ->count();

        /*
        |--------------------------------------------------------------------------
        | Glasses Inventory
        |--------------------------------------------------------------------------
        */

        $availableGlasses = DB::table('glasses_inventory')
            ->where('is_active', 1)
            ->sum('available_quantity');

        $lowStockGlasses = DB::table('glasses_inventory')
            ->where('is_active', 1)
            ->where('available_quantity', '>', 0)
            ->where('available_quantity', '<=', 5)
            ->count();

        $outOfStockGlasses = DB::table('glasses_inventory')
            ->where('is_active', 1)
            ->where('available_quantity', 0)
            ->count();

        /*
        |--------------------------------------------------------------------------
        | Glasses Orders
        |--------------------------------------------------------------------------
        */

        $glassesOrders = DB::table('glasses_orders')
            ->count();

        $glassesOrdered = DB::table('glasses_orders')
            ->where('status', 'Ordered')
            ->count();

        $glassesSentToLab = DB::table('glasses_orders')
            ->where('status', 'Sent to Lab')
            ->count();

        $glassesOnRoute = DB::table('glasses_orders')
            ->where('status', 'On Route to Clinic')
            ->count();

        $glassesOnClinic = DB::table('glasses_orders')
            ->where('status', 'On Clinic')
            ->count();

        $glassesGiven = DB::table('glasses_orders')
            ->where('status', 'Given to Patient')
            ->count();

        /*
        |--------------------------------------------------------------------------
        | Return / Repair
        |--------------------------------------------------------------------------
        */

        $glassesForRepair = DB::table('glasses_orders')
            ->whereIn('status', [
                'Returned - Defective',
                'Returned - For Repair'
            ])
            ->count();

        return response()->json([
            'patients_today' => $patientsToday,
            'patients_week' => $patientsWeek,
            'patients_month' => $patientsMonth,

            'active_patients' => $activePatients,

            'follow_ups_today' => $followUpsToday,
            'follow_ups_week' => $followUpsThisWeek,
            'overdue_follow_ups' => $overdueFollowUps,

            'birthdays_this_month' => $birthdaysThisMonth,

            'available_glasses' => (int) $availableGlasses,
            'low_stock_glasses' => $lowStockGlasses,
            'out_of_stock_glasses' => $outOfStockGlasses,

            'glasses_orders' => $glassesOrders,
            'glasses_ordered' => $glassesOrdered,
            'glasses_sent_to_lab' => $glassesSentToLab,
            'glasses_on_route' => $glassesOnRoute,
            'glasses_on_clinic' => $glassesOnClinic,
            'glasses_given' => $glassesGiven,
            'glasses_for_repair' => $glassesForRepair,
        ]);
    }

    /**
     * Patient visits for last 7 days
     */
    public function visitsLast7Days()
    {
        $startDate = Carbon::today()->subDays(6);
        $endDate = Carbon::today();

        $visits = DB::table('visits')
            ->select(
                'visit_date',
                DB::raw('COUNT(*) as count')
            )
            ->whereBetween('visit_date', [
                $startDate->toDateString(),
                $endDate->toDateString()
            ])
            ->groupBy('visit_date')
            ->orderBy('visit_date')
            ->get();

        $result = [];

        for (
            $date = $startDate->copy();
            $date <= $endDate;
            $date->addDay()
        ) {
            $dateString = $date->toDateString();

            $record = $visits->firstWhere(
                'visit_date',
                $dateString
            );

            $result[] = [
                'date' => $dateString,
                'day' => $date->format('D'),
                'label' => $date->format('M d'),
                'count' => $record
                    ? (int) $record->count
                    : 0,
            ];
        }

        return response()->json($result);
    }

    /**
     * Recent visits
     */
    public function recentVisits()
    {
        $visits = DB::table('visits as v')
            ->leftJoin(
                'patients as p',
                'p.id',
                '=',
                'v.patient_id'
            )
        // Doctor
        ->leftJoin('doctors as d', 'd.id', '=', 'v.doctor_id')
        ->leftJoin('employees as e', 'e.id', '=', 'd.user_id')
            ->leftJoin(
                'chief_complaints as cc',
                'cc.id',
                '=',
                'v.chief_complaint_id'
            )
            ->select(
                'v.id',
                'v.visit_date',
                'v.visit_time',
                'v.visit_type',
                'v.follow_up_date',

                'p.id as patient_id',

                DB::raw("
                    TRIM(CONCAT(
                        COALESCE(p.first_name, ''),
                        ' ',
                        COALESCE(p.middle_name, ''),
                        ' ',
                        COALESCE(p.last_name, ''),
                        CASE
                            WHEN p.suffix IS NOT NULL
                            AND p.suffix != ''
                            THEN CONCAT(' ', p.suffix)
                            ELSE ''
                        END
                    )) as patient_name
                "),

            DB::raw("
                TRIM(CONCAT(
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
                )) AS doctor_name
            "),

                'cc.name as chief_complaint'
            )
            ->orderByDesc('v.visit_date')
            ->orderByDesc('v.visit_time')
            ->limit(8)
            ->get();

        return response()->json($visits);
    }

    /**
     * Upcoming follow-up checkups
     */
    public function upcomingFollowUps()
    {
        $today = Carbon::today();

        $followUps = DB::table('visits as v')
            ->join(
                'patients as p',
                'p.id',
                '=',
                'v.patient_id'
            )
        // Doctor
        ->leftJoin('doctors as d', 'd.id', '=', 'v.doctor_id')
        ->leftJoin('employees as e', 'e.id', '=', 'd.user_id')
            ->select(
                'v.id',
                'v.patient_id',
                'v.follow_up_date',
                'v.visit_date',
                'v.visit_type',

                DB::raw("
                    TRIM(CONCAT(
                        COALESCE(p.first_name, ''),
                        ' ',
                        COALESCE(p.middle_name, ''),
                        ' ',
                        COALESCE(p.last_name, ''),
                        CASE
                            WHEN p.suffix IS NOT NULL
                            AND p.suffix != ''
                            THEN CONCAT(' ', p.suffix)
                            ELSE ''
                        END
                    )) as patient_name
                "),

            DB::raw("
                TRIM(CONCAT(
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
                )) AS doctor_name
            "),
            )
            ->whereNotNull('v.follow_up_date')
            ->whereDate(
                'v.follow_up_date',
                '>=',
                $today
            )
            ->whereDate(
                'v.follow_up_date',
                '<=',
                $today->copy()->addDays(30)
            )
            ->orderBy('v.follow_up_date')
            ->limit(10)
            ->get();

        return response()->json($followUps);
    }

    /**
     * Upcoming birthdays
     */
public function upcomingBirthdays()
{
    $today = Carbon::today();

    // Include today and birthdays within the next 3 months
    $endDate = $today->copy()->addMonths(3);

    $patients = DB::table('patients')
        ->select(
            'id',
            'first_name',
            'middle_name',
            'last_name',
            'suffix',
            'birth_date'
        )
        ->where('is_active', 1)
        ->whereNotNull('birth_date')
        ->get();

    $birthdays = $patients
        ->map(function ($patient) use ($today, $endDate) {

            $birthDate = Carbon::parse($patient->birth_date);

            // Birthday this year
            $birthday = Carbon::create(
                $today->year,
                $birthDate->month,
                $birthDate->day
            );

            // If birthday already passed, use next year
            if ($birthday->lt($today)) {
                $birthday->addYear();
            }

            // Include today through the next 3 months
            if ($birthday->gt($endDate)) {
                return null;
            }

            $patient->birthday_date = $birthday->toDateString();

            $patient->days_until = $today->diffInDays($birthday);

            // Age the patient will turn on this birthday
            $patient->age = $birthday->year - $birthDate->year;

            $patient->patient_name = trim(
                $patient->first_name . ' ' .
                ($patient->middle_name ?? '') . ' ' .
                $patient->last_name . ' ' .
                ($patient->suffix ?? '')
            );

            return $patient;
        })
        ->filter()
        ->sortBy('days_until')
        ->take(10)
        ->values();

    return response()->json($birthdays);
}

    /**
     * Low stock glasses
     */
    public function lowStockGlasses()
    {
        $glasses = DB::table('glasses_inventory')
            ->select(
                'id',
                'code',
                'brand',
                'model',
                'description',
                'color',
                'quantity',
                'available_quantity',
                'selling_price'
            )
            ->where('is_active', 1)
            ->where(
                'available_quantity',
                '<=',
                5
            )
            ->orderBy('available_quantity')
            ->orderBy('brand')
            ->limit(8)
            ->get();

        return response()->json($glasses);
    }

    /**
     * Glasses order status summary
     */
    public function glassesOrderSummary()
    {
        $statuses = [
            'Ordered',
            'Sent to Lab',
            'On Route to Clinic',
            'On Clinic',
            'Given to Patient',
            'Returned - Defective',
            'Returned - For Repair',
            'Repair Completed',
            'Replacement Issued',
            'Returned to Patient',
        ];

        $result = [];

        foreach ($statuses as $status) {
            $result[] = [
                'status' => $status,
                'count' => DB::table('glasses_orders')
                    ->where('status', $status)
                    ->count(),
            ];
        }

        return response()->json($result);
    }
}