<template>
    <DashboardLayout>
        <v-container fluid class="pa-6">

            <!-- MAIN CARD -->
            <v-card
                elevation="0"
                rounded="xl"
                class="border"
            >
                <!-- HEADER -->
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
                                icon="mdi-glasses"
                                color="primary"
                                size="24"
                            />
                        </v-avatar>

                        <div>
                            <h2
                                class="text-h6 font-weight-bold text-grey-darken-3 mb-0"
                            >
                                Glasses Orders
                            </h2>

                            <p class="text-caption text-grey-medium mb-0">
                                Track ordered glasses and delivery status
                            </p>
                        </div>
                    </div>

                    <div class="d-flex align-center gap-3">
                        <v-text-field
                            v-model="search"
                            density="compact"
                            label="Search patient, serial..."
                            prepend-inner-icon="mdi-magnify"
                            variant="outlined"
                            hide-details
                            single-line
                            clearable
                            style="width: 280px"
                            rounded="lg"
                        />

                        <!-- <v-btn
                            color="primary"
                            elevation="0"
                            rounded="lg"
                            prepend-icon="mdi-refresh"
                            height="40"
                            class="text-none font-weight-medium px-4"
                            :loading="loading"
                            @click="loadOrders"
                        >
                            Refresh
                        </v-btn> -->
                    </div>
                </v-card-title>

                <v-divider />

                <!-- STATUS SUMMARY -->
                <v-card-text class="pa-6 pb-2">
                    <v-row>
                        <v-col
                            v-for="status in statusSummary"
                            :key="status.value"
                            cols="12"
                            sm="6"
                            md="4"
                            lg
                        >
                            <v-card
                                variant="outlined"
                                rounded="lg"
                                class="pa-4 h-100"
                            >
                                <div class="d-flex align-center">
                                    <v-avatar
                                        :color="status.color"
                                        variant="tonal"
                                        size="42"
                                        class="mr-3"
                                    >
                                        <v-icon :icon="status.icon" />
                                    </v-avatar>

                                    <div>
                                        <div
                                            class="text-caption text-medium-emphasis"
                                        >
                                            {{ status.label }}
                                        </div>

                                        <div class="text-h5 font-weight-bold">
                                            {{ countStatus(status.value) }}
                                        </div>
                                    </div>
                                </div>
                            </v-card>
                        </v-col>
                    </v-row>
                </v-card-text>

                <!-- FILTER -->
                <v-card-text class="px-6 pt-4 pb-4">
                    <v-row>
                        <v-col cols="12" md="4">
                            <v-select
                                v-model="statusFilter"
                                :items="statusOptions"
                                label="Filter by Status"
                                variant="outlined"
                                density="comfortable"
                                prepend-inner-icon="mdi-filter-outline"
                                clearable
                                hide-details
                            />
                        </v-col>
                    </v-row>
                </v-card-text>

                <v-divider />

                <!-- TABLE -->
                <v-card-text class="pa-0">
                    <v-data-table
                        :headers="headers"
                        :items="filteredOrders"
                        :search="search"
                        :loading="loading"
                        hover
                        class="clean-table"
                    >

                        <!-- PATIENT -->
                        <template #item.patient="{ item }">
                            <div class="py-2">
                                <div class="font-weight-medium">
                                    {{ item.patient_name || "-" }}
                                </div>

                                <div class="text-caption text-medium-emphasis">
                                    Patient ID: {{ item.patient_id }}
                                </div>
                            </div>
                        </template>

                        <!-- ORDER -->
<template #item.order="{ item }">
    <div class="py-2">
        <div class="font-weight-medium">
            {{ item.frame_brand || "Generic" }}
            {{ item.frame_model || "" }}
        </div>

        <div class="text-caption text-medium-emphasis">
            {{ item.frame_code || "-" }}
            <span v-if="item.frame_color">
                • {{ item.frame_color }}
            </span>
        </div>

        <div class="text-caption text-medium-emphasis">
            {{ item.frame_description || "-" }}
        </div>

        <div class="text-caption mt-1">
            Serial:
            <span class="font-weight-medium">
                {{ item.serial_no || "No serial" }}
            </span>
        </div>
    </div>
