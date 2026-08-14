<template>
  <DashboardLayout>
    <v-container fluid class="pa-6">
      <!-- Main Card Container -->
      <v-card elevation="0" rounded="xl" class="border">
        
        <!-- Header & Search Toolbar -->
        <v-card-title class="d-flex align-center justify-space-between px-6 py-4">
          <div class="d-flex align-center gap-3">
            <v-avatar color="primary-lighten-5" rounded="lg" size="42">
              <v-icon icon="mdi-eye-outline" color="primary" size="24" />
            </v-avatar>
            <div>
              <h2 class="text-h6 font-weight-bold text-grey-darken-3 mb-0">Patient Visits</h2>
              <p class="text-caption text-grey-medium mb-0">Manage clinical records and eye examinations</p>
            </div>
          </div>

          <div class="d-flex align-center gap-3">
            <v-text-field
              v-model="search"
              density="compact"
              label="Search patient or record..."
              prepend-inner-icon="mdi-magnify"
              variant="outlined"
              hide-details
              single-line
              style="width: 280px"
              rounded="lg"
            />
            <v-btn
              color="primary"
              elevation="0"
              rounded="lg"
              prepend-icon="mdi-plus"
              height="40"
              class="text-none font-weight-medium px-4"
              @click="openDialog(null)"
            >
              New Visit
            </v-btn>
          </div>
        </v-card-title>

        <v-divider />

        <!-- Data Table Section -->
        <v-card-text class="pa-0">
          <v-data-table
            :headers="headers"
            :items="visits"
            v-model:search="search"
            class="clean-table"
            hover
          >
            <template v-slot:item.visit_date="{ item }">
              <span class="font-weight-medium text-grey-darken-2">
                {{ formatDate(item.visit_date) }}
              </span>
            </template>

            <template v-slot:item.patient="{ item }">
              <div class="d-flex align-center py-2">
                <span class="font-weight-medium">
                  {{ item.patient?.description ?? item.patient_name }}
                </span>
              </div>
            </template>

            <template v-slot:item.doctor="{ item }">
              <div class="d-flex align-center text-grey-darken-1">
                <v-icon size="16" icon="mdi-doctor" class="mr-2 text-grey-medium" />
                {{ item.doctor?.description ?? item.doctor_name ?? "-" }}
              </div>
            </template>

            <template v-slot:item.actions="{ item }">
              <div class="d-flex justify-end gap-1">
                <v-btn
                  icon="mdi-pencil-outline"
                  variant="text"
                  density="comfortable"
                  color="grey-darken-1"
                  @click="openDialog(item)"
                />
                <v-btn
                  icon="mdi-delete-outline"
                  variant="text"
                  density="comfortable"
                  color="error"
                  @click="showDeleteDialog(item)"
                />
              </div>
            </template>

            <template v-slot:no-data>
              <div class="text-center py-12 text-grey-medium">
                <v-icon icon="mdi-folder-open-outline" size="48" class="mb-2 text-grey-lighten-1" />
                <p class="text-body-2 mb-0">No patient visits found.</p>
              </div>
            </template>
          </v-data-table>
        </v-card-text>
      </v-card>

      <!-- Patient Visit Form Dialog -->
      <v-dialog v-model="dialogVisible" max-width="1000px" scrollable>
        <v-card rounded="xl" class="overflow-hidden">
          
          <!-- Dialog Header -->
          <v-card-title class="d-flex align-center justify-space-between px-6 py-4 bg-grey-lighten-5 border-b">
            <div class="d-flex align-center gap-3">
              <v-icon icon="mdi-clipboard-text-outline" color="primary" />
              <span class="text-h6 font-weight-bold">
                {{ editingVisit ? "Update Patient Visit" : "New Patient Visit Record" }}
              </span>
            </div>
            <v-btn icon="mdi-close" variant="text" density="comfortable" color="grey-medium" @click="dialogVisible = false" />
          </v-card-title>

          <!-- Dialog Form Content -->
          <v-card-text class="pa-6">
            <v-form ref="myForm" @submit.prevent="submitForm">
              
              <!-- Patient & Visit Meta Panel -->
              <div class="mb-6">
                <h3 class="text-overline text-primary font-weight-bold letter-spacing-1 mb-3">General Information</h3>
                <v-row density="comfortable">
                  <v-col cols="12" md="8">
