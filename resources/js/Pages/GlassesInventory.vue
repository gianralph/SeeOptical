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
                                Glasses Inventory
                            </h2>

                            <p class="text-caption text-grey-medium mb-0">
                                Manage glasses frames, pricing and stock
                            </p>
                        </div>

                    </div>

                    <div class="d-flex align-center gap-3">

                        <v-text-field
                            v-model="search"
                            density="compact"
                            label="Search code, brand, model..."
                            prepend-inner-icon="mdi-magnify"
                            variant="outlined"
                            hide-details
                            single-line
                            clearable
                            style="width: 300px"
                            rounded="lg"
                        />

                        <v-btn
                            color="primary"
                            elevation="0"
                            rounded="lg"
                            prepend-icon="mdi-plus"
                            height="40"
                            class="text-none font-weight-medium px-4"
                            @click="openDialog()"
                        >
                            Add Glasses
                        </v-btn>

                    </div>
                </v-card-title>

                <v-divider />

                <!-- SUMMARY -->
                <v-card-text class="pa-6 pb-4">

                    <v-row>

                        <!-- TOTAL FRAMES -->
                        <v-col
                            cols="12"
                            sm="6"
                            md="3"
                        >
                            <v-card
                                variant="outlined"
                                rounded="lg"
                                class="pa-4 h-100"
                            >
                                <div class="d-flex align-center">

                                    <v-avatar
                                        color="primary"
                                        variant="tonal"
                                        size="42"
                                        class="mr-3"
                                    >
                                        <v-icon
                                            icon="mdi-glasses"
                                        />
                                    </v-avatar>

                                    <div>
                                        <div
                                            class="text-caption text-medium-emphasis"
                                        >
                                            Total Items
                                        </div>

                                        <div class="text-h5 font-weight-bold">
                                            {{ inventoryList.length }}
                                        </div>
                                    </div>

                                </div>
                            </v-card>
                        </v-col>

                        <!-- ACTIVE -->
                        <v-col
                            cols="12"
                            sm="6"
                            md="3"
                        >
                            <v-card
                                variant="outlined"
                                rounded="lg"
                                class="pa-4 h-100"
                            >
                                <div class="d-flex align-center">

                                    <v-avatar
                                        color="success"
                                        variant="tonal"
                                        size="42"
                                        class="mr-3"
                                    >
                                        <v-icon
                                            icon="mdi-check-circle-outline"
                                        />
                                    </v-avatar>

                                    <div>
                                        <div
                                            class="text-caption text-medium-emphasis"
                                        >
                                            Active Items
                                        </div>

                                        <div class="text-h5 font-weight-bold">
                                            {{ activeCount }}
                                        </div>
                                    </div>

                                </div>
                            </v-card>
                        </v-col>

                        <!-- AVAILABLE -->
                        <v-col
                            cols="12"
                            sm="6"
                            md="3"
                        >
                            <v-card
                                variant="outlined"
                                rounded="lg"
                                class="pa-4 h-100"
                            >
                                <div class="d-flex align-center">

                                    <v-avatar
                                        color="blue"
                                        variant="tonal"
                                        size="42"
                                        class="mr-3"
                                    >
                                        <v-icon
                                            icon="mdi-package-variant-closed"
                                        />
                                    </v-avatar>

                                    <div>
                                        <div
                                            class="text-caption text-medium-emphasis"
                                        >
                                            Available
                                        </div>

                                        <div class="text-h5 font-weight-bold">
                                            {{ availableCount }}
                                        </div>
                                    </div>

                                </div>
                            </v-card>
                        </v-col>

                        <!-- LOW STOCK -->
                        <v-col
                            cols="12"
                            sm="6"
                            md="3"
                        >
                            <v-card
                                variant="outlined"
                                rounded="lg"
                                class="pa-4 h-100"
                            >
                                <div class="d-flex align-center">

                                    <v-avatar
                                        color="warning"
                                        variant="tonal"
                                        size="42"
                                        class="mr-3"
                                    >
                                        <v-icon
                                            icon="mdi-alert-outline"
                                        />
                                    </v-avatar>

                                    <div>
                                        <div
                                            class="text-caption text-medium-emphasis"
                                        >
                                            Low Stock
                                        </div>

                                        <div class="text-h5 font-weight-bold">
                                            {{ lowStockCount }}
                                        </div>
                                    </div>

                                </div>
                            </v-card>
                        </v-col>

                    </v-row>

                </v-card-text>

                <!-- FILTER -->
                <v-card-text class="px-6 pt-2 pb-4">

                    <v-row>

                        <v-col
                            cols="12"
                            md="4"
                        >
                            <v-select
                                v-model="statusFilter"
                                :items="statusOptions"
                                label="Filter Status"
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
    :items="filteredInventory"
    :loading="loading"
    hover
    class="clean-table"