</template>

                        <!-- FEATURES -->
                        <template #item.features="{ item }">
                            <v-chip
                                v-if="item.additional_features"
                                size="small"
                                variant="tonal"
                                color="primary"
                            >
                                {{ item.additional_features }}
                            </v-chip>

                            <span v-else class="text-medium-emphasis">
                                -
                            </span>
                        </template>

                        <!-- STATUS -->
                        <template #item.glasses_status="{ item }">
                            <v-chip
                                size="small"
                                variant="tonal"
                                :color="statusColor(item.glasses_status)"
                            >
                                <v-icon
                                    :icon="statusIcon(item.glasses_status)"
                                    start
                                    size="15"
                                />

                                {{ item.glasses_status || "Ordered" }}
                            </v-chip>
                        </template>

                        <!-- ORDER DATE -->
                        <template #item.created_at="{ item }">
                            {{ formatDateTime(item.created_at) }}
                        </template>
                        

                        <!-- ACTIONS -->
<template #item.actions="{ item }">
    <div class="d-flex justify-end gap-1">

        <!-- VIEW -->
        <v-tooltip text="View Order">
            <template #activator="{ props }">
                <v-btn
                    v-bind="props"
                    icon="mdi-eye-outline"
                    variant="text"
                    density="comfortable"
                    color="primary"
                    @click="viewOrder(item)"
                />
            </template>
        </v-tooltip>

        <!-- NORMAL STATUS -->
        <v-tooltip
            v-if="item.glasses_status !== 'Given to Patient'"
            text="Update Status"
        >
            <template #activator="{ props }">
                <v-btn
                    v-bind="props"
                    icon="mdi-swap-horizontal"
                    variant="text"
                    density="comfortable"
                    color="orange-darken-2"
                    @click="openStatusDialog(item)"
                />
            </template>
        </v-tooltip>

        <!-- CLOSED -->
        <v-tooltip
            v-else
            text="Order Closed"
        >
            <template #activator="{ props }">
                <v-btn
                    v-bind="props"
                    icon="mdi-lock-outline"
                    variant="text"
                    density="comfortable"
                    color="success"
                />
            </template>
        </v-tooltip>

        <!-- RETURN / REPAIR -->
        <v-tooltip
            v-if="item.glasses_status === 'Given to Patient'"
            text="Return / Repair"
        >
            <template #activator="{ props }">
                <v-btn
                    v-bind="props"
                    icon="mdi-keyboard-return"
                    variant="text"
                    density="comfortable"
                    color="orange-darken-2"
                    @click="openReturnDialog(item)"
                />
            </template>
        </v-tooltip>

    </div>
</template>

                        <!-- NO DATA -->
                        <template #no-data>
                            <div
                                class="text-center py-12 text-grey-medium"
                            >
                                <v-icon
                                    icon="mdi-glasses"
                                    size="48"
                                    class="mb-2 text-grey-lighten-1"
                                />

                                <p class="text-body-2 mb-0">
                                    No glasses orders found.
                                </p>
                            </div>
                        </template>

                    </v-data-table>
                </v-card-text>
            </v-card>

<!-- RETURN / REPAIR DIALOG -->
<v-dialog
    v-model="returnDialog"
    max-width="600px"