<v-autocomplete
    v-model="form.patient_id"
:items="patientList"
    item-title="description"
    item-value="id"
    label="Select Patient"
    variant="outlined"
    density="comfortable"
    prepend-inner-icon="mdi-account-outline"
    hide-details="auto"
    @update:model-value="loadPatientHistory"
>
    <template #append-item>
        <v-divider></v-divider>

        <v-list-item
            prepend-icon="mdi-account-plus"
            title="Add New Patient"
            subtitle="Patient not yet registered?"
            @click="openPatientDialog"
        />
    </template>
</v-autocomplete>

                  </v-col>
                  <v-col cols="12" md="4">
                    <v-autocomplete
                      v-model="form.visit_type"
                      :items="visitTypes"
                      label="Visit Type"
                      variant="outlined"
                      density="comfortable"
                      :rules="[rules.required]"
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="4">
                    <v-text-field
                      v-model="form.visit_date"
                      type="date"
                      label="Visit Date"
                      variant="outlined"
                      density="comfortable"
                      :rules="[rules.required]"
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="4">
                    <v-text-field
                      v-model="form.visit_time"
                      type="time"
                      label="Visit Time"
                      variant="outlined"
                      density="comfortable"
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="4">
                    <v-autocomplete
                      v-model="form.doctor_id"
                      :items="doctors"
                      item-title="description"
                      item-value="id"
                      label="Ophthalmologist"
                      prepend-inner-icon="mdi-doctor"
                      variant="outlined"
                      density="comfortable"
                      :rules="[rules.required]"
                      clearable
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12">
                    <v-autocomplete
                      v-model="form.chief_complaint_id"
                      :items="chiefComplaints"
                      item-title="name"
                      item-value="id"
                      label="Chief Complaint"
                      variant="outlined"
                      density="comfortable"
                      prepend-inner-icon="mdi-alert-circle-outline"
                      clearable
                      hide-details="auto"
                    />
                  </v-col>
                </v-row>
              </div>

              <!-- History Notification Banner -->
              <v-alert
                v-if="hasHistory"
                type="info"
                variant="tonal"
                border="start"
                class="mb-6 rounded-lg text-caption"
                icon="mdi-history"
              >
                Previous examination retrieved from <strong>{{ historicalVisit?.visit_date }}</strong>. Parameters pre-populated below.
              </v-alert>

              <!-- Ophthalmic Metrics Panel -->
              <div class="mb-6">
                <h3 class="text-overline text-primary font-weight-bold letter-spacing-1 mb-3">Visual Assessment</h3>
                <v-row density="comfortable">
                  <!-- OD Card -->
                  <v-col cols="12" md="6">
                    <v-card variant="outlined" class="pa-4 bg-grey-lighten-5 rounded-lg border">
                      <div class="d-flex align-center justify-space-between mb-3">
                        <span class="text-subtitle-2 font-weight-bold text-primary">Right Eye (OD)</span>
                        <v-chip size="x-small" color="primary" variant="flat">OD</v-chip>
                      </div>
                      <v-text-field
                        v-model="form.visual_acuity_od"
                        label="Visual Acuity"
                        placeholder="e.g. 20/20"
                        variant="outlined"
                        density="compact"
                        bg-color="white"
                        class="mb-3"
                        hide-details="auto"
                      />
                      <v-text-field
                        v-model="form.iop_od"
                        label="IOP (mmHg)"
                        placeholder="e.g. 15"
                        type="number"
                        variant="outlined"
                        density="compact"
                        bg-color="white"
                        hide-details="auto"
                      />
                    </v-card>
                  </v-col>

                  <!-- OS Card -->
                  <v-col cols="12" md="6">
                    <v-card variant="outlined" class="pa-4 bg-grey-lighten-5 rounded-lg border">
                      <div class="d-flex align-center justify-space-between mb-3">
                        <span class="text-subtitle-2 font-weight-bold text-teal-darken-1">Left Eye (OS)</span>
                        <v-chip size="x-small" color="teal" variant="flat">OS</v-chip>
                      </div>
                      <v-text-field
                        v-model="form.visual_acuity_os"
                        label="Visual Acuity"
                        placeholder="e.g. 20/20"
                        variant="outlined"
                        density="compact"
                        bg-color="white"
                        class="mb-3"
                        hide-details="auto"
                      />
                      <v-text-field
                        v-model="form.iop_os"
                        label="IOP (mmHg)"
                        placeholder="e.g. 15"
                        type="number"
                        variant="outlined"
                        density="compact"
                        bg-color="white"
                        hide-details="auto"
                      />
                    </v-card>
                  </v-col>
                </v-row>
              </div>

              <!-- Eye Clinical Examination -->
              <div class="mb-6">
                <h3 class="text-overline text-primary font-weight-bold letter-spacing-1 mb-3">Eye Examination</h3>
                <v-row density="comfortable">
                  <v-col cols="12" md="6">
                    <v-textarea
                      v-model="form.external_exam"
                      label="External Examination"
                      variant="outlined"
                      density="comfortable"
                      rows="2"
                      auto-grow
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="6">
                    <v-textarea
                      v-model="form.anterior_segment"
                      label="Anterior Segment"
                      variant="outlined"
                      density="comfortable"
                      rows="2"
                      auto-grow
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="6">
                    <v-textarea
                      v-model="form.fundus_exam"
                      label="Fundus Examination"
                      variant="outlined"
                      density="comfortable"
                      rows="2"
                      auto-grow
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="6">
                    <v-textarea
                      v-model="form.other_findings"
                      label="Other Findings"
                      variant="outlined"
                      density="comfortable"
                      rows="2"
                      auto-grow
                      hide-details="auto"
                    />
                  </v-col>
                </v-row>
              </div>

              <!-- Diagnosis & Plan -->
              <div>
                <h3 class="text-overline text-primary font-weight-bold letter-spacing-1 mb-3">Diagnosis & Plan</h3>
                <v-row density="comfortable">
                  <v-col cols="12">
                    <v-textarea
                      v-model="form.diagnosis"
                      label="Diagnosis / Clinical Impression"
                      variant="outlined"
                      density="comfortable"
                      rows="2"
                      auto-grow
                      :rules="[rules.required]"
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="6">
                    <v-textarea
                      v-model="form.treatment"
                      label="Treatment / Prescribed Medications"
                      variant="outlined"
                      density="comfortable"
                      rows="2"
                      auto-grow
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="6">
                    <v-textarea
                      v-model="form.notes"
                      label="Additional Notes"
                      variant="outlined"
                      density="comfortable"
                      rows="2"
                      auto-grow
                      hide-details="auto"
                    />
                  </v-col>
                  <v-col cols="12" md="4">
                    <v-text-field
                      v-model="form.follow_up_date"
                      type="date"
                      label="Follow-up Date"
                      variant="outlined"
                      density="comfortable"
                      prepend-inner-icon="mdi-calendar-clock"
                      hide-details="auto"
                    />
                  </v-col>
                </v-row>
              </div>

            </v-form>
          </v-card-text>

          <v-divider />

          <!-- Dialog Actions -->
          <v-card-actions class="px-6 py-4 bg-grey-lighten-5 justify-end gap-2">
            <v-btn
              variant="outlined"
              color="grey-darken-1"
              rounded="lg"
              class="px-5 text-none"
              @click="closeDialog"
            >
              Cancel
            </v-btn>
            <v-btn
              color="primary"
              elevation="0"
              rounded="lg"
              class="px-6 text-none font-weight-medium"
              prepend-icon="mdi-check"
              @click="submitForm"
            >
              {{ editingVisit ? "Update Record" : "Save Record" }}
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
<v-dialog
    v-model="patientDialogVisible"
    max-width="800px"