>

                        <!-- CODE -->
                        <template #item.code="{ item }">

                            <div class="py-2">

                                <div class="font-weight-bold">
                                    {{ item.code }}
                                </div>

                                <div
                                    class="text-caption text-medium-emphasis"
                                >
                                    ID: {{ item.id }}
                                </div>

                            </div>

                        </template>

                        <!-- FRAME -->
                        <template #item.frame="{ item }">

                            <div class="py-2">

                                <div class="font-weight-medium">
                                    {{ item.brand || "Generic" }}
                                    {{ item.model || "" }}
                                </div>

                                <div
                                    class="text-caption text-medium-emphasis"
                                >
                                    {{ item.description }}
                                </div>

                                <div
                                    v-if="item.color"
                                    class="text-caption text-medium-emphasis"
                                >
                                    Color:
                                    {{ item.color }}
                                </div>

                            </div>

                        </template>

                        <!-- STOCK -->
                        <template #item.stock="{ item }">

                            <div class="py-2">

                                <div class="d-flex align-center gap-2">

                                    <span
                                        class="font-weight-bold"
                                    >
                                        {{ item.available_quantity }}
                                    </span>

                                    <span
                                        class="text-caption text-medium-emphasis"
                                    >
                                        / {{ item.quantity }}
                                    </span>

                                </div>

                                <v-progress-linear
                                    :model-value="
                                        stockPercentage(item)
                                    "
                                    height="5"
                                    rounded
                                    class="mt-1"
                                    :color="
                                        stockColor(item)
                                    "
                                />

                            </div>

                        </template>

                        <!-- COST -->
                        <template #item.cost_price="{ item }">

                            <span>
                                {{ formatCurrency(item.cost_price) }}
                            </span>

                        </template>

                        <!-- SELLING PRICE -->
                        <template #item.selling_price="{ item }">

                            <span
                                class="font-weight-bold"
                            >
                                {{ formatCurrency(item.selling_price) }}
                            </span>

                        </template>

                        <!-- STATUS -->
                        <template #item.is_active="{ item }">

                            <v-chip
                                size="small"
                                variant="tonal"
                                :color="
                                    item.is_active
                                        ? 'success'
                                        : 'error'
                                "
                            >

                                <v-icon
                                    :icon="
                                        item.is_active
                                            ? 'mdi-check-circle-outline'
                                            : 'mdi-close-circle-outline'
                                    "
                                    start
                                    size="15"
                                />

                                {{
                                    item.is_active
                                        ? "Active"
                                        : "Inactive"
                                }}

                            </v-chip>

                        </template>

                        <!-- ACTIONS -->
                        <template #item.actions="{ item }">

                            <div
                                class="d-flex justify-end gap-1"
                            >

                                <!-- EDIT -->
                                <v-tooltip text="Edit">
                                    <template #activator="{ props }">

                                        <v-btn
                                            v-bind="props"
                                            icon="mdi-pencil-outline"
                                            variant="text"
                                            density="comfortable"
                                            color="primary"
                                            @click="
                                                openDialog(item)
                                            "
                                        />

                                    </template>
                                </v-tooltip>

                                <!-- STATUS -->
                                <v-tooltip
                                    :text="
                                        item.is_active
                                            ? 'Deactivate'
                                            : 'Activate'
                                    "
                                >
                                    <template #activator="{ props }">

                                        <v-btn
                                            v-bind="props"
                                            :icon="
                                                item.is_active
                                                    ? 'mdi-close-circle-outline'
                                                    : 'mdi-check-circle-outline'
                                            "
                                            variant="text"
                                            density="comfortable"
                                            :color="
                                                item.is_active
                                                    ? 'error'
                                                    : 'success'
                                            "
                                            :loading="
                                                statusLoadingId === item.id
                                            "
                                            @click="
                                                toggleStatus(item)
                                            "
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
                                    No glasses inventory found.
                                </p>

                            </div>

                        </template>

                    </v-data-table>

                </v-card-text>

            </v-card>


            <!-- ADD / EDIT DIALOG -->
            <v-dialog
                v-model="dialog"
                max-width="750px"
                persistent
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

                        <span
                            class="text-h6 font-weight-bold"
                        >
                            {{
                                editing
                                    ? "Edit Glasses"
                                    : "Add Glasses"
                            }}
                        </span>

                        <v-spacer />

                        <v-btn
                            icon="mdi-close"
                            variant="text"
                            @click="closeDialog"
                        />

                    </v-card-title>


                    <v-card-text class="pa-6">

                        <v-form
                            ref="formRef"
                            @submit.prevent="save"
                        >

                            <v-row>

                                <!-- CODE -->
                                <v-col
                                    cols="12"
                                    md="6"
                                >

                                    <v-text-field
                                        v-model="form.code"
                                        label="Frame Code"
                                        variant="outlined"
                                        density="comfortable"
                                        :rules="[
                                            rules.required
                                        ]"
                                    />

                                </v-col>

                                <!-- BRAND -->
                                <v-col
                                    cols="12"
                                    md="6"
                                >

                                    <v-text-field
                                        v-model="form.brand"
                                        label="Brand"
                                        variant="outlined"
                                        density="comfortable"
                                        prepend-inner-icon="mdi-tag-outline"
                                    />

                                </v-col>

                                <!-- MODEL -->
                                <v-col
                                    cols="12"
                                    md="6"
                                >

                                    <v-text-field
                                        v-model="form.model"
                                        label="Model"
                                        variant="outlined"
                                        density="comfortable"
                                    />

                                </v-col>

                                <!-- COLOR -->
                                <v-col
                                    cols="12"
                                    md="6"
                                >

                                    <v-text-field
                                        v-model="form.color"
                                        label="Color"
                                        variant="outlined"
                                        density="comfortable"
                                        prepend-inner-icon="mdi-palette-outline"
                                    />

                                </v-col>

                                <!-- DESCRIPTION -->
                                <v-col
                                    cols="12"
                                >

                                    <v-textarea
                                        v-model="form.description"
                                        label="Description"
                                        variant="outlined"
                                        density="comfortable"
                                        rows="2"
                                        :rules="[
                                            rules.required
                                        ]"
                                    />

                                </v-col>

                                <!-- QUANTITY -->
                                <v-col
                                    cols="12"
                                    md="4"
                                >

                                    <v-text-field
                                        v-model.number="form.quantity"
                                        label="Total Quantity"
                                        type="number"
                                        min="0"
                                        variant="outlined"
                                        density="comfortable"
                                        prepend-inner-icon="mdi-package-variant"
                                        :rules="[
                                            rules.required,
                                            rules.nonNegative
                                        ]"
                                    />

                                </v-col>

                                <!-- AVAILABLE -->
                                <v-col
                                    cols="12"
                                    md="4"
                                >

                                    <v-text-field
                                        v-model.number="
                                            form.available_quantity
                                        "
                                        label="Available Quantity"
                                        type="number"
                                        min="0"
                                        variant="outlined"
                                        density="comfortable"
                                        prepend-inner-icon="
                                            mdi-package-variant-closed
                                        "
                                        :rules="[
                                            rules.required,
                                            rules.nonNegative,
                                            availableRule
                                        ]"
                                    />

                                </v-col>

                                <!-- ACTIVE -->
                                <v-col
                                    cols="12"
                                    md="4"
                                    class="d-flex align-center"
                                >

                                    <v-switch
                                        v-model="form.is_active"
                                        label="Active"
                                        color="success"
                                        hide-details
                                    />

                                </v-col>

                                <!-- COST PRICE -->
                                <v-col
                                    cols="12"
                                    md="6"
                                >

                                    <v-text-field
                                        v-model.number="
                                            form.cost_price
                                        "
                                        label="Cost Price"
                                        type="number"
                                        min="0"
                                        step="0.01"
                                        variant="outlined"
                                        density="comfortable"
                                        prefix="₱"
                                        prepend-inner-icon="
                                            mdi-cash-minus
                                        "
                                        :rules="[
                                            rules.required,
                                            rules.nonNegative
                                        ]"
                                    />

                                </v-col>

                                <!-- SELLING PRICE -->
                                <v-col
                                    cols="12"
                                    md="6"
                                >

                                    <v-text-field
                                        v-model.number="
                                            form.selling_price
                                        "
                                        label="Selling Price"
                                        type="number"
                                        min="0"
                                        step="0.01"
                                        variant="outlined"
                                        density="comfortable"
                                        prefix="₱"
                                        prepend-inner-icon="
                                            mdi-cash-plus
                                        "
                                        :rules="[
                                            rules.required,
                                            rules.nonNegative
                                        ]"
                                    />

                                </v-col>

                            </v-row>

                        </v-form>

                    </v-card-text>


                    <v-card-actions
                        class="px-6 py-4 bg-grey-lighten-5"
                    >

                        <v-spacer />

                        <v-btn
                            variant="outlined"
                            rounded="lg"
                            @click="closeDialog"
                        >
                            Cancel
                        </v-btn>

                        <v-btn
                            color="primary"
                            rounded="lg"
                            prepend-icon="mdi-content-save-outline"
                            :loading="saving"
                            @click="save"
                        >
                            {{
                                editing
                                    ? "Update"
                                    : "Save"
                            }}
                        </v-btn>

                    </v-card-actions>

                </v-card>

            </v-dialog>

        </v-container>
    </DashboardLayout>