>
    <v-card rounded="xl">

        <v-card-title
            class="d-flex align-center px-6 py-4 bg-grey-lighten-5 border-b"
        >
            <v-icon
                icon="mdi-keyboard-return"
                color="orange-darken-2"
                class="mr-3"
            />

            <span class="text-h6 font-weight-bold">
                Return / Repair Glasses
            </span>

            <v-spacer />

            <v-btn
                icon="mdi-close"
                variant="text"
                @click="returnDialog = false"
            />
        </v-card-title>

        <v-card-text
            v-if="selectedOrder"
            class="pa-6"
        >

            <!-- PATIENT -->
            <v-alert
                type="info"
                variant="tonal"
                class="mb-5"
            >
                <div class="font-weight-bold">
                    {{ selectedOrder.patient_name }}
                </div>

                <div class="text-caption">
                    Patient ID:
                    {{ selectedOrder.patient_id }}
                </div>
            </v-alert>

            <!-- GLASSES -->
            <div class="mb-5">

                <div class="text-caption text-medium-emphasis">
                    Glasses
                </div>

                <div class="text-subtitle-1 font-weight-bold">
                    {{ selectedOrder.frame_brand || "Generic" }}
                    {{ selectedOrder.frame_model || "" }}
                </div>

                <div class="text-caption text-medium-emphasis">
                    {{ selectedOrder.frame_code || "-" }}

                    <span v-if="selectedOrder.frame_color">
                        • {{ selectedOrder.frame_color }}
                    </span>
                </div>

                <div class="text-caption">
                    Serial:
                    {{ selectedOrder.serial_no || "No serial" }}
                </div>

            </div>

            <!-- RETURN TYPE -->
            <v-select
                v-model="returnType"
                :items="returnOptions"
                label="Return / Repair Type"
                variant="outlined"
                density="comfortable"
                prepend-inner-icon="mdi-alert-circle-outline"
                class="mb-4"
            />

            <!-- REMARKS -->
            <v-textarea
                v-model="returnRemarks"
                label="Remarks"
                placeholder="Describe the defect, repair required, or reason for return..."
                variant="outlined"
                rows="4"
                auto-grow
                prepend-inner-icon="mdi-note-text-outline"
            />

        </v-card-text>

        <v-card-actions
            class="px-6 py-4 bg-grey-lighten-5"
        >
            <v-spacer />

            <v-btn
                variant="outlined"
                rounded="lg"
                @click="returnDialog = false"
            >
                Cancel
            </v-btn>

            <v-btn
                color="orange-darken-2"
                rounded="lg"
                prepend-icon="mdi-check"
                :loading="savingReturn"
                :disabled="!returnType"
                @click="saveReturn"
            >
                Save Return
            </v-btn>
        </v-card-actions>

    </v-card>
</v-dialog>
            <!-- VIEW ORDER DIALOG -->
            <v-dialog
                v-model="viewDialog"
                max-width="700px"
            >
                <v-card rounded="xl">

                    <v-card-title
                        class="d-flex align-center px-6 py-4 bg-grey-lighten-5 border-b"
                    >
                        <v-icon
                            icon="mdi-glasses"
                            color="primary"
                            class="mr-3"
                        />

                        <span class="text-h6 font-weight-bold">
                            Glasses Order Details
                        </span>

                        <v-spacer />

                        <v-btn
                            icon="mdi-close"
                            variant="text"
                            @click="viewDialog = false"
                        />
                    </v-card-title>

                    <v-card-text
                        v-if="selectedOrder"
                        class="pa-6"
                    >

                        <!-- PATIENT -->
                        <v-alert
                            variant="tonal"
                            type="info"
                            class="mb-5"
                        >
                            <div class="font-weight-bold">
                                {{ selectedOrder.patient_name }}
                            </div>

                            <div class="text-caption">
                                Patient ID:
                                {{ selectedOrder.patient_id }}
                            </div>
                        </v-alert>