>
    <v-card>
        <v-card-title>
            Add New Patient
        </v-card-title>

        <v-card-text>
            <v-form ref="patientFormRef">
                <v-row>

                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.first_name"
                            label="First Name"
                            variant="outlined"
                            :rules="[rules.required]"
                        />
                    </v-col>

                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.last_name"
                            label="Last Name"
                            variant="outlined"
                            :rules="[rules.required]"
                        />
                    </v-col>

                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.middle_name"
                            label="Middle Name"
                            variant="outlined"
                        />
                    </v-col>

                    <v-col cols="12" md="3">
                        <v-text-field
                            v-model="patientForm.suffix"
                            label="Suffix"
                            variant="outlined"
                        />
                    </v-col>

                    <v-col cols="12" md="3">
                        <v-select
                            v-model="patientForm.sex"
                            :items="['Male', 'Female']"
                            label="Sex"
                            variant="outlined"
                        />
                    </v-col>

                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.birth_date"
                            type="date"
                            label="Birth Date"
                            variant="outlined"
                        />
                    </v-col>

                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.contact_no"
                            label="Contact No."
                            variant="outlined"
                        />
                    </v-col>

                    <v-col cols="12">
                        <v-textarea
                            v-model="patientForm.address"
                            label="Address"
                            variant="outlined"
                            rows="2"
                        />
                    </v-col>

                </v-row>
            </v-form>
        </v-card-text>

        <v-card-actions>
            <v-spacer />

            <v-btn
                variant="outlined"
                @click="patientDialogVisible = false"
            >
                Cancel
            </v-btn>

            <v-btn
                color="primary"
                :loading="savingPatient"
                @click="saveNewPatient"
            >
                Save Patient
            </v-btn>
        </v-card-actions>
    </v-card>