</template>


<script setup>
import {
    ref,
    computed,
} from "vue";

import axios from "axios";
import Swal from "sweetalert2";

import DashboardLayout from "@/Layouts/DashboardLayout.vue";


/*
|--------------------------------------------------------------------------
| PROPS
|--------------------------------------------------------------------------
*/

const props = defineProps({
    inventory: {
        type: Array,
        default: () => [],
    },
});


/*
|--------------------------------------------------------------------------
| STATE
|--------------------------------------------------------------------------
*/

const inventoryList = ref(
    props.inventory.map((item) => ({
        ...item,
        is_active: Boolean(item.is_active),
    }))
);

const search = ref("");

const loading = ref(false);

const dialog = ref(false);

const editing = ref(false);

const saving = ref(false);

const statusLoadingId = ref(null);

const formRef = ref(null);


/*
|--------------------------------------------------------------------------
| FORM
|--------------------------------------------------------------------------
*/

const emptyForm = () => ({
    id: null,

    code: "",

    brand: "",

    model: "",

    description: "",

    color: "",

    quantity: 0,

    available_quantity: 0,

    cost_price: 0,

    selling_price: 0,

    is_active: true,
});

const form = ref(emptyForm());


/*
|--------------------------------------------------------------------------
| HEADERS
|--------------------------------------------------------------------------
*/

