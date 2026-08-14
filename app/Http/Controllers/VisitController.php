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

        $visits = DB::table('visits')
            ->leftJoin('patients', 'patients.id', '=', 'visits.patient_id')
            ->leftJoin('doctors', 'doctors.id', '=', 'visits.doctor_id')
            ->leftJoin('employees', 'employees.id', '=', 'doctors.user_id')
            ->select(
                'visits.*',

                DB::raw("
                    TRIM(CONCAT(
                        COALESCE(patients.first_name, ''),
                        ' ',
                        COALESCE(patients.middle_name, ''),
                        ' ',
                        COALESCE(patients.last_name, ''),
                        CASE
                            WHEN patients.suffix IS NOT NULL
                                 AND patients.suffix != ''
                            THEN CONCAT(' ', patients.suffix)
                            ELSE ''
                        END
                    )) AS patient_name
                "),

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
                            THEN CONCAT(' ', employees.suffix)
                            ELSE ''
                        END
                    )) AS doctor_name
                "),

                'doctors.license_no',
                'doctors.specialization'
            )
            ->when($search, function ($query, $search) {
                $query->where(function ($q) use ($search) {
                    $q->where('visits.visit_type', 'like', "%{$search}%")
                        ->orWhere('visits.diagnosis', 'like', "%{$search}%")
                        ->orWhere('patients.first_name', 'like', "%{$search}%")
                        ->orWhere('patients.last_name', 'like', "%{$search}%")
                        ->orWhere('employees.firstname', 'like', "%{$search}%")
                        ->orWhere('employees.lastname', 'like', "%{$search}%");
                });
            })
            ->orderByDesc('visits.visit_date')
            ->orderByDesc('visits.visit_time')
            ->get();

        /*
        |--------------------------------------------------------------------------
        | Patients
        |--------------------------------------------------------------------------
        */

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
                            THEN CONCAT(' ', LEFT(middle_name, 1), '.')
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

        /*
        |--------------------------------------------------------------------------
        | Doctors
        |--------------------------------------------------------------------------
        */

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
                            THEN CONCAT(' ', employees.suffix)
                            ELSE ''
                        END
                    )) AS description
                ")
            )
            ->orderBy('employees.lastname')
            ->orderBy('employees.firstname')
            ->get();

        /*
        |--------------------------------------------------------------------------
        | Chief Complaints
        |--------------------------------------------------------------------------
        */

        $chiefComplaints = DB::table('chief_complaints')
            ->where('is_active', 1)
            ->orderBy('name')
            ->get();

        return Inertia::render('Visits', [
            'visits' => $visits,
            'patients' => $patients,
            'doctors' => $doctors,
            'chiefComplaints' => $chiefComplaints,
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
    ]);

    DB::transaction(function () use ($validated) {

        $visitData = [
            'patient_id' => $validated['patient_id'],
            'doctor_id' => $validated['doctor_id'],

            // CORRECT FIELD
            'chief_complaint_id' =>
                $validated['chief_complaint_id'] ?? null,

            'visit_date' => $validated['visit_date'],
            'visit_time' => $validated['visit_time'] ?? null,
            'visit_type' => $validated['visit_type'],

            'visual_acuity_od' =>
                $validated['visual_acuity_od'] ?? null,

            'visual_acuity_os' =>
                $validated['visual_acuity_os'] ?? null,

            'iop_od' =>
                $validated['iop_od'] ?? null,

            'iop_os' =>
                $validated['iop_os'] ?? null,

            'external_exam' =>
                $validated['external_exam'] ?? null,

            'anterior_segment' =>
                $validated['anterior_segment'] ?? null,

            'fundus_exam' =>
                $validated['fundus_exam'] ?? null,

            'other_findings' =>
                $validated['other_findings'] ?? null,

            'diagnosis' =>
                $validated['diagnosis'] ?? null,

            'treatment' =>
                $validated['treatment'] ?? null,

            'notes' =>
                $validated['notes'] ?? null,

            'follow_up_date' =>
                $validated['follow_up_date'] ?? null,

            'updated_at' => now(),
        ];

        /*
        |--------------------------------------------------------------------------
        | UPDATE
        |--------------------------------------------------------------------------
        */

        if (!empty($validated['id'])) {

            DB::table('visits')
                ->where('id', $validated['id'])
                ->update($visitData);
        }

        /*
        |--------------------------------------------------------------------------
        | CREATE
        |--------------------------------------------------------------------------
        */

        else {

            $visitData['created_at'] = now();

            DB::table('visits')
                ->insert($visitData);
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