</v-dialog>
      <!-- Delete Dialog Component -->
      <DeleteDialog
        v-model="deletedialogVisible"
        @confirm="confirmDelete"
        @cancel="cancelDelete"
      />

    </v-container>
  </DashboardLayout>
</template>



<script setup>
import { ref, defineProps } from "vue";
import { useForm, router } from "@inertiajs/vue3";
import Swal from "sweetalert2";
import axios from "axios";
import DashboardLayout from "@/Layouts/DashboardLayout.vue";
import DeleteDialog from "@/Components/DeleteDialog.vue";


/*
|--------------------------------------------------------------------------
| Props
|--------------------------------------------------------------------------
*/

const props = defineProps({
    visits: {
        type: Array,
        default: () => [],
    },

    patients: {
        type: Array,
        default: () => [],
    },

    doctors: {
        type: Array,
        default: () => [],
    },
    chiefComplaints: {
        type: Array,
        default: () => [],
    },
    
});

/*
|--------------------------------------------------------------------------
| Table
|--------------------------------------------------------------------------
*/

const headers = [
    {
        title: "Visit Date",
        key: "visit_date",
    },
    {
        title: "Patient",
        key: "patient",
    },
    {
        title: "Visit Type",
        key: "visit_type",
    },
    {
        title: "Diagnosis",
        key: "diagnosis",
    },
    {
        title: "Ophthalmologist",
        key: "doctor",
    },
    {
        title: "Actions",
        key: "actions",
        sortable: false,
    },
];

/*
|--------------------------------------------------------------------------
| Form
|--------------------------------------------------------------------------
*/

const form = useForm({
    id: null,

    patient_id: null,
    doctor_id: null,
    chief_complaint_id: null,

    visit_date: "",
    visit_time: "",
    visit_type: "Consultation",

    visual_acuity_od: "",
    visual_acuity_os: "",

    iop_od: "",
    iop_os: "",

    external_exam: "",
    anterior_segment: "",
    fundus_exam: "",
    other_findings: "",

    diagnosis: "",
    treatment: "",
    notes: "",

    follow_up_date: null,
});

/*
|--------------------------------------------------------------------------
| State
|--------------------------------------------------------------------------
*/

const search = ref("");
const dialogVisible = ref(false);
const editingVisit = ref(null);
const myForm = ref(null);

