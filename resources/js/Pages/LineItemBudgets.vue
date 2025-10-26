<template>

    <Head title="Line Item Budgets" />
    <DashboardLayout>
        <v-card>
            <v-card-title class="d-flex align-center pe-2">
                <v-icon icon="mdi-cash-multiple"></v-icon> &nbsp;
                Line Budget Items
                <v-spacer></v-spacer>
                <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
                    variant="solo-filled" flat hide-details single-line></v-text-field>
            </v-card-title>
            <v-card-text>
                <v-row>
                    <v-col class="mb-2">
                        <v-btn color="#002868" size="small" rounded="lg" prepend-icon="mdi-plus-thick"
                            @click="openDialog()" class="mr-2 mb-2">Add new</v-btn>
                        <v-btn color="#ffdd00" size="small" rounded="lg" prepend-icon="mdi-refresh"
                            @click="$inertia.visit('/expenselineitems')" class="mr-2 mb-2">Refresh</v-btn>
                    </v-col>
                </v-row>
                <v-data-table :headers="headers" :items="expenselineitems" :search="search">

                    <template v-slot:item.datecreated="{ item }">
                        {{ formatDate(item.datecreated) }}
                    </template>
                    <template v-slot:item.dateupdated="{ item }">
                        {{ formatDate(item.dateupdated) }}
                    </template>
                    <template v-slot:item.statustext="{ item }">
                        <span :class="getStatusClass(item.statustext)">
                            {{ item.statustext }}
                        </span>
                    </template>
                    <template v-slot:item.actions="{ item }">
                        <v-icon class='mr-2' icon="mdi-pencil" @click="openDialog(item)"></v-icon>
                        <v-icon icon="mdi-cancel" @click="showDeleteDialog(item)"></v-icon>
                    </template>
                </v-data-table>
                <!-- Dialog for Add and edit -->
                <v-dialog v-model="dialogvisible" max-width="800">
                    <v-form ref="addChecker">
                        <v-card>
                            <v-toolbar dark color="#3b3b3b" height="50">
                                <v-toolbar-title>P A P S</v-toolbar-title>
                                <v-btn icon @click="dialogvisible = false">
                                    <v-icon>mdi-close-circle-outline</v-icon>
                                </v-btn>
                            </v-toolbar>
                            <v-card-text class="py-3">
                                <v-row dense>
                                    <v-col cols="6">
                                        <v-text-field v-model="form.expenselineitem" label="Description"
                                            variant="outlined" required :rules="[rules.required]" dense
                                            aria-label="Description"></v-text-field>
                                    </v-col>
                                    <v-col cols="6">
                                        <v-autocomplete v-model="form.expensetypeid" :items="expensetypes"
                                            item-title="expensetype" item-value="id" label="Expense Type" variant="outlined"
                                            required :rules="[rules.required]" dense aria-label="Expense Type">
                                        </v-autocomplete>
                                    </v-col>
                                </v-row>
                                <v-row dense>
                                    <v-col cols="4">
                                        <v-text-field v-model="form.uacscode" label="uacscode" variant="outlined"
                                            required :rules="[rules.required]" type="number" dense
                                            aria-label="uacscode"></v-text-field>
                                    </v-col>
                                    <v-col cols="4">
                                        <v-select v-model="form.status" :items="statuses" item-title="status"
                                            item-value="id" label="Status" variant="outlined" required
                                            :rules="[rules.required]" dense aria-label="Status"></v-select>
                                    </v-col>
                                </v-row>
                                <v-row dense class="justify-end">
                                    <v-btn color="primary" @click="submitForm" density="comfortable" text class="mr-2"
                                        prepend-icon="mdi-check-circle">
                                        Save
                                    </v-btn>
                                    <v-btn color="red" density="comfortable" text prepend-icon="mdi-cancel"
                                        @click="dialogvisible = false">
                                        Close
                                    </v-btn>
                                </v-row>
                            </v-card-text>
                        </v-card>
                    </v-form>
                </v-dialog>

            </v-card-text>
        </v-card>
    </DashboardLayout>


</template>

<script setup>
import { ref, defineProps, computed, watch, } from 'vue';
import { useForm, router, Head } from '@inertiajs/vue3';
import DashboardLayout from '@/Layouts/DashboardLayout.vue';
import axios from 'axios';

