<template>
    <DashboardLayout>
        <v-card>
            <v-card-title class="d-flex align-center pe-2">
                <v-icon icon="mdi-account"></v-icon> &nbsp;
                Employee Management
                <v-spacer></v-spacer>
                <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
                    variant="solo-filled" flat hide-details single-line></v-text-field>
            </v-card-title>
            <v-card-text>
                <v-btn color="primary" rounded="lg" prepend-icon="mdi-plus" @click="openDialog(null)" class="mr-2">Add Employee</v-btn>
                <v-btn color="#9CCC65"   rounded="lg" prepend-icon="mdi-refresh" @click="$inertia.visit('/employees')">Refresh</v-btn>

              
              
              
                <v-dialog v-model="dialogVisible" max-width="1200px">
                    <v-card>

                        <v-toolbar dark color="#3b3b3b" height="70" >
                            <v-icon class="ml-5">mdi-account</v-icon>
                            <span class="ml-3"> Employee information</span>
                            <v-spacer></v-spacer>
                            <v-btn class="ml-2" icon  @click="dialogVisible = false">
                                <v-icon>mdi-close-circle-outline</v-icon>
                            </v-btn>
                        </v-toolbar>

                        <!-- <v-card-title>{{ editingEmployee ? 'Update Employee' : 'Create Employee' }}</v-card-title> -->
                        <v-card-text>
                           
                            <!-- <v-card>
                                <v-card-text> -->
                                    <v-form @submit.prevent="submitForm" ref="myForm">

                                        <v-row class="mt-2">
                                            <v-col cols="12" md="3" sm="12">
                                                <v-text-field v-model="form.lastname" label="Last Name" required :rules="[rules.required]"></v-text-field>

                                            </v-col>
                                            <v-col cols="12" md="3" sm="12">
                                                <v-text-field v-model="form.firstname" label="First Name" required></v-text-field>

                                            </v-col>
                                            <v-col cols="12" md="3" sm="12">
                                                <v-text-field v-model="form.middlename" label="Middle Name"></v-text-field>

                                            </v-col>
                                            <v-col cols="12" md="3" sm="12">
                                                <v-text-field v-model="form.suffix" label="Suffix"></v-text-field>
                                            </v-col>
                                        </v-row>

                                        <v-row>
                                            <v-col cols="12" md="6" sm="12">
                                                <v-text-field v-model="form.position" label="Position" required></v-text-field>
                                            </v-col>
                                            <v-col cols="12" md="6" sm="12">
                                                <v-autocomplete v-model="form.sectionid" 
                                                :items="sections" color="blue-grey lighten-2" label="Office" 
                                                item-title="description" item-value="id"  
                                                auto-select-first>
                                            </v-autocomplete>
                                            </v-col>
                                        </v-row>

                                        <v-row>
                                            <v-col cols="12" md="2" sm="12">
                                            <v-select
                                            v-model="form.status"
                                            :items="statuses"
                                            item-title="status"
                                            item-value="id"
                                            label="Status"
                                            ></v-select>
                                            </v-col>
                                        </v-row>


                                        <v-row>
                                            <v-col cols="12" md="12" sm="12" class="d-flex justify-end">
                                                <v-btn prepend-icon="mdi-check-bold" class="mr-2"   @click="submitForm" color="primary">{{ editingEmployee ? 'Update' : 'Save' }}</v-btn>
                                            <v-btn  @click="dialogVisible = false">Close</v-btn>
                                            </v-col>
                                        </v-row>

                                        <!-- <v-toolbar dark color="white" height="50" >
                                            <v-spacer></v-spacer> -->
                                            <!-- <v-btn prepend-icon="mdi-check-bold" class="mr-2"   @click="submitForm" color="primary">{{ editingEmployee ? 'Update' : 'Save' }}</v-btn>
                                            <v-btn prepend-icon="mdi-close-box"   @click="dialogVisible = false" color="red">Cancel</v-btn> -->
                                        <!-- </v-toolbar> -->
                                
                                       
                                        <!-- <v-btn type="submit" color="primary">{{ editingEmployee ? 'Update' : 'Save' }}</v-btn> -->
                                    </v-form>
                                <!-- </v-card-text>
                            </v-card> -->
                         

                            
                        </v-card-text>
                    </v-card>
                </v-dialog>
                <v-data-table :headers="headers" :items="employees" v-model:search="search">
                    <template v-slot:item.actions="{ item }">
                        <v-icon icon="mdi-pencil" @click="openDialog(item)"></v-icon>
                        <v-icon icon="mdi-delete" @click="showDeleteDialog(item)"></v-icon>
                    </template>
                    <!-- Add additional templates for each column -->
                </v-data-table>
            </v-card-text>
        </v-card>
        <DeleteDialog v-model="deletedialogVisible" @confirm="confirmDelete" @cancel="cancelDelete" />
    </DashboardLayout>
