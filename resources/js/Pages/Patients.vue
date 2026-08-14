<template>
  <DashboardLayout>
    <!-- MAIN PATIENT LIST CARD -->
    <v-card class="border-sm rounded-lg" elevation="2">
      <!-- HEADER & SEARCH BAR -->
      <v-card-title class="d-flex align-center px-6 py-4 border-b">
        <div class="d-flex align-center">
          <v-avatar color="primary-lighten-5" class="mr-3" size="40">
            <v-icon icon="mdi-account-group" color="primary" size="22"></v-icon>
          </v-avatar>
          <div>
            <h2 class="text-h6 font-weight-bold mb-0">Patients Directory</h2>
            <span class="text-caption text-medium-emphasis">Manage and view patient medical histories</span>
          </div>
        </div>

        <v-spacer></v-spacer>

        <v-text-field
          v-model="search"
          density="compact"
          label="Search patient..."
          prepend-inner-icon="mdi-magnify"
          variant="outlined"
          hide-details
          single-line
          clearable
          style="max-width: 320px;"
          class="rounded-lg"
        />
      </v-card-title>

      <!-- CONTENT BODY & TABLE -->
      <v-card-text class="pa-6">
        <div class="d-flex justify-space-between align-center mb-4">
          <v-btn
            color="primary"
            rounded="lg"
            prepend-icon="mdi-account-plus"
            elevation="1"
            class="text-none font-weight-medium"
            @click="openAddPatient"
          >
            Add New Patient
          </v-btn>
        </div>

<v-data-table
    :headers="headers"
    :items="patients"
    :search="search"
    density="comfortable"
    hover
    class="border rounded-lg"