<!-- ORDER INFORMATION -->
<v-row>

    <!-- FRAME -->
    <v-col cols="12">
        <div class="text-caption text-medium-emphasis">
            Glasses Frame
        </div>

        <div class="text-h6 font-weight-bold">
            {{ selectedOrder.frame_brand || "Generic" }}
            {{ selectedOrder.frame_model || "" }}
        </div>

        <div class="text-body-2 text-medium-emphasis">
            {{ selectedOrder.frame_description || "-" }}
        </div>
    </v-col>

    <!-- CODE -->
    <v-col cols="12" md="6">
        <span class="text-caption text-medium-emphasis">
            Frame Code
        </span>

        <div class="text-body-1 font-weight-medium">
            {{ selectedOrder.frame_code || "-" }}
        </div>
    </v-col>

    <!-- COLOR -->
    <v-col cols="12" md="6">
        <span class="text-caption text-medium-emphasis">
            Color
        </span>

        <div class="text-body-1 font-weight-medium">
            {{ selectedOrder.frame_color || "-" }}
        </div>
    </v-col>

    <!-- SERIAL -->
    <v-col cols="12" md="6">
        <span class="text-caption text-medium-emphasis">
            Serial Number
        </span>

        <div class="text-body-1 font-weight-medium">
            {{ selectedOrder.serial_no || "-" }}
        </div>
    </v-col>

    <!-- UNIT PRICE -->
    <v-col cols="12" md="6">
        <span class="text-caption text-medium-emphasis">
            Selling Price
        </span>

        <div class="text-body-1 font-weight-bold text-primary">
            ₱{{
                Number(
                    selectedOrder.unit_price || 0
                ).toLocaleString("en-PH", {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2,
                })
            }}
        </div>
    </v-col>

    <!-- FEATURES -->
    <v-col cols="12">
        <span class="text-caption text-medium-emphasis">
            Additional Features
        </span>

        <div class="text-body-1 font-weight-medium">
            {{ selectedOrder.additional_features || "-" }}
        </div>
    </v-col>

    <!-- STATUS -->
    <v-col cols="12">
        <span class="text-caption text-medium-emphasis">
            Current Status
        </span>

        <div class="mt-1">
            <v-chip
                :color="
                    statusColor(
                        selectedOrder.glasses_status
                    )
                "
                variant="tonal"
            >
                <v-icon
                    :icon="
                        statusIcon(
                            selectedOrder.glasses_status
                        )
                    "
                    start
                />

                {{
                    selectedOrder.glasses_status ||
                    "Ordered"
                }}
            </v-chip>
        </div>
    </v-col>

    <!-- TRACKING HISTORY -->
    <v-col cols="12">
        <div class="text-subtitle-2 font-weight-bold mb-3">
            <v-icon
                icon="mdi-timeline-clock-outline"
                class="mr-2"
                color="primary"
            />

            Order Tracking
        </div>

        <v-timeline
            v-if="
                selectedOrder.tracking &&
                selectedOrder.tracking.length
            "
            density="compact"
            side="end"
        >
            <v-timeline-item
                v-for="track in selectedOrder.tracking"
                :key="track.id"
                :dot-color="statusColor(track.status)"
                size="small"
            >
                <template #opposite>
                    <div class="text-caption text-medium-emphasis">
                        {{ formatDateTime(track.created_at) }}
                    </div>
                </template>

                <div>
                    <div class="font-weight-bold">
                        {{ track.status }}
                    </div>

                    <div
                        v-if="track.remarks"
                        class="text-body-2 text-medium-emphasis"
                    >
                        {{ track.remarks }}
                    </div>

<div class="text-caption text-medium-emphasis mt-2">
    <v-icon
        icon="mdi-account-outline"
        size="14"
        class="mr-1"
    />

    Updated by:
    <strong>
        {{ track.created_by_name || "System" }}
    </strong>
</div>

<div class="text-caption text-medium-emphasis">
    <v-icon
        icon="mdi-clock-outline"
        size="14"
        class="mr-1"
    />

    Updated at:
    {{ formatDateTime(track.created_at) }}
</div>
                </div>
            </v-timeline-item>
        </v-timeline>

        <v-alert
            v-else
            type="info"
            variant="tonal"
            density="comfortable"
        >
            No tracking history available.
        </v-alert>
    </v-col>

