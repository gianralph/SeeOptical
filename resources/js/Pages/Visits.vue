<template>
  <DashboardLayout>
    <v-container fluid class="pa-6">
      <!-- ========================================================= -->
      <!-- MAIN CARD                                                  -->
      <!-- ========================================================= -->

      <v-card elevation="0" rounded="xl" class="border">

        <!-- Header & Search Toolbar -->
        <v-card-title
          class="d-flex align-center justify-space-between px-6 py-4"
        >
          <div class="d-flex align-center gap-3">
            <v-avatar
              color="primary-lighten-5"
              rounded="lg"
              size="42"
            >
              <v-icon
                icon="mdi-eye-outline"
                color="primary"
                size="24"
              />
            </v-avatar>

            <div>
              <h2
                class="text-h6 font-weight-bold text-grey-darken-3 mb-0"
              >
                Patient Visits
              </h2>

              <p class="text-caption text-grey-medium mb-0">
                Manage clinical records and eye examinations
              </p>
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

        <!-- ========================================================= -->
        <!-- DATA TABLE                                                 -->
        <!-- ========================================================= -->

        <v-card-text class="pa-0">

          <v-data-table
            :headers="headers"
            :items="searchableVisits"
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
                  {{
                    item.patient?.description ??
                    item.patient_name ??
                    "-"
                  }}
                </span>
              </div>
            </template>

            <template v-slot:item.doctor="{ item }">
              <div class="d-flex align-center text-grey-darken-1">

                <v-icon
                  size="16"
                  icon="mdi-doctor"
                  class="mr-2 text-grey-medium"
                />

                {{
                  item.doctor?.description ??
                  item.doctor_name ??
                  "-"
                }}

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

                <v-btn
                  icon="mdi-printer"
                  color="primary"
                  variant="text"
                  density="comfortable"
                  @click="printMedicalCertificate(item)"
                />

              </div>

            </template>

            <template v-slot:no-data>

              <div
                class="text-center py-12 text-grey-medium"
              >

                <v-icon
                  icon="mdi-folder-open-outline"
                  size="48"
                  class="mb-2 text-grey-lighten-1"
                />

                <p class="text-body-2 mb-0">
                  No patient visits found.
                </p>

              </div>

            </template>

          </v-data-table>

        </v-card-text>

      </v-card>


      <!-- ========================================================= -->
      <!-- PATIENT VISIT FORM DIALOG                                  -->
      <!-- ========================================================= -->

      <v-dialog
        v-model="dialogVisible"
        max-width="1000px"
        scrollable
      >

        <v-card rounded="xl" class="overflow-hidden">

          <!-- Dialog Header -->
          <v-card-title
            class="d-flex align-center justify-space-between
                   px-6 py-4 bg-grey-lighten-5 border-b"
          >

            <div class="d-flex align-center gap-3">

              <v-icon
                icon="mdi-clipboard-text-outline"
                color="primary"
              />

              <span class="text-h6 font-weight-bold">
                {{
                  editingVisit
                    ? "Update Patient Visit"
                    : "New Patient Visit Record"
                }}
              </span>

            </div>

            <v-btn
              icon="mdi-close"
              variant="text"
              density="comfortable"
              color="grey-medium"
              @click="closeDialog"
            />

          </v-card-title>


          <!-- Dialog Form Content -->
          <v-card-text class="pa-6">

            <v-form
              ref="myForm"
              @submit.prevent="submitForm"
            >

              <!-- ================================================= -->
              <!-- GENERAL INFORMATION                                -->
              <!-- ================================================= -->

              <div class="mb-6">

                <h3
                  class="text-overline text-primary
                         font-weight-bold
                         letter-spacing-1 mb-3"
                >
                  General Information
                </h3>

                <v-row density="comfortable">

                  <!-- Patient -->
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

                        <v-divider />

                        <v-list-item
                          prepend-icon="mdi-account-plus"
                          title="Add New Patient"
                          subtitle="Patient not yet registered?"
                          @click="openPatientDialog"
                        />

                      </template>

                    </v-autocomplete>

                  </v-col>


                  <!-- Visit Type -->
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


                  <!-- Visit Date -->
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


                  <!-- Visit Time -->
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


                  <!-- Doctor -->
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


                  <!-- Chief Complaint -->
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


              <!-- ================================================= -->
              <!-- HISTORY NOTIFICATION                               -->
              <!-- ================================================= -->

              <v-alert
                v-if="hasHistory"
                type="info"
                variant="tonal"
                border="start"
                class="mb-6 rounded-lg text-caption"
                icon="mdi-history"
              >

                Previous examination retrieved from
                <strong>
                  {{ historicalVisit?.visit_date }}
                </strong>.

                Parameters pre-populated below.

              </v-alert>


              <!-- ================================================= -->
              <!-- LOADING HISTORY                                    -->
              <!-- ================================================= -->

              <v-alert
                v-if="loadingHistory"
                type="info"
                variant="tonal"
                density="compact"
                class="mb-6"
                icon="mdi-loading mdi-spin"
              >
                Loading patient's previous examination...
              </v-alert>


              <!-- ================================================= -->
              <!-- VISUAL ASSESSMENT                                  -->
              <!-- ================================================= -->

              <div class="mb-6">

                <h3
                  class="text-overline text-primary
                         font-weight-bold
                         letter-spacing-1 mb-3"
                >
                  Visual Assessment
                </h3>

                <v-row density="comfortable">

                  <!-- OD -->
                  <v-col cols="12" md="6">

                    <v-card
                      variant="outlined"
                      class="pa-4 bg-grey-lighten-5
                             rounded-lg border"
                    >

                      <div
                        class="d-flex align-center
                               justify-space-between mb-3"
                      >

                        <span
                          class="text-subtitle-2
                                 font-weight-bold text-primary"
                        >
                          Right Eye (OD)
                        </span>

                        <v-chip
                          size="x-small"
                          color="primary"
                          variant="flat"
                        >
                          OD
                        </v-chip>

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


                  <!-- OS -->
                  <v-col cols="12" md="6">

                    <v-card
                      variant="outlined"
                      class="pa-4 bg-grey-lighten-5
                             rounded-lg border"
                    >

                      <div
                        class="d-flex align-center
                               justify-space-between mb-3"
                      >

                        <span
                          class="text-subtitle-2
                                 font-weight-bold
                                 text-teal-darken-1"
                        >
                          Left Eye (OS)
                        </span>

                        <v-chip
                          size="x-small"
                          color="teal"
                          variant="flat"
                        >
                          OS
                        </v-chip>

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


              <!-- ================================================= -->
              <!-- EYE EXAMINATION                                    -->
              <!-- ================================================= -->

              <div class="mb-6">

                <h3
                  class="text-overline text-primary
                         font-weight-bold
                         letter-spacing-1 mb-3"
                >
                  Eye Examination
                </h3>

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


              <!-- ================================================= -->
              <!-- DIAGNOSIS & PLAN                                   -->
              <!-- ================================================= -->

              <div>

                <h3
                  class="text-overline text-primary
                         font-weight-bold
                         letter-spacing-1 mb-3"
                >
                  Diagnosis & Plan
                </h3>

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


              <!-- ================================================= -->
              <!-- ORDERED GLASSES                                    -->
              <!-- ================================================= -->

              <v-card
                variant="outlined"
                class="mt-6 rounded-lg"
              >

                <!-- Header -->
                <v-card-title
                  class="text-subtitle-2
                         font-weight-bold
                         text-uppercase
                         text-medium-emphasis
                         border-b
                         px-4 py-3
                         bg-grey-lighten-5
                         d-flex align-center"
                >

                  <v-icon
                    icon="mdi-glasses"
                    class="mr-2"
                  />

                  <span>
                    Ordered Glasses
                  </span>

                  <v-spacer />


                  <!-- Locked -->
                  <!-- <v-chip
                    v-if="
                      editingVisit &&
                      form.ordered_glasses &&
                      !replacingGlassesOrder
                    "
                    size="small"
                    color="primary"
                    variant="tonal"
                    prepend-icon="mdi-lock-outline"
                  >
                    Locked
                  </v-chip> -->


                  <!-- Replacement -->
                  <v-chip
                    v-if="
                      editingVisit &&
                      form.ordered_glasses &&
                      replacingGlassesOrder
                    "
                    size="small"
                    color="warning"
                    variant="tonal"
                    prepend-icon="mdi-swap-horizontal"
                  >
                    Replacement Mode
                  </v-chip>

                </v-card-title>


                <v-card-text class="pa-4">


                  <!-- ================================================= -->
                  <!-- NEW VISIT                                          -->
                  <!-- ================================================= -->

                  <template v-if="!editingVisit">

                    <v-switch
                      v-model="form.ordered_glasses"
                      label="Patient ordered glasses"
                      color="primary"
                      hide-details
                    />

                    <v-expand-transition>

                      <div
                        v-if="form.ordered_glasses"
                      >

                        <!-- Frame -->
                        <v-autocomplete
                          v-model="form.frame_id"
                          :items="availableGlassesInventory"
                          item-title="display_name"
                          item-value="id"
                          label="Select Glasses Frame"
                          variant="outlined"
                          density="comfortable"
                          prepend-inner-icon="mdi-glasses"
                          clearable
                          class="mt-4"
                          :rules="[rules.required]"
                        >

                          <template
                            #item="{ props, item }"
                          >

                            <v-list-item
                              v-bind="props"
                              :title="item.raw.display_name"
                            >

                              <template #subtitle>

                                <div>
                                  Available:
                                  <strong>
                                    {{
                                      item.raw.available_quantity
                                    }}
                                  </strong>
                                </div>

                                <div>
                                  Selling Price:
                                  <strong>
                                    ₱{{
                                      formatCurrency(
                                        item.raw.selling_price
                                      )
                                    }}
                                  </strong>
                                </div>

                              </template>

                            </v-list-item>

                          </template>


                          <template #selection="{ item }">

                            <span>
                              {{ item.raw.display_name }}
                            </span>

                          </template>

                        </v-autocomplete>


                        <!-- Selected frame -->
                        <v-alert
                          v-if="selectedGlasses"
                          type="info"
                          variant="tonal"
                          class="mt-3 mb-4"
                          icon="mdi-information-outline"
                        >

                          <div class="font-weight-bold">
                            {{
                              selectedGlasses.brand || ""
                            }}
                            {{
                              selectedGlasses.model || ""
                            }}
                          </div>

                          <div>
                            {{
                              selectedGlasses.description ||
                              "-"
                            }}
                          </div>

                          <div
                            v-if="
                              selectedGlasses.color
                            "
                            class="text-caption mt-1"
                          >
                            Color:
                            {{ selectedGlasses.color }}
                          </div>

                          <div class="mt-2">
                            Available:
                            <strong>
                              {{
                                selectedGlasses.available_quantity
                              }}
                            </strong>
                          </div>

                          <div>
                            Inventory Selling Price:
                            <strong>
                              ₱{{
                                formatCurrency(
                                  selectedGlasses.selling_price
                                )
                              }}
                            </strong>
                          </div>

                        </v-alert>


                        <!-- Order details -->
                        <v-row>

                          <v-col cols="12" md="6">

                            <v-text-field
                              v-model="form.unit_price"
                              label="Selling Price"
                              type="number"
                              min="0"
                              step="0.01"
                              variant="outlined"
                              density="comfortable"
                              prepend-inner-icon="mdi-currency-php"
                              prefix="₱"
                              :rules="[rules.required]"
                              hint="Automatically populated from inventory, but editable."
                              persistent-hint
                            />

                          </v-col>


                          <v-col cols="12" md="6">

                            <v-text-field
                              v-model="form.glasses_serial"
                              label="Serial Number"
                              variant="outlined"
                              density="comfortable"
                              prepend-inner-icon="mdi-barcode"
                            />

                          </v-col>


                          <v-col cols="12">

                            <v-text-field
                              v-model="form.glasses_features"
                              label="Additional Features"
                              placeholder="Polarized, UV Protection, Anti-Reflective..."
                              variant="outlined"
                              density="comfortable"
                              prepend-inner-icon="mdi-star-outline"
                            />

                          </v-col>

                        </v-row>

                      </div>

                    </v-expand-transition>

                  </template>


                  <!-- ================================================= -->
                  <!-- EXISTING VISIT                                     -->
                  <!-- ================================================= -->

                  <template v-if="editingVisit">

                    <!-- No glasses -->
                    <div
                      v-if="!form.ordered_glasses"
                      class="text-body-2
                             text-medium-emphasis
                             py-3"
                    >

                      <v-icon
                        icon="mdi-glasses-off"
                        class="mr-2"
                      />

                      No glasses were ordered for this visit.

                    </div>


                    <!-- ================================================= -->
                    <!-- LOCKED HISTORICAL ORDER                            -->
                    <!-- ================================================= -->

                    <div
                      v-if="
                        form.ordered_glasses &&
                        !replacingGlassesOrder
                      "
                    >

                      <v-card
                        variant="tonal"
                        color="grey"
                        class="pa-4"
                      >

                        <div class="d-flex align-start">

                          <v-icon
                            icon="mdi-lock-outline"
                            size="22"
                            class="mr-3 mt-1"
                          />

                          <div class="flex-grow-1">

                            <div
                              class="text-subtitle-1
                                     font-weight-bold"
                            >
                              Ordered Glasses
                            </div>


                            <!-- Brand / Model -->
                            <div
                              v-if="
                                editingVisit.glasses_brand ||
                                editingVisit.glasses_model
                              "
                              class="text-body-1 mt-2"
                            >

                              {{
                                editingVisit.glasses_brand ||
                                ""
                              }}

                              {{
                                editingVisit.glasses_model
                                  ? " " +
                                    editingVisit.glasses_model
                                  : ""
                              }}

                            </div>


                            <!-- Description -->
                            <div
                              v-if="
                                editingVisit.glasses_description
                              "
                              class="text-body-2
                                     text-medium-emphasis"
                            >
                              {{
                                editingVisit.glasses_description
                              }}
                            </div>


                            <v-row
                              class="mt-2"
                              density="compact"
                            >

                              <!-- Code -->
                              <v-col
                                cols="12"
                                md="4"
                                v-if="
                                  editingVisit.glasses_code
                                "
                              >

                                <div
                                  class="text-caption
                                         text-medium-emphasis"
                                >
                                  Frame Code
                                </div>

                                <div
                                  class="font-weight-medium"
                                >
                                  {{
                                    editingVisit.glasses_code
                                  }}
                                </div>

                              </v-col>


                              <!-- Color -->
                              <v-col
                                cols="12"
                                md="4"
                                v-if="
                                  editingVisit.glasses_color
                                "
                              >

                                <div
                                  class="text-caption
                                         text-medium-emphasis"
                                >
                                  Color
                                </div>

                                <div
                                  class="font-weight-medium"
                                >
                                  {{
                                    editingVisit.glasses_color
                                  }}
                                </div>

                              </v-col>


                              <!-- Serial -->
                              <v-col
                                cols="12"
                                md="4"
                                v-if="
                                  editingVisit.glasses_serial
                                "
                              >

                                <div
                                  class="text-caption
                                         text-medium-emphasis"
                                >
                                  Serial Number
                                </div>

                                <div
                                  class="font-weight-medium"
                                >
                                  {{
                                    editingVisit.glasses_serial
                                  }}
                                </div>

                              </v-col>


                              <!-- Features -->
                              <v-col
                                cols="12"
                                md="4"
                                v-if="
                                  editingVisit.glasses_features
                                "
                              >

                                <div
                                  class="text-caption
                                         text-medium-emphasis"
                                >
                                  Features
                                </div>

                                <div
                                  class="font-weight-medium"
                                >
                                  {{
                                    editingVisit.glasses_features
                                  }}
                                </div>

                              </v-col>


                              <!-- Price -->
                              <v-col
                                cols="12"
                                md="4"
                                v-if="
                                  editingVisit.glasses_price !==
                                    null &&
                                  editingVisit.glasses_price !==
                                    undefined
                                "
                              >

                                <div
                                  class="text-caption
                                         text-medium-emphasis"
                                >
                                  Selling Price
                                </div>

                                <div
                                  class="font-weight-medium"
                                >
                                  ₱{{
                                    formatCurrency(
                                      editingVisit.glasses_price
                                    )
                                  }}
                                </div>

                              </v-col>


                              <!-- Status -->
                              <v-col
                                cols="12"
                                md="4"
                                v-if="
                                  editingVisit.glasses_status
                                "
                              >

                                <div
                                  class="text-caption
                                         text-medium-emphasis"
                                >
                                  Order Status
                                </div>

                                <div
                                  class="font-weight-medium"
                                >
                                  {{
                                    editingVisit.glasses_status
                                  }}
                                </div>

                              </v-col>

                            </v-row>


                            <!-- Current Inventory Status -->
                            <v-alert
                              v-if="selectedGlasses"
                              :type="
                                Number(
                                  selectedGlasses.available_quantity
                                ) > 0
                                  ? 'success'
                                  : 'warning'
                              "
                              variant="tonal"
                              density="compact"
                              class="mt-4"
                              :icon="
                                Number(
                                  selectedGlasses.available_quantity
                                ) > 0
                                  ? 'mdi-check-circle-outline'
                                  : 'mdi-alert-outline'
                              "
                            >

                              <div
                                class="font-weight-medium"
                              >

                                Current Inventory Status:
                                {{
                                  Number(
                                    selectedGlasses.available_quantity
                                  ) > 0
                                    ? "In Stock"
                                    : "Out of Stock"
                                }}

                              </div>

                              <div class="text-caption">

                                Current Available Quantity:
                                {{
                                  selectedGlasses.available_quantity ??
                                  0
                                }}

                              </div>

                            </v-alert>


                            <!-- Original frame no longer exists -->
                            <v-alert
                              v-else
                              type="warning"
                              variant="tonal"
                              density="compact"
                              class="mt-4"
                              icon="mdi-alert-outline"
                            >

                              <div
                                class="font-weight-medium"
                              >
                                Original frame is no longer
                                available in the current inventory.
                              </div>

                              <div class="text-caption">
                                The original glasses order is
                                preserved for historical purposes.
                              </div>

                            </v-alert>

                          </div>


                          <!-- Replace -->
                          <v-btn
                            color="primary"
                            variant="outlined"
                            size="small"
                            prepend-icon="mdi-swap-horizontal"
                            class="ml-3"
                            @click="replaceGlassesOrder"
                          >
                            Replace Order
                          </v-btn>

                        </div>

                      </v-card>

                    </div>


                    <!-- ================================================= -->
                    <!-- REPLACEMENT MODE                                  -->
                    <!-- ================================================= -->

                    <div
                      v-if="
                        form.ordered_glasses &&
                        replacingGlassesOrder
                      "
                    >

                      <v-alert
                        type="warning"
                        variant="tonal"
                        class="mb-4"
                        icon="mdi-swap-horizontal"
                      >

                        <div class="font-weight-bold">
                          Replace Glasses Order
                        </div>

                        <div class="text-caption">
                          Select a replacement frame from the
                          currently available inventory.
                        </div>

                      </v-alert>


                      <!-- Current order -->
                      <v-card
                        variant="outlined"
                        class="mb-4"
                      >

                        <v-card-title
                          class="text-caption
                                 text-medium-emphasis
                                 font-weight-bold"
                        >
                          CURRENT ORDER
                        </v-card-title>

                        <v-card-text>

                          <div class="font-weight-medium">

                            {{
                              editingVisit.glasses_brand ||
                              ""
                            }}

                            {{
                              editingVisit.glasses_model
                                ? " " +
                                  editingVisit.glasses_model
                                : ""
                            }}

                          </div>

                          <div
                            v-if="
                              editingVisit.glasses_code
                            "
                            class="text-caption"
                          >
                            Code:
                            {{
                              editingVisit.glasses_code
                            }}
                          </div>

                          <div
                            v-if="
                              editingVisit.glasses_serial
                            "
                            class="text-caption"
                          >
                            Serial:
                            {{
                              editingVisit.glasses_serial
                            }}
                          </div>

                        </v-card-text>

                      </v-card>


                      <!-- Replacement frame -->
                      <v-autocomplete
                        v-model="form.frame_id"
                        :items="availableGlassesInventory"
                        item-title="display_name"
                        item-value="id"
                        label="Select Replacement Frame"
                        variant="outlined"
                        density="comfortable"
                        prepend-inner-icon="mdi-glasses"
                        clearable
                        :rules="[rules.required]"
                      >

                        <template
                          #item="{ props, item }"
                        >

                          <v-list-item
                            v-bind="props"
                            :title="item.raw.display_name"
                          >

                            <template #subtitle>

                              <div>
                                Available:
                                <strong>
                                  {{
                                    item.raw.available_quantity
                                  }}
                                </strong>
                              </div>

                              <div>
                                Selling Price:
                                <strong>
                                  ₱{{
                                    formatCurrency(
                                      item.raw.selling_price
                                    )
                                  }}
                                </strong>
                              </div>

                            </template>

                          </v-list-item>

                        </template>

                        <template
                          #selection="{ item }"
                        >

                          <span>
                            {{ item.raw.display_name }}
                          </span>

                        </template>

                      </v-autocomplete>


                      <!-- Replacement details -->
                      <v-row class="mt-2">

                        <v-col
                          cols="12"
                          md="6"
                        >

                          <v-text-field
                            v-model="form.unit_price"
                            label="Selling Price"
                            type="number"
                            min="0"
                            step="0.01"
                            variant="outlined"
                            density="comfortable"
                            prepend-inner-icon="mdi-currency-php"
                            prefix="₱"
                            :rules="[rules.required]"
                          />

                        </v-col>


                        <v-col
                          cols="12"
                          md="6"
                        >

                          <v-text-field
                            v-model="form.glasses_serial"
                            label="Serial Number"
                            variant="outlined"
                            density="comfortable"
                            prepend-inner-icon="mdi-barcode"
                          />

                        </v-col>


                        <v-col cols="12">

                          <v-text-field
                            v-model="form.glasses_features"
                            label="Additional Features"
                            placeholder="Polarized, UV Protection, Anti-Reflective..."
                            variant="outlined"
                            density="comfortable"
                            prepend-inner-icon="mdi-star-outline"
                          />

                        </v-col>

                      </v-row>


                      <!-- Replacement buttons -->
                      <div
                        class="d-flex
                               justify-end
                               gap-2
                               mt-2"
                      >

                        <v-btn
                          variant="outlined"
                          color="grey-darken-1"
                          @click="cancelReplaceGlasses"
                        >
                          Cancel Replacement
                        </v-btn>

                        <v-btn
                          color="primary"
                          prepend-icon="mdi-content-save"
                          @click="submitForm"
                        >
                          Save Replacement
                        </v-btn>

                      </div>

                    </div>

                  </template>

                </v-card-text>

              </v-card>

            </v-form>

          </v-card-text>


          <v-divider />


          <!-- ========================================================= -->
          <!-- DIALOG ACTIONS                                             -->
          <!-- ========================================================= -->

          <v-card-actions
            class="px-6 py-4
                   bg-grey-lighten-5
                   justify-end gap-2"
          >

            <v-btn
              variant="outlined"
              color="grey-darken-1"
              rounded="lg"
              class="px-5 text-none"
              @click="closeDialog"
            >
              Cancel
            </v-btn>


            <!-- Hide normal save button during replacement -->
            <v-btn
              v-if="
                !editingVisit ||
                !replacingGlassesOrder
              "
              color="primary"
              elevation="0"
              rounded="lg"
              class="px-6
                     text-none
                     font-weight-medium"
              prepend-icon="mdi-check"
              @click="submitForm"
            >

              {{
                editingVisit
                  ? "Update Record"
                  : "Save Record"
              }}

            </v-btn>

          </v-card-actions>

        </v-card>

      </v-dialog>


      <!-- ========================================================= -->
      <!-- ADD PATIENT DIALOG                                         -->
      <!-- ========================================================= -->

      <v-dialog
        v-model="patientDialogVisible"
        max-width="800px"
      >

        <v-card rounded="xl">

          <v-card-title
            class="d-flex align-center
                   justify-space-between"
          >

            <span class="text-h6 font-weight-bold">
              Add New Patient
            </span>

            <v-btn
              icon="mdi-close"
              variant="text"
              @click="patientDialogVisible = false"
            />

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


      <!-- ========================================================= -->
      <!-- DELETE DIALOG                                               -->
      <!-- ========================================================= -->

      <DeleteDialog
        v-model="deletedialogVisible"
        @confirm="confirmDelete"
        @cancel="cancelDelete"
      />

    </v-container>
  </DashboardLayout>
