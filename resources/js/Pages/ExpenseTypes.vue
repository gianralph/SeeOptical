<template>

    <Head title="Expense Types" />
    <DashboardLayout>
        <v-card>
            <v-card-title class="d-flex align-center pe-2">
                <v-icon icon="mdi-cash-multiple"></v-icon> &nbsp;
                Expense Types
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
                            @click="$inertia.visit('/expensetypes')" class="mr-2 mb-2">Refresh</v-btn>
                    </v-col>
                </v-row>
                <v-data-table :headers="headers" :items="expensetypes" :search="search">

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
                <v-dialog v-model="dialogvisible" max-width="600">
                    <v-form ref="addChecker">
                        <v-card>
                            <v-toolbar dark color="#3b3b3b" height="50">
                                <v-toolbar-title>Expense Type</v-toolbar-title>
                                <v-btn icon @click="dialogvisible = false">
                                    <v-icon>mdi-close-circle-outline</v-icon>
                                </v-btn>
                            </v-toolbar>
                            <v-card-text class="py-3">
                                <v-row dense>
                                    <v-col>
                                        <v-text-field v-model="form.expensetype" label="Description" variant="outlined"
                                            required :rules="[rules.required]" dense
                                            aria-label="Description"></v-text-field>
                                    </v-col>

                                </v-row>
                                <v-row dense>
                                    <v-col cols="6">
                                        <v-text-field v-model="form.acronym" label="Acronym" variant="outlined"
                                            required :rules="[rules.required]" dense
                                            aria-label="Acronym"></v-text-field>
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
    expensetype: null,
    status: null,
    acronym: null,
});

const search = ref('');
const dialogvisible = ref(false);
const addChecker = ref();
const statuses = [
    { id: 'A', status: 'Active' },
    { id: 'I', status: 'Inactive' },
];
const props = defineProps({
    expensetypes: Array,
});
const headers = [
    // { title: ' ', key: 'view',width: "30px"},
    {
        title: 'Description',
        key: 'expensetype',
        width: "400px",
    },
    {
        title: 'Acronym',
        key: 'acronym',
    },
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
        form.expensetype = items.expensetype;
        form.acronym = items.acronym;
        form.status = items.statustext;
        dialogvisible.value = true;
    } else {
        dialogvisible.value = true;
        form.id = '';
        form.expensetype = '';
        form.acronym = '';
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
            const url = form.id ? `/expensetypes/${form.id}` : '/expensetypes'; // Use form.id instead of id.value
            const method = form.id ? 'put' : 'post'; // Use form.id to decide the method

            router.visit(url, {
                method: method,
                data: form,
                preserveScroll: true,
                onSuccess: () => {
                    swal.fire({
                        text: "Expense Type has been saved.",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                    dialogvisible.value = false;
                },
                onError: (errors) => {
                    console.error("Error:", errors);
                    swal.fire({
                        text: "Failed to save Expense Type.",
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
        text: "Do you want to deactivate this Expense Type?",
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Deactivate",
        cancelButtonText: "Cancel",
    }).then(async (result) => {
        if (result.isConfirmed) {
            const url = `/expensetypes/${item.id}`;
            const method = 'put';
            const data = {
                id: item.id, 
                expensetype: item.expensetype,
                acronym: item.acronym, 
                status: 'I',
            };

            router.visit(url, {
                method,
                data,
                preserveScroll: true,
                onSuccess: () => {
                    swal.fire({
                        text: "Expense Type has been deactivated.",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1500,
                    });
                },
                onError: (errors) => {
                    console.error("Error:", errors);
                    swal.fire({
                        text: "Failed to deactivate Expense Type.",
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