</v-row>

                    </v-card-text>

                    <v-card-actions class="px-6 py-4 bg-grey-lighten-5">
                        <v-spacer />

                        <v-btn
                            variant="outlined"
                            rounded="lg"
                            @click="viewDialog = false"
                        >
                            Close
                        </v-btn>

                        <v-btn
                            color="primary"
                            rounded="lg"
                            prepend-icon="mdi-swap-horizontal"
                            @click="
                                viewDialog = false;
                                openStatusDialog(selectedOrder);
                            "
                        >
                            Update Status
                        </v-btn>
                    </v-card-actions>

                </v-card>
            </v-dialog>


            <!-- STATUS DIALOG -->
            <v-dialog
                v-model="statusDialog"
                max-width="550px"
            >
                <v-card rounded="xl">

                    <v-card-title
                        class="d-flex align-center px-6 py-4 bg-grey-lighten-5 border-b"
                    >
                        <v-icon
                            icon="mdi-truck-fast-outline"
                            color="primary"
                            class="mr-3"
                        />

                        <span class="text-h6 font-weight-bold">
                            Update Glasses Status
                        </span>

                        <v-spacer />

                        <v-btn
                            icon="mdi-close"
                            variant="text"
                            @click="statusDialog = false"
                        />
                    </v-card-title>

                    <v-card-text
                        v-if="selectedOrder"
                        class="pa-6"
                    >

                        <div class="mb-5">
    <div class="text-caption text-medium-emphasis">
        Glasses
    </div>

    <div class="text-subtitle-1 font-weight-bold">
        {{ selectedOrder.frame_brand || "Generic" }}
        {{ selectedOrder.frame_model || "" }}
    </div>

    <div class="text-body-2 text-medium-emphasis">
        {{ selectedOrder.frame_description || "-" }}
    </div>

    <div class="text-caption text-medium-emphasis mt-1">
        Code:
        {{ selectedOrder.frame_code || "-" }}

        <span v-if="selectedOrder.frame_color">
            • {{ selectedOrder.frame_color }}
        </span>
    </div>

    <div class="text-caption text-medium-emphasis mt-1">
        Serial:
        {{ selectedOrder.serial_no || "No serial" }}
    </div>

    <div class="text-body-2 font-weight-bold text-primary mt-2">
        ₱{{
            Number(
                selectedOrder.unit_price || 0
            ).toLocaleString("en-PH", {
                minimumFractionDigits: 2,
                maximumFractionDigits: 2,
            })
        }}
    </div>
</div>

                        <v-select
                            v-model="newStatus"
                            :items="statusOptions"
                            label="Glasses Status"
                            variant="outlined"
                            density="comfortable"
                            prepend-inner-icon="mdi-package-variant"
                        />

                    </v-card-text>

                    <v-card-actions
                        class="px-6 py-4 bg-grey-lighten-5"
                    >
                        <v-spacer />

                        <v-btn
                            variant="outlined"
                            rounded="lg"
                            @click="statusDialog = false"
                        >
                            Cancel
                        </v-btn>

                        <v-btn
                            color="primary"
                            rounded="lg"
                            prepend-icon="mdi-check"
                            :loading="savingStatus"
                            @click="updateStatus"
                        >
                            Update Status
                        </v-btn>
                    </v-card-actions>

                </v-card>
            </v-dialog>

        </v-container>
    </DashboardLayout>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import axios from "axios";
import moment from "moment";
import Swal from "sweetalert2";

import DashboardLayout from "@/Layouts/DashboardLayout.vue";

const props = defineProps({
    orders: {
        type: Array,
        default: () => [],
    },
});

const search = ref("");
const loading = ref(false);



const viewDialog = ref(false);
const statusDialog = ref(false);


const selectedOrder = ref(null);
const newStatus = ref(null);
const savingStatus = ref(false);
const returnDialog = ref(false);

const returnType = ref(null);
const returnRemarks = ref("");
const savingReturn = ref(false);