</template>


<script setup>
import {
    ref,
    computed,
    watch,
} from "vue";

import {
    useForm,
    router,
} from "@inertiajs/vue3";

import Swal from "sweetalert2";
import axios from "axios";

import DashboardLayout from "@/Layouts/DashboardLayout.vue";
import DeleteDialog from "@/Components/DeleteDialog.vue";

import {
    printMedicalCertificate,
} from "@/Reports/printMedicalCertificate";


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

    glassesInventory: {
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

    /*
    |--------------------------------------------------------------------------
    | Ordered Glasses
    |--------------------------------------------------------------------------
    */

    ordered_glasses: false,

    frame_id: null,

    glasses_serial: "",

    glasses_features: "",

    unit_price: null,
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


/*
|--------------------------------------------------------------------------
| Delete
|--------------------------------------------------------------------------
*/

const deletedialogVisible = ref(false);

const selectedVisit = ref(null);


/*
|--------------------------------------------------------------------------
| Patient History
|--------------------------------------------------------------------------
*/

const loadingHistory = ref(false);

const hasHistory = ref(false);

const historicalVisit = ref(null);


/*
|--------------------------------------------------------------------------
| Add Patient
|--------------------------------------------------------------------------
*/

const patientDialogVisible = ref(false);

const savingPatient = ref(false);

const patientFormRef = ref(null);


/*
|--------------------------------------------------------------------------
| Lists
|--------------------------------------------------------------------------
*/

const patientList = ref([
    ...props.patients,
]);

const glassesInventory = ref([
    ...props.glassesInventory,
]);


/*
|--------------------------------------------------------------------------
| Glasses Replacement State
|--------------------------------------------------------------------------
|
| replacingGlassesOrder:
|   false = historical order is locked
|   true  = user explicitly chose Replace Order
|
*/

const replacingGlassesOrder = ref(false);

const originalGlassesFrameId = ref(null);


/*
|--------------------------------------------------------------------------
| Selected Glasses
|--------------------------------------------------------------------------
*/

const selectedGlasses = computed(() => {

    if (!form.frame_id) {
        return null;
    }

    return (
        glassesInventory.value.find(
            (item) =>
                Number(item.id) ===
                Number(form.frame_id)
        ) ?? null
    );
});


/*
|--------------------------------------------------------------------------
| Available Glasses
|--------------------------------------------------------------------------
|
| Only frames that currently have stock can be selected.
|
| Important:
| The original frame of an old visit does NOT get forced into this
| list. The historical order is displayed separately.
|
*/

const availableGlassesInventory = computed(() => {

    return glassesInventory.value.filter(
        (item) =>
            Number(item.available_quantity) > 0
    );
});


/*
|--------------------------------------------------------------------------
| Searchable Visits
|--------------------------------------------------------------------------
*/

const searchableVisits = computed(() => {

    return props.visits.map((visit) => {

        const patientName =
            visit.patient?.description ??
            visit.patient_name ??
            "";

        const doctorName =
            visit.doctor?.description ??
            visit.doctor_name ??
            "";

        const chiefComplaint =
            visit.chief_complaint?.name ??
            visit.chief_complaint_name ??
            "";

        return {
            ...visit,

            patient_search: patientName,

            doctor_search: doctorName,

            visit_type_search:
                visit.visit_type ?? "",

            diagnosis_search:
                visit.diagnosis ?? "",

            complaint_search:
                chiefComplaint,

            date_search:
                visit.visit_date ?? "",
        };
    });
});


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
    required: (value) =>
        !!value || "Required.",
};