const deletedialogVisible = ref(false);
const selectedVisit = ref(null);
const loadingHistory = ref(false);
const hasHistory = ref(false);
const historicalVisit = ref(null);

const patientDialogVisible = ref(false);
const savingPatient = ref(false);
const patientFormRef = ref(null);

const patientList = ref([...props.patients]);
/*
|--------------------------------------------------------------------------
| Dropdowns
|--------------------------------------------------------------------------
*/

const visitTypes = [
    "Consultation",
    "Follow-up",
    "Eye Examination",
    "Pre-operative Evaluation",
    "Post-operative Follow-up",
    "Emergency",
];

/*
|--------------------------------------------------------------------------
| Validation
|--------------------------------------------------------------------------
*/

const rules = {
    required: (value) => !!value || "Required.",
};

/*
|--------------------------------------------------------------------------
| Open Dialog
|--------------------------------------------------------------------------
*/
const patientForm = useForm({
    first_name: "",
    middle_name: "",
    last_name: "",
    suffix: "",
    birth_date: null,
    sex: "",
    address: "",
    contact_no: "",
    email: "",
});
const openPatientDialog = () => {
    patientForm.reset();

    patientDialogVisible.value = true;
};
const openDialog = (visit) => {
    resetHistory();
    if (visit) {
        editingVisit.value = visit;

        form.id = visit.id;
        form.patient_id = visit.patient_id;
        form.doctor_id = visit.doctor_id;
        form.chief_complaint_id = visit.chief_complaint_id;

        form.visit_date = visit.visit_date;
form.visit_time = visit.visit_time
    ? visit.visit_time.substring(0, 5)
    : null;
        form.visit_type = visit.visit_type;

        form.visual_acuity_od = visit.visual_acuity_od ?? "";
        form.visual_acuity_os = visit.visual_acuity_os ?? "";

        form.iop_od = visit.iop_od ?? "";
        form.iop_os = visit.iop_os ?? "";

        form.external_exam = visit.external_exam ?? "";
        form.anterior_segment = visit.anterior_segment ?? "";
        form.fundus_exam = visit.fundus_exam ?? "";
        form.other_findings = visit.other_findings ?? "";

        form.diagnosis = visit.diagnosis ?? "";
        form.treatment = visit.treatment ?? "";
        form.notes = visit.notes ?? "";

        form.follow_up_date = visit.follow_up_date ?? null;
    } else {
        editingVisit.value = null;

        form.reset();

        form.id = null;
        form.chief_complaint_id = null;

        form.visit_date = new Date()
            .toISOString()
            .substring(0, 10);

        form.visit_type = "Consultation";
    }

    dialogVisible.value = true;
};
/*
|--------------------------------------------------------------------------
| Submit
|--------------------------------------------------------------------------
*/

const submitForm = async () => {
    const { valid } = await myForm.value.validate();

    if (!valid) {
        return;
    }

    if (editingVisit.value) {
        form.id = editingVisit.value.id;
    } else {
        form.id = null;
    }

    console.log("Submitting:", form.data());

    form.post("/visits", {
        preserveScroll: true,

        onSuccess: () => {
            const message = editingVisit.value
                ? "Patient visit successfully updated."
                : "Patient visit successfully recorded.";

            Swal.fire({
                toast: true,
                position: "top-end",
                icon: "success",
                title: message,
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true,
            });

            dialogVisible.value = false;
            editingVisit.value = null;

            form.reset();

            form.visit_date = new Date()
                .toISOString()
                .substring(0, 10);

            form.visit_type = "Consultation";
            form.chief_complaint_id = null;
        },

        onError: (errors) => {
            console.error("Validation errors:", errors);

            Swal.fire({
                toast: true,
                position: "top-end",
                icon: "error",
                title: "Unable to save patient visit.",
                text: "Please check the form and try again.",
                showConfirmButton: false,
                timer: 4000,
                timerProgressBar: true,
            });
        },
    });
};
const closeDialog = () => {
    dialogVisible.value = false;
};
const showDeleteDialog = (item) => {
    selectedVisit.value = item;
    deletedialogVisible.value = true;
};