</template>

<script setup>
    import {
        ref,
        defineProps
    } from 'vue';
    import { useForm, router } from '@inertiajs/vue3';

    import DashboardLayout from '@/Layouts/DashboardLayout.vue';
    import DeleteDialog from '@/Components/DeleteDialog.vue';
import { mdiSelectionSearch } from '@mdi/js';

    const deletedialogVisible = ref(false);
    const employee = ref(null);
    const status = ref("A"); // Default to 'Active'
    const confirmDelete = async () => {
        deletedialogVisible.value = false;
        await router.delete(`/employees/${employee.value.id}`);
    };

    const cancelDelete = () => {
        deletedialogVisible.value = false;
    };

    const rules = {
        required: value => !!value || 'Required.',
    };


    const myForm = ref();

    
    const headers = [
        { title: 'Last Name', key: 'lastname' },
        { title: 'First Name', key: 'firstname' },
        { title: 'Middle Name', key: 'middlename' },
        { title: 'Suffix', key: 'suffix' },
        { title: 'Position', key: 'position' },
        { title: 'Actions', key: 'actions', sortable: false },
    ];

    const form = useForm({
        lastname: '',
        firstname: '',
        middlename: '',
        suffix: '',
        position: '',
        status: '',
        sectionid: '',
    });

    const search = ref('');
    const props = defineProps({
        employees: Array,
        search: String,
        sections: Array,
    });

    const dialogVisible = ref(false);
    const editingEmployee = ref(null);

    const openDialog = (employee) => {

        if (employee) {
            editingEmployee.value = employee;
            form.lastname = employee.lastname;
            form.firstname = employee.firstname;
            form.middlename = employee.middlename;
            form.suffix = employee.suffix;
            form.position = employee.position;
            form.status = employee.status.charAt(0);
            form.created_by = employee.created_by;
            form.updated_by = employee.updated_by;
            form.sectionid = employee.sectionid;
        } else {
            editingEmployee.value = null;
            form.lastname = '';
            form.firstname = '';
            form.middlename = '';
            form.suffix = '';
            form.position = '';
            form.status = 'A';
            form.created_by = '';
            form.updated_by = '';
            form.sectionid = '';
        }
        dialogVisible.value = true;
    };

    const showDeleteDialog = (item) => {
        employee.value = item;
        deletedialogVisible.value = true;
    };

    const submitForm = async () => {
        myForm.value ?.validate().then(async ({
            valid: isValid
        }) => {
            if (isValid) {
                try {
                    if (editingEmployee.value) {
                        await form.put(`/employees/${editingEmployee.value.id}`);
                    } else {
                        await form.post('/employees');
                    }
                    swal.fire({
                        text: "User has been saved.",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1500
                    });
                    dialogVisible.value = false;
                } catch (error) {
                    console.error('Error submitting form:', error);
                }
            }
        })
    };

    const statuses = [
  { id: 'A', status: 'Active' },
  { id: 'I', status: 'Inactive' },
];
</script>