/*
|--------------------------------------------------------------------------
| Patient Form
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


/*
|--------------------------------------------------------------------------
| Currency
|--------------------------------------------------------------------------
*/

const formatCurrency = (value) => {

    const amount = Number(value ?? 0);

    return amount.toLocaleString(
        "en-PH",
        {
            minimumFractionDigits: 2,
            maximumFractionDigits: 2,
        }
    );
};


/*
|--------------------------------------------------------------------------
| Open Add Patient
|--------------------------------------------------------------------------
*/

const openPatientDialog = () => {

    patientForm.reset();

    patientDialogVisible.value = true;
};


/*
|--------------------------------------------------------------------------
| Open Visit Dialog
|--------------------------------------------------------------------------
*/

const openDialog = (visit) => {

    resetHistory();

    replacingGlassesOrder.value = false;

    originalGlassesFrameId.value = null;


    /*
    |--------------------------------------------------------------------------
    | EDIT EXISTING VISIT
    |--------------------------------------------------------------------------
    */

    if (visit) {

        editingVisit.value = visit;


        /*
        |--------------------------------------------------------------------------
        | General Information
        |--------------------------------------------------------------------------
        */

        form.id = visit.id;

        form.patient_id =
            visit.patient_id;

        form.doctor_id =
            visit.doctor_id;

        form.chief_complaint_id =
            visit.chief_complaint_id;


        form.visit_date =
            visit.visit_date;


        form.visit_time =
            visit.visit_time
                ? visit.visit_time.substring(
                    0,
                    5
                )
                : null;


        form.visit_type =
            visit.visit_type;


        /*
        |--------------------------------------------------------------------------
        | Visual Assessment
        |--------------------------------------------------------------------------
        */

        form.visual_acuity_od =
            visit.visual_acuity_od ?? "";

        form.visual_acuity_os =
            visit.visual_acuity_os ?? "";


        /*
        |--------------------------------------------------------------------------
        | IOP
        |--------------------------------------------------------------------------
        */

        form.iop_od =
            visit.iop_od ?? "";

        form.iop_os =
            visit.iop_os ?? "";


        /*
        |--------------------------------------------------------------------------
        | Examination
        |--------------------------------------------------------------------------
        */

        form.external_exam =
            visit.external_exam ?? "";

        form.anterior_segment =
            visit.anterior_segment ?? "";

        form.fundus_exam =
            visit.fundus_exam ?? "";

        form.other_findings =
            visit.other_findings ?? "";


        /*
        |--------------------------------------------------------------------------
        | Diagnosis
        |--------------------------------------------------------------------------
        */

        form.diagnosis =
            visit.diagnosis ?? "";

        form.treatment =
            visit.treatment ?? "";

        form.notes =
            visit.notes ?? "";

        form.follow_up_date =
            visit.follow_up_date ?? null;


        /*
        |--------------------------------------------------------------------------
        | HISTORICAL GLASSES ORDER
        |--------------------------------------------------------------------------
        |
        | IMPORTANT:
        | We preserve exactly what was saved with the visit.
        |
        */

        form.ordered_glasses =
            !!visit.glasses_order_id;

        form.frame_id =
            visit.glasses_frame_id ?? null;

        form.glasses_serial =
            visit.glasses_serial ?? "";

        form.glasses_features =
            visit.glasses_features ?? "";

        form.unit_price =
            visit.glasses_price ?? null;


        /*
        |--------------------------------------------------------------------------
        | Remember Original Frame
        |--------------------------------------------------------------------------
        */

        originalGlassesFrameId.value =
            visit.glasses_frame_id ?? null;

    }


    /*
    |--------------------------------------------------------------------------
    | NEW VISIT
    |--------------------------------------------------------------------------
    */

    else {

        editingVisit.value = null;

        form.reset();


        form.id = null;

        form.patient_id = null;

        form.doctor_id = null;

        form.chief_complaint_id = null;


        form.ordered_glasses = false;

        form.frame_id = null;

        form.glasses_serial = "";

        form.glasses_features = "";

        form.unit_price = null;


        form.visit_date =
            new Date()
                .toISOString()
                .substring(
                    0,
                    10
                );


        form.visit_type =
            "Consultation";

    }


    dialogVisible.value = true;
};