>
          <!-- PATIENT NAME SLOT -->
          <template #item.name="{ item }">
            <div class="d-flex align-center py-2">

              <div>
                <div class="font-weight-medium text-body-2">
                  {{ item.last_name }}, {{ item.first_name }}
                </div>
                <!-- <div class="text-caption text-medium-emphasis">
                  {{ item.middle_name ?? "" }} {{ item.suffix ?? "" }}
                </div> -->
              </div>
            </div>
          </template>

          <!-- BIRTH DATE SLOT -->
          <template #item.birth_date="{ item }">
            <span class="text-body-2">{{ formatDate(item.birth_date) }}</span>
          </template>

          <!-- ROW ACTIONS -->
          <template #item.actions="{ item }">
            <div class="d-flex align-center justify-end">
              <v-tooltip text="View Record" location="top">
                <template #activator="{ props }">
                  <v-btn
                    v-bind="props"
                    icon="mdi-eye-outline"
                    variant="text"
                    density="comfortable"
                    color="primary"
                    @click="viewPatient(item)"
                  />
                </template>
              </v-tooltip>

              <v-tooltip text="Edit Patient" location="top">
                <template #activator="{ props }">
                  <v-btn
                    v-bind="props"
                    icon="mdi-pencil-outline"
                    variant="text"
                    density="comfortable"
                    color="medium-emphasis"
                    @click="editPatient(item)"
                  />
                </template>
              </v-tooltip>
            </div>
          </template>
        </v-data-table>
      </v-card-text>
    </v-card>


    <!-- PATIENT HISTORY DIALOG -->
    <v-dialog
      v-model="historyDialog"
      max-width="1100px"
      scrollable
      transition="dialog-bottom-transition"
    >
      <v-card class="rounded-lg">
        <!-- DIALOG HEADER -->
        <v-card-title class="d-flex align-center px-6 py-4 border-b bg-grey-lighten-5">
          <v-avatar color="primary" variant="tonal" class="mr-3" size="36">
            <v-icon icon="mdi-account-details" size="20"></v-icon>
          </v-avatar>
          <div>
            <span class="text-h6 font-weight-bold">Patient Medical Record</span>
            <div class="text-caption text-medium-emphasis" v-if="selectedPatient">
              ID: #{{ selectedPatient.id || 'N/A' }}
            </div>
          </div>

          <v-spacer />

          <v-btn
            icon="mdi-close"
            variant="text"
            density="comfortable"
            color="medium-emphasis"
            @click="historyDialog = false"
          />
        </v-card-title>

        <v-card-text v-if="selectedPatient" class="pa-6">
          <!-- PATIENT DEMOGRAPHICS SUMMARY -->
          <v-card variant="outlined" class="mb-6 rounded-lg bg-surface">
            <v-card-title class="text-subtitle-2 font-weight-bold text-uppercase text-medium-emphasis px-4 py-3 border-b bg-grey-lighten-5">
              Demographics & Personal Details
            </v-card-title>

            <v-card-text class="pa-4">
              <v-row density="comfortable">
                <v-col cols="12" sm="6" md="4">
                  <span class="text-caption text-medium-emphasis d-block">Full Name</span>
                  <span class="text-body-1 font-weight-medium">{{ patientName(selectedPatient) }}</span>
                </v-col>

                <v-col cols="6" sm="3" md="2">
                  <span class="text-caption text-medium-emphasis d-block">Sex</span>
                  <v-chip size="small" variant="tonal" :color="selectedPatient.sex === 'Female' ? 'pink' : 'blue'">
                    {{ selectedPatient.sex || "Unspecified" }}
                  </v-chip>
                </v-col>

                <v-col cols="6" sm="3" md="2">
                  <span class="text-caption text-medium-emphasis d-block">Birth Date</span>
                  <span class="text-body-2 font-weight-medium">{{ formatDate(selectedPatient.birth_date) }}</span>
                </v-col>

                <v-col cols="12" sm="6" md="4">
                  <span class="text-caption text-medium-emphasis d-block">Contact Number</span>
                  <span class="text-body-2 font-weight-medium">{{ selectedPatient.contact_no || "-" }}</span>
                </v-col>

                <v-col cols="12" sm="6" md="8">
                  <span class="text-caption text-medium-emphasis d-block">Address</span>
                  <span class="text-body-2 font-weight-medium">{{ selectedPatient.address || "-" }}</span>
                </v-col>

                <v-col cols="12" sm="6" md="4">
                  <span class="text-caption text-medium-emphasis d-block">Email Address</span>
                  <span class="text-body-2 font-weight-medium">{{ selectedPatient.email || "-" }}</span>
                </v-col>
              </v-row>
            </v-card-text>
          </v-card>

          <!-- VISIT HISTORY TABLE CARD -->
          <v-card variant="outlined" class="rounded-lg">
            <v-card-title class="d-flex align-center text-subtitle-1 font-weight-bold px-4 py-3 border-b bg-grey-lighten-5">
              <v-icon icon="mdi-history" color="primary" class="mr-2" size="20" />
              Visit History Records
            </v-card-title>

            <v-card-text class="pa-0">
              <v-data-table
                :headers="visitHeaders"
                :items="patientVisits"
                :loading="loadingHistory"
                density="comfortable"
                hover
              >
                <template #item.visit_date="{ item }">
                  <span class="font-weight-medium text-body-2">
                    {{ formatDate(item.visit_date) }}
                  </span>
                </template>

                <template #item.doctor_name="{ item }">
                  <span class="text-body-2">{{ item.doctor_name || "-" }}</span>
                </template>

                <template #item.chief_complaint="{ item }">
                  <span class="text-body-2 text-truncate d-inline-block" style="max-width: 250px;">
                    {{ item.chief_complaint || "-" }}
                  </span>
                </template>

                <template #item.actions="{ item }">
                  <v-btn
                    size="small"
                    variant="tonal"
                    color="primary"
                    rounded="md"
                    class="text-none font-weight-medium"
                    @click="viewVisit(item)"
                  >
                    View Details
                  </v-btn>
                </template>
              </v-data-table>
            </v-card-text>
          </v-card>
        </v-card-text>
      </v-card>
    </v-dialog>


    <!-- VISIT DETAIL DIALOG -->
    <v-dialog
      v-model="visitDialog"
      max-width="900px"
      scrollable
      transition="dialog-bottom-transition"
    >
      <v-card class="rounded-lg">
        <v-card-title class="d-flex align-center px-6 py-4 border-b bg-grey-lighten-5">
          <v-avatar color="info" variant="tonal" class="mr-3" size="36">
            <v-icon icon="mdi-file-document-outline" size="20"></v-icon>
          </v-avatar>
          <span class="text-h6 font-weight-bold">Clinical Visit Report</span>

          <v-spacer />

          <v-btn
            icon="mdi-close"
            variant="text"
            density="comfortable"
            color="medium-emphasis"
            @click="visitDialog = false"
          />
          </v-card-title>

        <v-card-text v-if="selectedVisit" class="pa-6">
          <!-- VISIT HIGHLIGHT HEADER -->
          <v-alert
            type="info"
            variant="tonal"
            border="start"
            class="mb-6 rounded-lg"
          >
            <div class="d-flex justify-space-between align-center flex-wrap ga-2">
              <div>
                <span class="text-caption text-medium-emphasis d-block">Visit Date</span>
                <span class="text-subtitle-1 font-weight-bold">{{ formatDate(selectedVisit.visit_date) }}</span>
              </div>
              <div>
                <span class="text-caption text-medium-emphasis d-block">Attending Physician</span>
                <span class="text-subtitle-1 font-weight-bold">{{ selectedVisit.doctor_name || "Unassigned" }}</span>
              </div>
            </div>
          </v-alert>

          <v-row>
            <!-- VISUAL ASSESSMENT -->
            <v-col cols="12" md="6">
              <v-card variant="outlined" class="h-100 rounded-lg">
                <v-card-title class="text-subtitle-2 font-weight-bold text-uppercase text-medium-emphasis border-b px-4 py-3 bg-grey-lighten-5">
                  Visual Assessment
                </v-card-title>

                <v-card-text class="pa-4">
                  <div class="mb-3">
                    <span class="text-caption text-medium-emphasis d-block">Visual Acuity (OD - Right Eye)</span>
                    <span class="text-body-1 font-weight-medium">{{ selectedVisit.visual_acuity_od || "-" }}</span>
                  </div>

                  <v-divider class="my-2"></v-divider>

                  <div>
                    <span class="text-caption text-medium-emphasis d-block">Visual Acuity (OS - Left Eye)</span>
                    <span class="text-body-1 font-weight-medium">{{ selectedVisit.visual_acuity_os || "-" }}</span>
                  </div>
                </v-card-text>
              </v-card>
            </v-col>

            <!-- EYE EXAMINATION METRICS -->
            <v-col cols="12" md="6">
              <v-card variant="outlined" class="h-100 rounded-lg">
                <v-card-title class="text-subtitle-2 font-weight-bold text-uppercase text-medium-emphasis border-b px-4 py-3 bg-grey-lighten-5">
                  Eye Examination Metrics
                </v-card-title>

                <v-card-text class="pa-4">
                  <v-row density="compact" class="mb-2">
                    <v-col cols="6">
                      <span class="text-caption text-medium-emphasis d-block">IOP (OD)</span>
                      <span class="text-body-2 font-weight-medium">{{ selectedVisit.iop_od || "-" }}</span>
                    </v-col>

                    <v-col cols="6">
                      <span class="text-caption text-medium-emphasis d-block">IOP (OS)</span>
                      <span class="text-body-2 font-weight-medium">{{ selectedVisit.iop_os || "-" }}</span>
                    </v-col>
                  </v-row>

                  <v-divider class="my-2"></v-divider>

                  <div class="mb-2">
                    <span class="text-caption text-medium-emphasis d-block">External Exam</span>
                    <span class="text-body-2 font-weight-medium">{{ selectedVisit.external_exam || "-" }}</span>
                  </div>

                  <div class="mb-2">
                    <span class="text-caption text-medium-emphasis d-block">Anterior Segment</span>
                    <span class="text-body-2 font-weight-medium">{{ selectedVisit.anterior_segment || "-" }}</span>
                  </div>

                  <div>
                    <span class="text-caption text-medium-emphasis d-block">Fundus Exam</span>
                    <span class="text-body-2 font-weight-medium">{{ selectedVisit.fundus_exam || "-" }}</span>
                  </div>
                </v-card-text>
              </v-card>
            </v-col>

            <!-- DIAGNOSIS & CLINICAL PLAN -->
            <v-col cols="12">
              <v-card variant="outlined" class="rounded-lg">
                <v-card-title class="text-subtitle-2 font-weight-bold text-uppercase text-medium-emphasis border-b px-4 py-3 bg-grey-lighten-5">
                  Assessment, Plan & Notes
                </v-card-title>

                <v-card-text class="pa-4">
                  <v-row>
                    <v-col cols="12" md="6">
                      <div class="mb-4">
                        <span class="text-caption text-medium-emphasis d-block">Diagnosis</span>
                        <span class="text-body-2 font-weight-medium text-primary">{{ selectedVisit.diagnosis || "-" }}</span>
                      </div>

                      <div>
                        <span class="text-caption text-medium-emphasis d-block">Treatment Plan</span>
                        <span class="text-body-2 font-weight-medium">{{ selectedVisit.treatment || "-" }}</span>
                      </div>
                    </v-col>

                    <v-col cols="12" md="6">
                      <div class="mb-4">
                        <span class="text-caption text-medium-emphasis d-block">Other Findings</span>
                        <span class="text-body-2 font-weight-medium">{{ selectedVisit.other_findings || "-" }}</span>
                      </div>

                      <div class="mb-4">
                        <span class="text-caption text-medium-emphasis d-block">Clinical Notes</span>
                        <span class="text-body-2 font-weight-medium">{{ selectedVisit.notes || "-" }}</span>
                      </div>

                      <div>
                        <span class="text-caption text-medium-emphasis d-block">Scheduled Follow-up</span>
                        <v-chip size="small" color="warning" variant="tonal" class="mt-1">
                          <v-icon icon="mdi-calendar-clock" start size="14"></v-icon>
                          {{ formatDate(selectedVisit.follow_up_date) }}
                        </v-chip>
                      </div>
                    </v-col>
                  </v-row>
                </v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-card-text>
      </v-card>
    </v-dialog>
    <!-- ADD / EDIT PATIENT DIALOG -->