const getCurrentStatus = (order) => {
    if (order.tracking && order.tracking.length) {
        // Backend returns tracking newest first
        return order.tracking[0].status || order.glasses_status || order.status;
    }

    return order.glasses_status || order.status || "Ordered";
};
const statusOptions = [
    "Ordered",
    "Sent to Lab",
    "On Route to Clinic",
    "On Clinic",
    "Given to Patient",
];
const returnOptions = [
    "Returned - Defective",
    "Returned - For Repair",
    "Repair Completed",
    "Replacement Issued",
    "Returned to Patient",
];
const ordersList = ref(
    props.orders.map((order) => ({
        ...order,
        id: order.id ?? order.glasses_order_id,
        glasses_status: getCurrentStatus(order),
    }))
);
const openReturnDialog = (order) => {
    if (order.glasses_status !== "Given to Patient") {
        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "info",
            title: "Return is only available for completed orders.",
            showConfirmButton: false,
            timer: 3000,
        });

        return;
    }

    selectedOrder.value = {
        ...order,
        id: order.id ?? order.glasses_order_id,
    };

    returnType.value = null;
    returnRemarks.value = "";

    returnDialog.value = true;
};
const saveReturn = async () => {
    if (!selectedOrder.value) {
        return;
    }

    if (!returnType.value) {
        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "warning",
            title: "Please select a return type.",
            showConfirmButton: false,
            timer: 3000,
        });

        return;
    }

    const orderId =
        selectedOrder.value.id ??
        selectedOrder.value.glasses_order_id;

    savingReturn.value = true;

    try {
        const response = await axios.post(
            `/glasses-orders/${orderId}/return`,
            {
                status: returnType.value,
                remarks: returnRemarks.value || null,
            }
        );

const updatedOrder =
    response.data.order ?? response.data;

const currentStatus = getCurrentStatus(updatedOrder);

        /*
         * Update table row
         */
        const index = ordersList.value.findIndex(
            (order) =>
                (order.id ?? order.glasses_order_id) == orderId
        );

        if (index !== -1) {
            ordersList.value[index] = {
                ...ordersList.value[index],
                ...updatedOrder,

                /*
                 * IMPORTANT:
                 * The actual order remains Given to Patient.
                 */
                glasses_status:
                    updatedOrder.glasses_status ??
                    ordersList.value[index].glasses_status,
            };
        }

        /*
         * Update selected order
         */
        selectedOrder.value = {
            ...selectedOrder.value,
            ...updatedOrder,
        };

        returnDialog.value = false;

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "success",
            title: "Return / repair record saved.",
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
        });

    } catch (error) {
        console.error(
            "Error saving return:",
            error.response?.data ?? error
        );

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: "Unable to save return.",
            text:
                error.response?.data?.message ??
                "Please try again.",
            showConfirmButton: false,
            timer: 4000,
        });
    } finally {
        savingReturn.value = false;
    }
};

const headers = [
    {
        title: "Patient",
        key: "patient",
    },
    {
        title: "Glasses",
        key: "order",
    },
    {
        title: "Features",
        key: "features",
    },
    {
        title: "Status",
        key: "glasses_status",
    },
    {
        title: "Ordered",
        key: "created_at",
    },
    {
    title: "Price",
    key: "unit_price",
    align: "end",
},
    {
        title: "Actions",
        key: "actions",
        sortable: false,
        align: "end",
    },
];

const statusSummary = [
    {
        label: "Ordered",
        value: "Ordered",
        color: "primary",
        icon: "mdi-cart-outline",
    },
    {
        label: "Sent to Lab",
        value: "Sent to Lab",
        color: "orange",
        icon: "mdi-factory",
    },
    {
        label: "On Route",
        value: "On Route to Clinic",
        color: "deep-purple",
        icon: "mdi-truck-fast-outline",
    },
    {
        label: "On Clinic",
        value: "On Clinic",
        color: "blue",
        icon: "mdi-storefront-outline",
    },
    {
        label: "Given to Patient",
        value: "Given to Patient",
        color: "success",
        icon: "mdi-account-check-outline",
    },
];

const statusFilter = ref(null);

const filteredOrders = computed(() => {
    if (!statusFilter.value) {
        return ordersList.value;
    }

    return ordersList.value.filter(
        (order) =>
            (order.glasses_status || "Ordered") ===
            statusFilter.value
    );
});

const countStatus = (status) => {
    return ordersList.value.filter(
        (order) =>
            (order.glasses_status || "Ordered") === status
    ).length;
};
const openStatusDialog = (order) => {

    if (order.glasses_status === "Given to Patient") {
        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "info",
            title: "This glasses order is already closed.",
            text: "Use the Return / Repair workflow if the patient returns the glasses.",
            showConfirmButton: false,
            timer: 3500,
            timerProgressBar: true,
        });

        return;
    }

    const orderId =
        order.id ??
        order.glasses_order_id;

    if (!orderId) {
        console.error("Invalid glasses order:", order);

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: "Glasses order ID is missing.",
            showConfirmButton: false,
            timer: 3000,
        });

        return;
    }

    selectedOrder.value = {
        ...order,
        id: orderId,
    };

    newStatus.value =
        order.glasses_status ?? "Ordered";

    statusDialog.value = true;
};