/*
|--------------------------------------------------------------------------
| Replace Glasses Order
|--------------------------------------------------------------------------
*/

const replaceGlassesOrder = () => {

    replacingGlassesOrder.value = true;


    /*
    |--------------------------------------------------------------------------
    | Reset the frame so the user must intentionally select a new one.
    |--------------------------------------------------------------------------
    */

    form.frame_id = null;

    form.glasses_serial = "";

    form.glasses_features = "";

    form.unit_price = null;


    Swal.fire({
        toast: true,

        position: "top-end",

        icon: "info",

        title:
            "Glasses order unlocked for replacement.",

        showConfirmButton: false,

        timer: 2000,

        timerProgressBar: true,
    });
};


/*
|--------------------------------------------------------------------------
| Cancel Replacement
|--------------------------------------------------------------------------
*/

const cancelReplaceGlasses = () => {

    replacingGlassesOrder.value = false;


    /*
    |--------------------------------------------------------------------------
    | Restore historical order
    |--------------------------------------------------------------------------
    */

    form.frame_id =
        originalGlassesFrameId.value;


    if (editingVisit.value) {

        form.glasses_serial =
            editingVisit.value.glasses_serial ??
            "";

        form.glasses_features =
            editingVisit.value.glasses_features ??
            "";

        form.unit_price =
            editingVisit.value.glasses_price ??
            null;
    }
};