<v-dialog
    v-model="patientDialogVisible"
    max-width="850px"
    persistent
>
    <v-card class="rounded-lg">

        <v-card-title class="d-flex align-center px-6 py-4 border-b">
            <v-avatar
                color="primary"
                variant="tonal"
                size="40"
                class="mr-3"
            >
                <v-icon icon="mdi-account-plus" />
            </v-avatar>

            <div>
                <div class="text-h6 font-weight-bold">
                    {{ editingPatient ? "Edit Patient" : "Add New Patient" }}
                </div>

                <div class="text-caption text-medium-emphasis">
                    {{
                        editingPatient
                            ? "Update patient information"
                            : "Register a new patient"
                    }}
                </div>
            </div>

            <v-spacer />

            <v-btn
                icon="mdi-close"
                variant="text"
                @click="closePatientDialog"
            />
        </v-card-title>

        <v-card-text class="pa-6">

            <v-form
                ref="patientFormRef"
                @submit.prevent="savePatient"
            >

                <v-row>

                    <!-- FIRST NAME -->
                    <v-col cols="12" md="5">
                        <v-text-field
                            v-model="patientForm.first_name"
                            label="First Name"
                            variant="outlined"
                            density="comfortable"
                            :rules="[rules.required]"
                            prepend-inner-icon="mdi-account-outline"
                        />
                    </v-col>

                    <!-- MIDDLE NAME -->
                    <v-col cols="12" md="4">
                        <v-text-field
                            v-model="patientForm.middle_name"
                            label="Middle Name"
                            variant="outlined"
                            density="comfortable"
                        />
                    </v-col>

                    <!-- SUFFIX -->
                    <v-col cols="12" md="3">
                        <v-text-field
                            v-model="patientForm.suffix"
                            label="Suffix"
                            variant="outlined"
                            density="comfortable"
                        />
                    </v-col>

                    <!-- LAST NAME -->
                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.last_name"
                            label="Last Name"
                            variant="outlined"
                            density="comfortable"
                            :rules="[rules.required]"
                            prepend-inner-icon="mdi-account-outline"
                        />
                    </v-col>

                    <!-- SEX -->
                    <v-col cols="12" md="3">
                        <v-select
                            v-model="patientForm.sex"
                            :items="['Male', 'Female']"
                            label="Sex"
                            variant="outlined"
                            density="comfortable"
                        />
                    </v-col>

                    <!-- BIRTH DATE -->
                    <v-col cols="12" md="3">
                        <v-text-field
                            v-model="patientForm.birth_date"
                            type="date"
                            label="Birth Date"
                            variant="outlined"
                            density="comfortable"
                        />
                    </v-col>

                    <!-- CONTACT -->
                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.contact_no"
                            label="Contact No."
                            variant="outlined"
                            density="comfortable"
                            prepend-inner-icon="mdi-phone-outline"
                        />
                    </v-col>

                    <!-- EMAIL -->
                    <v-col cols="12" md="6">
                        <v-text-field
                            v-model="patientForm.email"
                            label="Email"
                            type="email"
                            variant="outlined"
                            density="comfortable"
                            prepend-inner-icon="mdi-email-outline"
                        />
                    </v-col>

                    <!-- ADDRESS -->
                    <v-col cols="12">
                        <v-textarea
                            v-model="patientForm.address"
                            label="Address"
                            variant="outlined"
                            density="comfortable"
                            rows="3"
                            prepend-inner-icon="mdi-map-marker-outline"
                        />
                    </v-col>

                </v-row>

            </v-form>

        </v-card-text>

        <v-divider />

        <v-card-actions class="px-6 py-4">

            <v-spacer />

            <v-btn
                variant="outlined"
                :disabled="savingPatient"
                @click="closePatientDialog"
            >
                Cancel
            </v-btn>

            <v-btn
                color="primary"
                prepend-icon="mdi-content-save"
                :loading="savingPatient"
                @click="savePatient"
            >
                {{ editingPatient ? "Update Patient" : "Save Patient" }}
            </v-btn>

        </v-card-actions>

    </v-card>