const headers = [
    {
        title: "Code",
        key: "code",
        sortable: true,
    },

    {
        title: "Frame",
        key: "frame",
        sortable: false,
    },

    {
        title: "Stock",
        key: "stock",
        sortable: false,
    },

    {
        title: "Cost",
        key: "cost_price",
        sortable: true,
    },

    {
        title: "Selling Price",
        key: "selling_price",
        sortable: true,
    },

    {
        title: "Status",
        key: "is_active",
        sortable: true,
    },

    {
        title: "Actions",
        key: "actions",
        sortable: false,
        align: "end",
    },
];


/*
|--------------------------------------------------------------------------
| STATUS
|--------------------------------------------------------------------------
*/

const statusOptions = [
    {
        title: "Active",
        value: "active",
    },
    {
        title: "Inactive",
        value: "inactive",
    },
];


/*
|--------------------------------------------------------------------------
| FILTERED INVENTORY
|--------------------------------------------------------------------------
*/

const filteredInventory = computed(() => {
    const query = String(search.value ?? "").trim().toLowerCase();

    if (!query) {
        return inventoryList.value;
    }

    return inventoryList.value.filter((item) => {
        const searchableValues = [
            item.code,
            item.brand,
            item.model,
            item.description,
            item.color,
            item.quantity,
            item.cost_price,
            item.selling_price,
            item.status,
        ];

        return searchableValues.some((value) =>
            String(value ?? "")
                .toLowerCase()
                .includes(query)
        );
    });
});