/*
|--------------------------------------------------------------------------
| Submit Visit
|--------------------------------------------------------------------------
*/

const submitForm = async () => {

    if (!myForm.value) {
        return;
    }


    const { valid } =
        await myForm.value.validate();


    if (!valid) {
        return;
    }


    const isEditing =
        !!editingVisit.value;

    const isReplacing =
        isEditing &&
        replacingGlassesOrder.value;


    /*
    |--------------------------------------------------------------------------
    | Visit ID
    |--------------------------------------------------------------------------
    */

    if (isEditing) {

        form.id =
            editingVisit.value.id;

    } else {

        form.id = null;

    }


    /*
    |--------------------------------------------------------------------------
    | LOCK EXISTING GLASSES ORDER
    |--------------------------------------------------------------------------
    |
    | If this is an ordinary visit update, force the original glasses
    | values back into the request.
    |
    | The only way to change them from the frontend is Replace Order.
    |
    */

    if (
        isEditing &&
        !isReplacing
    ) {

        form.ordered_glasses =
            !!editingVisit.value.glasses_order_id;

        form.frame_id =
            editingVisit.value.glasses_frame_id ??
            null;

        form.glasses_serial =
            editingVisit.value.glasses_serial ??
            "";

        form.glasses_features =
            editingVisit.value.glasses_features ??
            "";

        form.unit_price =
            editingVisit.value.glasses_price ??
            null;
    }


    /*
    |--------------------------------------------------------------------------
    | New Visit Without Glasses
    |--------------------------------------------------------------------------
    */

    if (
        !isEditing &&
        !form.ordered_glasses
    ) {

        form.frame_id = null;

        form.glasses_serial = "";

        form.glasses_features = "";

        form.unit_price = null;
    }


    console.log(
        "Submitting:",
        form.data()
    );


    form.post(
        "/visits",
        {
            preserveScroll: true,

            onSuccess: () => {

                let message =
                    "Patient visit successfully recorded.";


                if (
                    isEditing &&
                    isReplacing
                ) {

                    message =
                        "Glasses order successfully replaced.";

                } else if (isEditing) {

                    message =
                        "Patient visit successfully updated.";
                }


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

                replacingGlassesOrder.value = false;

                originalGlassesFrameId.value = null;


                form.reset();


                form.visit_date =
                    new Date()
                        .toISOString()
                        .substring(
                            0,
                            10
                        );


                form.visit_type =
                    "Consultation";

                form.chief_complaint_id =
                    null;


                form.ordered_glasses =
                    false;

                form.frame_id =
                    null;

                form.glasses_serial =
                    "";

                form.glasses_features =
                    "";

                form.unit_price =
                    null;


                resetHistory();

            },

            onError: (errors) => {

                console.error(
                    "Validation errors:",
                    errors
                );


                Swal.fire({
                    toast: true,

                    position: "top-end",

                    icon: "error",

                    title:
                        "Unable to save patient visit.",

                    text:
                        "Please check the form and try again.",

                    showConfirmButton: false,

                    timer: 4000,

                    timerProgressBar: true,
                });

            },
        }
    );
};