const confirmDelete = async () => {
    if (!selectedVisit.value) {
        return;
    }

    deletedialogVisible.value = false;

    await router.delete(`/visits/${selectedVisit.value.id}`);

    selectedVisit.value = null;
};

const cancelDelete = () => {
    deletedialogVisible.value = false;
    selectedVisit.value = null;
};

/*
|--------------------------------------------------------------------------
| Helpers
|--------------------------------------------------------------------------
*/
const loadPatientHistory = async (patientId) => {
    if (!patientId) {
        clearHistoricalFields();
        hasHistory.value = false;
        historicalVisit.value = null;
        return;
    }

    // Clear previous patient's historical values
    clearHistoricalFields();
    hasHistory.value = false;
    historicalVisit.value = null;

    loadingHistory.value = true;

    try {
        const response = await axios.get(
            `/visits/patient/${patientId}/latest`
        );

        const visit = response.data;

        if (visit) {
            historicalVisit.value = visit;
            hasHistory.value = true;

            // Visual Assessment
            form.visual_acuity_od =
                visit.visual_acuity_od ?? "";

            form.visual_acuity_os =
                visit.visual_acuity_os ?? "";

            // Eye Examination
            form.iop_od =
                visit.iop_od ?? "";

            form.iop_os =
                visit.iop_os ?? "";

            form.external_exam =
                visit.external_exam ?? "";

            form.anterior_segment =
                visit.anterior_segment ?? "";

            form.fundus_exam =
                visit.fundus_exam ?? "";

            form.other_findings =
                visit.other_findings ?? "";
        }
    } catch (error) {
        console.error(
            "Error loading patient's previous examination:",
            error
        );

        hasHistory.value = false;
        historicalVisit.value = null;

        clearHistoricalFields();
    } finally {
        loadingHistory.value = false;
    }
};

const clearHistoricalFields = () => {
    form.visual_acuity_od = "";
    form.visual_acuity_os = "";

    form.iop_od = "";
    form.iop_os = "";

    form.external_exam = "";
    form.anterior_segment = "";
    form.fundus_exam = "";
    form.other_findings = "";
};
const resetHistory = () => {
    hasHistory.value = false;
    historicalVisit.value = null;
    loadingHistory.value = false;
};
const formatDate = (date) => {
    if (!date) {
        return "-";
    }

    return new Date(date).toLocaleDateString("en-US", {
        year: "numeric",
        month: "short",
        day: "numeric",
    });
};
const saveNewPatient = async () => {
    const { valid } = await patientFormRef.value.validate();

    if (!valid) {
        return;
    }

    savingPatient.value = true;

    try {
        const response = await axios.post(
            "/patients",
            patientForm.data()
        );

        const newPatient = response.data.patient;

        console.log("New patient:", newPatient);

        // Add to autocomplete
        patientList.value.push(newPatient);

        // Automatically select new patient
        form.patient_id = newPatient.id;

        // New patient has no history
        hasHistory.value = false;
        historicalVisit.value = null;
        clearHistoricalFields();

        // Close new patient dialog
        patientDialogVisible.value = false;

        // Reset patient form
        patientForm.reset();

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "success",
            title: "Patient successfully added.",
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
        });

    } catch (error) {
        console.error("Error saving patient:", error);

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: "Unable to save patient.",
            showConfirmButton: false,
            timer: 3000,
        });

    } finally {
        savingPatient.value = false;
    }
};
</script>

<style scoped>
.gap-1 { gap: 4px; }
.gap-2 { gap: 8px; }
.gap-3 { gap: 12px; }

/* Custom clean styling for data table */
:deep(.clean-table .v-data-table-header) {
  background-color: #f8fafc;
}

:deep(.clean-table .v-data-table-header th) {
  font-weight: 600 !important;
  color: #64748b !important;
  text-transform: uppercase;
  font-size: 0.75rem;
  letter-spacing: 0.05em;
  
}
</style>