const statusFilter = ref(null);


/*
|--------------------------------------------------------------------------
| SUMMARY
|--------------------------------------------------------------------------
*/

const activeCount = computed(() => {

    return inventoryList.value.filter(
        item => item.is_active
    ).length;

});

const availableCount = computed(() => {

    return inventoryList.value.reduce(
        (total, item) =>
            total + Number(item.available_quantity || 0),
        0
    );

});

const lowStockCount = computed(() => {

    return inventoryList.value.filter(
        item =>
            item.is_active &&
            Number(item.available_quantity) <= 2
    ).length;

});


/*
|--------------------------------------------------------------------------
| RULES
|--------------------------------------------------------------------------
*/

const rules = {

    required: value =>
        value !== null &&
        value !== undefined &&
        value !== ""
            ? true
            : "This field is required.",

    nonNegative: value =>
        Number(value) >= 0
            ? true
            : "Value cannot be negative.",
};


const availableRule = value => {

    return Number(value) <= Number(form.value.quantity)
        ? true
        : "Available quantity cannot exceed total quantity.";

};


/*
|--------------------------------------------------------------------------
| CURRENCY
|--------------------------------------------------------------------------
*/

const formatCurrency = value => {

    return new Intl.NumberFormat(
        "en-PH",
        {
            style: "currency",
            currency: "PHP",
        }
    ).format(
        Number(value || 0)
    );

};


/*
|--------------------------------------------------------------------------
| STOCK
|--------------------------------------------------------------------------
*/

const stockPercentage = item => {

    const quantity =
        Number(item.quantity || 0);

    const available =
        Number(item.available_quantity || 0);

    if (quantity <= 0) {
        return 0;
    }

    return Math.min(
        100,
        (available / quantity) * 100
    );

};


const stockColor = item => {

    const quantity =
        Number(item.quantity || 0);

    const available =
        Number(item.available_quantity || 0);

    if (available <= 0) {
        return "error";
    }

    if (
        quantity > 0 &&
        available <= Math.ceil(quantity * 0.25)
    ) {
        return "warning";
    }

    return "success";

};


/*
|--------------------------------------------------------------------------
| OPEN DIALOG
|--------------------------------------------------------------------------
*/

const openDialog = (item = null) => {

    editing.value = !!item;

    if (item) {

        form.value = {
            id: item.id,

            code: item.code ?? "",

            brand: item.brand ?? "",

            model: item.model ?? "",

            description: item.description ?? "",

            color: item.color ?? "",

            quantity:
                Number(item.quantity ?? 0),

            available_quantity:
                Number(item.available_quantity ?? 0),

            cost_price:
                Number(item.cost_price ?? 0),

            selling_price:
                Number(item.selling_price ?? 0),

            is_active:
                Boolean(item.is_active),
        };

    } else {

        form.value = emptyForm();

    }

    dialog.value = true;
};


/*
|--------------------------------------------------------------------------
| CLOSE
|--------------------------------------------------------------------------
*/