/*
|--------------------------------------------------------------------------
| Close Dialog
|--------------------------------------------------------------------------
*/

const closeDialog = () => {

    dialogVisible.value = false;

    replacingGlassesOrder.value = false;

    originalGlassesFrameId.value = null;

    editingVisit.value = null;

    resetHistory();
};


/*
|--------------------------------------------------------------------------
| Delete
|--------------------------------------------------------------------------
*/

const showDeleteDialog = (item) => {

    selectedVisit.value = item;

    deletedialogVisible.value = true;
};


const confirmDelete = async () => {

    if (!selectedVisit.value) {
        return;
    }


    deletedialogVisible.value = false;


    await router.delete(
        `/visits/${selectedVisit.value.id}`
    );


    selectedVisit.value = null;
};


const cancelDelete = () => {

    deletedialogVisible.value = false;

    selectedVisit.value = null;
};


/*
|--------------------------------------------------------------------------
| Load Patient History
|--------------------------------------------------------------------------
*/

const loadPatientHistory = async (patientId) => {

    if (!patientId) {

        clearHistoricalFields();

        hasHistory.value = false;

        historicalVisit.value = null;

        return;
    }


    /*
    |--------------------------------------------------------------------------
    | Clear previous patient's historical values
    |--------------------------------------------------------------------------
    */

    clearHistoricalFields();

    hasHistory.value = false;

    historicalVisit.value = null;

    loadingHistory.value = true;


    try {

        const response =
            await axios.get(
                `/visits/patient/${patientId}/latest`
            );


        const visit =
            response.data;


        if (visit) {

            historicalVisit.value =
                visit;

            hasHistory.value =
                true;


            /*
            |--------------------------------------------------------------------------
            | Visual Assessment
            |--------------------------------------------------------------------------
            */

            form.visual_acuity_od =
                visit.visual_acuity_od ??
                "";

            form.visual_acuity_os =
                visit.visual_acuity_os ??
                "";


            /*
            |--------------------------------------------------------------------------
            | IOP
            |--------------------------------------------------------------------------
            */

            form.iop_od =
                visit.iop_od ??
                "";

            form.iop_os =
                visit.iop_os ??
                "";


            /*
            |--------------------------------------------------------------------------
            | Eye Examination
            |--------------------------------------------------------------------------
            */

            form.external_exam =
                visit.external_exam ??
                "";

            form.anterior_segment =
                visit.anterior_segment ??
                "";

            form.fundus_exam =
                visit.fundus_exam ??
                "";

            form.other_findings =
                visit.other_findings ??
                "";
        }

    } catch (error) {

        console.error(
            "Error loading patient's previous examination:",
            error
        );


        hasHistory.value =
            false;

        historicalVisit.value =
            null;

        clearHistoricalFields();

    } finally {

        loadingHistory.value =
            false;
    }
};


