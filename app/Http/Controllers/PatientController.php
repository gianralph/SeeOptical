<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class PatientController extends Controller
{
    public function index(Request $request)
    {
        $search = $request->input('search');

        $patients = DB::table('patients')
            ->where('is_active', 1)
            ->when($search, function ($query) use ($search) {
                $query->where(function ($q) use ($search) {

                    $q
                        ->Where('first_name', 'like', "%{$search}%")
                        ->orWhere('middle_name', 'like', "%{$search}%")
                        ->orWhere('last_name', 'like', "%{$search}%")
                        ->orWhere('contact_no', 'like', "%{$search}%");

                });
            })
            ->orderBy('last_name')
            ->orderBy('first_name')
            ->get();

        $patients->transform(function ($patient) {

            $middle = $patient->middle_name
                ? ' ' . $patient->middle_name
                : '';

            $suffix = $patient->suffix
                ? ' ' . $patient->suffix
                : '';

            $patient->description =
                $patient->last_name .
                ', ' .
                $patient->first_name .
                $middle .
                $suffix;

            return $patient;
        });

        return Inertia::render('Patients', [
            'patients' => $patients,
            'search' => $search ?? '',
        ]);
    }


    /**
     * Get patient information + complete visit history
     */
    public function show($id)
    {
        $patient = DB::table('patients')
            ->where('id', $id)
            ->where('is_active', 1)
            ->first();

        if (!$patient) {
            abort(404);
        }


        /*
        |--------------------------------------------------------------------------
        | VISIT HISTORY
        |--------------------------------------------------------------------------
        */

        $visits = DB::table('visits')

            ->leftJoin(
                'doctors',
                'visits.doctor_id',
                '=',
                'doctors.id'
            )

            ->leftJoin(
                'employees',
                'doctors.user_id',
                '=',
                'employees.id'
            )

            ->leftJoin(
                'chief_complaints',
                'visits.chief_complaint_id',
                '=',
                'chief_complaints.id'
            )

            ->where(
                'visits.patient_id',
                $id
            )

            ->orderByDesc('visits.visit_date')
            ->orderByDesc('visits.visit_time')

            ->select(
                'visits.*',

                /*
                |--------------------------------------------------------------------------
                | Doctor
                |--------------------------------------------------------------------------
                */

                DB::raw("
                    TRIM(
                        CONCAT(
                            COALESCE(employees.firstname, ''),
                            ' ',
                            COALESCE(employees.middlename, ''),
                            ' ',
                            COALESCE(employees.lastname, ''),
                            CASE
                                WHEN employees.suffix IS NOT NULL
                                AND employees.suffix != ''
                                THEN CONCAT(' ', employees.suffix)
                                ELSE ''
                            END
                        )
                    ) AS doctor_name
                "),

                'doctors.license_no',
                'doctors.specialization',

                /*
                |--------------------------------------------------------------------------
                | Chief Complaint
                |--------------------------------------------------------------------------
                |
                | Change `name` if your chief_complaints table uses
                | another column name.
                |
                */

                'chief_complaints.name as chief_complaint'
            )

            ->get();


        return response()->json([
            'patient' => $patient,
            'visits' => $visits,
        ]);
    }

public function store(Request $request)
{
    $validated = $request->validate([
        'id' => [
            'nullable',
            'integer',
            'exists:patients,id',
        ],

        'first_name' => [
            'required',
            'string',
            'max:100',
        ],

        'middle_name' => [
            'nullable',
            'string',
            'max:100',
        ],

        'last_name' => [
            'required',
            'string',
            'max:100',
        ],

        'suffix' => [
            'nullable',
            'string',
            'max:20',
        ],

        'birth_date' => [
            'nullable',
            'date',
        ],

        'sex' => [
            'nullable',
            'string',
            'max:20',
        ],

        'address' => [
            'nullable',
            'string',
        ],

        'contact_no' => [
            'nullable',
            'string',
            'max:50',
        ],

        'email' => [
            'nullable',
            'email',
            'max:150',
        ],
    ]);

    $patient = DB::transaction(function () use ($validated) {

        /*
        |--------------------------------------------------------------------------
        | UPDATE EXISTING PATIENT
        |--------------------------------------------------------------------------
        */

        if (!empty($validated['id'])) {

            DB::table('patients')
                ->where('id', $validated['id'])
                ->update([
                    'first_name' => $validated['first_name'],
                    'middle_name' => $validated['middle_name'] ?? null,
                    'last_name' => $validated['last_name'],
                    'suffix' => $validated['suffix'] ?? null,

                    'birth_date' => $validated['birth_date'] ?? null,
                    'sex' => $validated['sex'] ?? null,

                    'address' => $validated['address'] ?? null,
                    'contact_no' => $validated['contact_no'] ?? null,
                    'email' => $validated['email'] ?? null,

                    'updated_at' => now(),
                ]);

            return DB::table('patients')
                ->where('id', $validated['id'])
                ->first();
        }


        /*
        |--------------------------------------------------------------------------
        | CREATE NEW PATIENT
        |--------------------------------------------------------------------------
        */

        $lastPatient = DB::table('patients')
            ->orderByDesc('id')
            ->lockForUpdate()
            ->first();

        $nextNumber = $lastPatient
            ? $lastPatient->id + 1
            : 1;

        $patientNo = 'P-' . str_pad(
            $nextNumber,
            6,
            '0',
            STR_PAD_LEFT
        );

        $patientId = DB::table('patients')->insertGetId([

            'first_name' => $validated['first_name'],
            'middle_name' => $validated['middle_name'] ?? null,
            'last_name' => $validated['last_name'],
            'suffix' => $validated['suffix'] ?? null,

            'birth_date' => $validated['birth_date'] ?? null,
            'sex' => $validated['sex'] ?? null,

            'address' => $validated['address'] ?? null,
            'contact_no' => $validated['contact_no'] ?? null,
            'email' => $validated['email'] ?? null,

            'is_active' => 1,

            'created_at' => now(),
            'updated_at' => now(),
        ]);

        return DB::table('patients')
            ->where('id', $patientId)
            ->first();
    });


    /*
    |--------------------------------------------------------------------------
    | RESPONSE
    |--------------------------------------------------------------------------
    */

    return response()->json([
        'message' => !empty($validated['id'])
            ? 'Patient successfully updated.'
            : 'Patient successfully added.',

        'patient' => $patient,
    ]);
}
}