const rules = {
    required: value => !!value || 'This field is required.',
    isNumber: value =>
        (value !== null && value !== '' && !isNaN(value) && Number(value) >= 0) ||
        'This field must be a positive number.',
    isYear: value => {
        const currentYear = new Date().getFullYear();
        return (
            (value && !isNaN(value) && value >= 1900 && value <= 2099) ||
            'Enter a valid year between 1900 and 2099.'
        );
    }
};
const form = useForm({
    id: null,
    pap: null,
    status: null,
    acronym: null,
    uacscode: null,
});

const search = ref('');
const dialogvisible = ref(false);
const addChecker = ref();
const statuses = [
    { id: 'A', status: 'Active' },
    { id: 'I', status: 'Inactive' },
];
const props = defineProps({
    expenselineitems: Array,
    expensetypes: Array,
});
const headers = [
    // { title: ' ', key: 'view',width: "30px"},
    {
        title: 'Description',
        key: 'expenselineitem',
        width: "400px",
    },
    { title: 'Expense Type', key: 'expensetype' },
    { title: 'uacscode', key: 'uacscode' },
    { title: 'Created by', key: 'createdby' },
    { title: 'Date created', key: 'datecreated' },
    { title: 'Updated by', key: 'updatedby' },
    { title: 'Date updated', key: 'dateupdated' },
    { title: 'Status', key: 'statustext' },
    { title: 'Actions', key: 'actions', width: "100px" },
];
const openDialog = (items) => {

    if (items) {
        form.id = items.id;
        form.expenselineitem = items.expenselineitem;
        form.expensetypeid = items.expensetypeid;
        form.uacscode = items.uacscode;
        form.status = items.statustext;
        dialogvisible.value = true;
    } else {
        dialogvisible.value = true;
        form.id = '';
        form.expenselineitem = '';
        form.expensetypeid = '';
        form.uacscode = '';
        form.status = 'Active'
    };

};
const formatDate = (date) => {
    return moment(date).format('MMMM DD, YYYY h:mm a'); // Customize the format as needed
}
const submitForm = async () => {
    // console.log(form)
    addChecker.value?.validate().then(async ({ valid: isValid }) => {
        if (isValid) {
            const url = form.id ? `/expenselineitems/${form.id}` : '/expenselineitems';
            const method = form.id ? 'put' : 'post';

            router.visit(url, {
                method: method,
                data: form,
                preserveScroll: true,
                onSuccess: () => {
                    swal.fire({
                        text: "Expense Line Item has been saved.",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    dialogvisible.value = false;
                },
                onError: (errors) => {
                    console.error("Error:", errors);
                    swal.fire({
                        text: "Failed to save Expense Line Item.",
                        icon: "error",
                        showConfirmButton: true,
                    });
                },
            });
        }
    });
};
const showDeleteDialog = (item) => {
    swal.fire({
        title: "Are you sure?",
        text: "Do you want to deactivate this Expense Line Item?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Deactivate",
        cancelButtonText: "Cancel",
    }).then(async (result) => {
        if (result.isConfirmed) {
            const url = `/expenselineitems/${item.id}`;
            const method = 'put';
            const data = {
                id: item.id,
                expenselineitem: item.expenselineitem,
                expensetypeid: item.expensetypeid,
                uacscode: item.uacscode,
                status: 'I',
            };

            router.visit(url, {
                method,
                data,
                preserveScroll: true,
                onSuccess: () => {
                    swal.fire({
                        text: "Expense Line Item has been deactivated.",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                },
                onError: (errors) => {
                    console.error("Error:", errors);
                    swal.fire({
                        text: "Failed to deactivate Expense Line Item.",
                        icon: "error",
                        showConfirmButton: true,
                    });
                },
            });
        }
    });
};

// Function to get status class
const getStatusClass = (status) => {
    switch (status) {
        case 'Active':
            return 'status-active';
        case 'Inactive':
            return 'status-inactive';
        default:
            return '';
    }
};

</script>
<style>
.status-inactive {
    color: rgb(209, 27, 43);
    font-weight: bold;
}

.status-active {
    color: rgb(26, 185, 66);
    font-weight: bold;
}
</style>