const closeDialog = () => {

    dialog.value = false;

    form.value = emptyForm();

    editing.value = false;

};


/*
|--------------------------------------------------------------------------
| SAVE
|--------------------------------------------------------------------------
*/

const save = async () => {
    const validation = await formRef.value?.validate();

    if (validation && !validation.valid) return;

    saving.value = true;

    try {
        const payload = {
            id: form.value.id || null,

            code: form.value.code,
            brand: form.value.brand || null,
            model: form.value.model || null,
            description: form.value.description,
            color: form.value.color || null,

            quantity: Number(form.value.quantity),
            available_quantity: Number(form.value.available_quantity),

            cost_price: Number(form.value.cost_price),
            selling_price: Number(form.value.selling_price),

            is_active: form.value.is_active ? 1 : 0,
        };

        const isUpdate = !!payload.id;

        console.log(
            isUpdate ? "Updating inventory:" : "Creating inventory:",
            payload
        );

        const response = await axios.post(
            "/glasses-inventory",
            payload
        );

        console.log("Save response:", response.data);

        await loadInventory();

        closeDialog();

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "success",
            title: isUpdate
                ? "Glasses inventory updated."
                : "Glasses inventory added.",
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true,
        });

    } catch (error) {
        console.error(
            "Error saving glasses inventory:",
            error.response?.data ?? error
        );

        const message = error.response?.data?.errors
            ? Object.values(error.response.data.errors)
                  .flat()
                  .join(" ")
            : error.response?.data?.message
              ?? error.message
              ?? "Unable to save glasses inventory.";

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: message,
            showConfirmButton: false,
            timer: 4000,
        });

    } finally {
        saving.value = false;
    }
};


/*
|--------------------------------------------------------------------------
| LOAD INVENTORY
|--------------------------------------------------------------------------
*/

const loadInventory = async () => {

    loading.value = true;

    try {

        const response = await axios.get(
            "/api/glasses-inventory"
        );

        const inventory =
            response.data.inventory ?? [];

        inventoryList.value =
            inventory.map(item => ({
                ...item,
                is_active:
                    Boolean(item.is_active),
            }));

    } catch (error) {

        console.error(
            "Error loading inventory:",
            error.response?.data ?? error
        );

    } finally {

        loading.value = false;

    }

};


/*
|--------------------------------------------------------------------------
| TOGGLE STATUS
|--------------------------------------------------------------------------
*/

const toggleStatus = async item => {

    const action =
        item.is_active
            ? "deactivate"
            : "activate";


    const result =
        await Swal.fire({

            title:
                item.is_active
                    ? "Deactivate frame?"
                    : "Activate frame?",

            text:
                item.is_active
                    ? "This frame will no longer appear as available for ordering."
                    : "This frame will become available for ordering.",

            icon: "warning",

            showCancelButton: true,

            confirmButtonText:
                item.is_active
                    ? "Deactivate"
                    : "Activate",

            cancelButtonText: "Cancel",

            reverseButtons: true,

        });


    if (!result.isConfirmed) {
        return;
    }


    statusLoadingId.value = item.id;


    try {

        const response =
            await axios.put(
                `/glasses-inventory/${item.id}/toggle-status`
            );


        const updated =
            response.data.inventory;


        const index =
            inventoryList.value.findIndex(
                x => x.id === item.id
            );


        if (index !== -1) {

            inventoryList.value[index] = {
                ...inventoryList.value[index],
                ...updated,
                is_active:
                    Boolean(updated.is_active),
            };

        }


        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "success",
            title:
                response.data.message,
            showConfirmButton: false,
            timer: 1500,
        });

    } catch (error) {

        console.error(
            "Error changing inventory status:",
            error.response?.data ?? error
        );


        Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title:
                "Unable to update frame status.",
            showConfirmButton: false,
            timer: 3000,
        });

    } finally {

        statusLoadingId.value = null;

    }

};
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

.clean-table :deep(th) {
    font-weight: 600;
}

.clean-table :deep(td) {
    vertical-align: middle;
}

</style>