</v-dialog>
  </DashboardLayout>
</template>
<script setup>
import { ref, nextTick } from "vue";
import axios from "axios";
import moment from "moment";
import Swal from "sweetalert2";


import DashboardLayout from "@/Layouts/DashboardLayout.vue";

const props = defineProps({
    patients: {
        type: Array,
        default: () => [],
    },

    search: {
        type: String,
        default: "",
    },
});
const patients = ref([...props.patients]);
const search = ref(props.search);

const historyDialog = ref(false);
const visitDialog = ref(false);

const selectedPatient = ref(null);
const selectedVisit = ref(null);

const patientVisits = ref([]);
const loadingHistory = ref(false);
const patientDialogVisible = ref(false);
const patientFormRef = ref(null);
const savingPatient = ref(false);
const editingPatient = ref(null);

const patientForm = ref({
    first_name: "",
    middle_name: "",
    last_name: "",
    suffix: "",
    birth_date: "",
    sex: "",
    address: "",
    contact_no: "",
    email: "",
});

const rules = {
    required: (value) => !!value || "Required.",
};

const headers = [
    {
        title: "Name",
        key: "name",
    },
    {
        title: "Sex",
        key: "sex",
    },
    {
        title: "Birth Date",
        key: "birth_date",
    },
    {
        title: "Contact",
        key: "contact_no",
    },
    {
        title: "Actions",
        key: "actions",
        sortable: false,
    },
];