const statusColor = (status) => {
    switch (status) {
        case "Ordered":
            return "primary";

        case "Sent to Lab":
            return "orange";

        case "On Route to Clinic":
            return "deep-purple";

        case "On Clinic":
            return "blue";

        case "Given to Patient":
            return "success";

        default:
            return "grey";
    }
};

const statusIcon = (status) => {
    switch (status) {
        case "Ordered":
            return "mdi-cart-outline";

        case "Sent to Lab":
            return "mdi-factory";

        case "On Route to Clinic":
            return "mdi-truck-fast-outline";

        case "On Clinic":
            return "mdi-storefront-outline";

        case "Given to Patient":
            return "mdi-account-check-outline";

        default:
            return "mdi-help-circle-outline";
    }
};

const formatDateTime = (date) => {
    if (!date) {
        return "-";
    }

    return moment(date).format("MMM DD, YYYY h:mm A");
};

const loadOrders = async () => {
    loading.value = true;

    try {
        const response = await axios.get("/glasses-orders");

        const orders = response.data.orders ?? [];

ordersList.value = orders.map((order) => ({
    ...order,

    id: order.id ?? order.glasses_order_id,

    // Always use the latest tracking status
    glasses_status: getCurrentStatus(order),
}));

    } catch (error) {
        console.error(
            "Error loading glasses orders:",
            error.response?.data ?? error
        );

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: "Unable to load glasses orders.",
            showConfirmButton: false,
            timer: 3000,
        });
    } finally {
        loading.value = false;
    }
};

const viewOrder = (order) => {
    selectedOrder.value = order;
    viewDialog.value = true;
};


const updateStatus = async () => {
    if (!selectedOrder.value) {
        return;
    }

    const orderId =
        selectedOrder.value.id ??
        selectedOrder.value.glasses_order_id;

    if (!orderId) {
        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: "Glasses order ID is missing.",
            showConfirmButton: false,
            timer: 3000,
        });

        return;
    }

    if (!newStatus.value) {
        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "warning",
            title: "Please select a status.",
            showConfirmButton: false,
            timer: 3000,
        });

        return;
    }

    savingStatus.value = true;

    try {

        const response = await axios.put(
            `/glasses-orders/${orderId}`,
            {
                status: newStatus.value,
            }
        );

const updatedOrder =
    response.data.order ?? response.data;

const currentStatus = getCurrentStatus(updatedOrder);

        /*
        |--------------------------------------------------------------------------
        | Normalize order
        |--------------------------------------------------------------------------
        */

        const normalizedOrder = {
            ...updatedOrder,

            id:
                updatedOrder.id ??
                updatedOrder.glasses_order_id ??
                orderId,

            glasses_status:
                updatedOrder.status ??
                updatedOrder.glasses_status ??
                newStatus.value,

            tracking:
                updatedOrder.tracking ?? [],
        };

        /*
        |--------------------------------------------------------------------------
        | Update table
        |--------------------------------------------------------------------------
        */

        const index = ordersList.value.findIndex(
            (order) =>
                Number(order.id ?? order.glasses_order_id) ===
                Number(orderId)
        );

        if (index !== -1) {
            ordersList.value[index] = {
                ...ordersList.value[index],
                ...normalizedOrder,
            };
        }

        /*
        |--------------------------------------------------------------------------
        | Update selected order
        |--------------------------------------------------------------------------
        */

        selectedOrder.value = {
            ...selectedOrder.value,
            ...normalizedOrder,
        };

        statusDialog.value = false;

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "success",
            title: "Glasses status successfully updated.",
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
        });

    } catch (error) {

        console.error(
            "Error updating glasses status:",
            error.response?.data ?? error
        );

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: "Unable to update glasses status.",
            text:
                error.response?.data?.message ??
                "Please try again.",
            showConfirmButton: false,
            timer: 4000,
        });

    } finally {
        savingStatus.value = false;
    }
};

onMounted(() => {
    /*
     * If orders were not supplied by Inertia,
     * load them from the API.
     */
    if (!props.orders.length) {
        loadOrders();
    }
});
</script>

<style scoped>
.gap-1 {
    gap: 4px;
}

.gap-3 {
    gap: 12px;
}

.clean-table :deep(th) {
    font-weight: 600;
}

.clean-table :deep(td) {
    vertical-align: middle;
}
</style>