/*
|--------------------------------------------------------------------------
| Clear Historical Fields
|--------------------------------------------------------------------------
*/

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


/*
|--------------------------------------------------------------------------
| Reset History
|--------------------------------------------------------------------------
*/

const resetHistory = () => {

    hasHistory.value = false;

    historicalVisit.value = null;

    loadingHistory.value = false;
};


/*
|--------------------------------------------------------------------------
| Format Date
|--------------------------------------------------------------------------
*/

const formatDate = (date) => {

    if (!date) {
        return "-";
    }


    return new Date(date)
        .toLocaleDateString(
            "en-US",
            {
                year: "numeric",

                month: "short",

                day: "numeric",
            }
        );
};


/*
|--------------------------------------------------------------------------
| Save New Patient
|--------------------------------------------------------------------------
*/

const saveNewPatient = async () => {

    if (!patientFormRef.value) {
        return;
    }


    const { valid } =
        await patientFormRef.value.validate();


    if (!valid) {
        return;
    }


    savingPatient.value = true;


    try {

        const response =
            await axios.post(
                "/patients",
                patientForm.data()
            );


        const newPatient =
            response.data.patient;


        console.log(
            "New patient:",
            newPatient
        );


        /*
        |--------------------------------------------------------------------------
        | Format patient for autocomplete
        |--------------------------------------------------------------------------
        */

        const formattedPatient = {
            ...newPatient,

            description: [
                newPatient.last_name,

                newPatient.first_name,

                newPatient.middle_name,

                newPatient.suffix,
            ]
                .filter(Boolean)
                .join(", "),
        };


        /*
        |--------------------------------------------------------------------------
        | Add to autocomplete
        |--------------------------------------------------------------------------
        */

        patientList.value.push(
            formattedPatient
        );


        /*
        |--------------------------------------------------------------------------
        | Automatically select patient
        |--------------------------------------------------------------------------
        */

        form.patient_id =
            formattedPatient.id;


        /*
        |--------------------------------------------------------------------------
        | New patient has no history
        |--------------------------------------------------------------------------
        */

        hasHistory.value =
            false;

        historicalVisit.value =
            null;

        clearHistoricalFields();


        /*
        |--------------------------------------------------------------------------
        | Close dialog
        |--------------------------------------------------------------------------
        */

        patientDialogVisible.value =
            false;


        patientForm.reset();


        /*
        |--------------------------------------------------------------------------
        | Success
        |--------------------------------------------------------------------------
        */

        Swal.fire({
            toast: true,

            position: "top-end",

            icon: "success",

            title:
                "Patient successfully added.",

            showConfirmButton: false,

            timer: 3000,

            timerProgressBar: true,
        });

    } catch (error) {

        console.error(
            "Error saving patient:",
            error
        );


        Swal.fire({
            toast: true,

            position: "top-end",

            icon: "error",

            title:
                "Unable to save patient.",

            text:
                error.response?.data?.message ??
                "Please check the patient information.",

            showConfirmButton: false,

            timer: 3000,
        });

    } finally {

        savingPatient.value =
            false;
    }
};