const visitHeaders = [
    {
        title: "Date",
        key: "visit_date",
    },
    {
        title: "Doctor",
        key: "doctor_name",
    },
    {
        title: "Chief Complaint",
        key: "chief_complaint",
    },
    {
        title: "Diagnosis",
        key: "diagnosis",
    },
    {
        title: "Visit Type",
        key: "visit_type",
    },
    {
        title: "Action",
        key: "actions",
        sortable: false,
    },
];

const formatDate = (date) => {
    if (!date) {
        return "-";
    }

    return moment(date).format("MMM DD, YYYY");
};

const patientName = (patient) => {
    return [
        patient.first_name,
        patient.middle_name,
        patient.last_name,
        patient.suffix,
    ]
        .filter(Boolean)
        .join(" ");
};
const savePatient = async () => {
    const { valid } = await patientFormRef.value.validate();

    if (!valid) {
        return;
    }

    savingPatient.value = true;

    try {
        const payload = {
            ...patientForm.value,
            id: editingPatient.value
                ? editingPatient.value.id
                : null,
        };

        const response = await axios.post(
            "/patients",
            payload
        );

        const savedPatient = response.data.patient;

        if (editingPatient.value) {

            const index = patients.value.findIndex(
                patient => patient.id === savedPatient.id
            );

            if (index !== -1) {
                patients.value[index] = savedPatient;
            }

        } else {

            patients.value.unshift(savedPatient);

        }

        closePatientDialog();

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "success",
            title: response.data.message,
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

const viewPatient = async (patient) => {

    selectedPatient.value = patient;

    patientVisits.value = [];

    historyDialog.value = true;

    loadingHistory.value = true;

    try {

        const response = await axios.get(
            `/patients/${patient.id}`
        );

        selectedPatient.value = response.data.patient;

        patientVisits.value =
            response.data.visits;

    } catch (error) {

        console.error(
            "Error loading patient history:",
            error
        );

    } finally {

        loadingHistory.value = false;

    }
};

const viewVisit = (visit) => {

    selectedVisit.value = visit;

    visitDialog.value = true;
};

const editPatient = (patient) => {
    editingPatient.value = patient;

    patientForm.value = {
        first_name: patient.first_name ?? "",
        middle_name: patient.middle_name ?? "",
        last_name: patient.last_name ?? "",
        suffix: patient.suffix ?? "",
        birth_date: patient.birth_date ?? "",
        sex: patient.sex ?? "",
        address: patient.address ?? "",
        contact_no: patient.contact_no ?? "",
        email: patient.email ?? "",
    };

    patientDialogVisible.value = true;

    nextTick(() => {
        patientFormRef.value?.resetValidation();
    });
};
const closePatientDialog = () => {
    patientDialogVisible.value = false;

    editingPatient.value = null;

    patientForm.value = {
        first_name: "",
        middle_name: "",
        last_name: "",
        suffix: "",
        birth_date: "",
        sex: "",
        address: "",
        contact_no: "",
        email: "",
    };

    nextTick(() => {
        patientFormRef.value?.resetValidation();
    });
};

const openAddPatient = () => {
    editingPatient.value = null;

    patientForm.value = {
        first_name: "",
        middle_name: "",
        last_name: "",
        suffix: "",
        birth_date: "",
        sex: "",
        address: "",
        contact_no: "",
        email: "",
    };

    patientDialogVisible.value = true;

    nextTick(() => {
        patientFormRef.value?.resetValidation();
    });
};
</script>