/*
|--------------------------------------------------------------------------
| Glasses Frame Watcher
|--------------------------------------------------------------------------
|
| Important:
|
| Existing visits:
|   Do NOT replace the historical selling price when the dialog opens.
|
| New visit:
|   Automatically use current inventory selling price.
|
| Replacement:
|   Automatically use replacement frame selling price.
|
*/

watch(
    () => form.frame_id,

    (newFrameId) => {

        if (!newFrameId) {

            /*
            |--------------------------------------------------------------------------
            | Do not overwrite historical price while simply opening
            | an existing visit.
            |--------------------------------------------------------------------------
            */

            if (
                !editingVisit.value ||
                replacingGlassesOrder.value
            ) {

                form.unit_price = null;
            }

            return;
        }


        const glasses =
            glassesInventory.value.find(
                (item) =>
                    Number(item.id) ===
                    Number(newFrameId)
            );


        if (!glasses) {
            return;
        }


        /*
        |--------------------------------------------------------------------------
        | Only auto-price:
        |
        | 1. New visit
        | 2. Replacement order
        |--------------------------------------------------------------------------
        */

        if (
            !editingVisit.value ||
            replacingGlassesOrder.value
        ) {

            form.unit_price =
                glasses.selling_price ??
                0;
        }

    }
);

</script>


<style scoped>

.gap-1 {
  gap: 4px;
}

.gap-2 {
  gap: 8px;
}

.gap-3 {
  gap: 12px;
}


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