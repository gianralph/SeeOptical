<template>
    <DashboardLayout>
        <v-card>
            <v-card-title class="d-flex align-center pe-2">
                <v-icon icon="mdi-account"></v-icon> &nbsp; User Accounts
                <v-spacer></v-spacer>
                <v-text-field
                    v-model="search"
                    density="compact"
                    label="Search"
                    prepend-inner-icon="mdi-magnify"
                    variant="solo-filled"
                    flat
                    hide-details
                    single-line
                ></v-text-field>
            </v-card-title>
            <v-card-text>
                <v-btn
                    color="primary"
                    rounded="lg"
                    prepend-icon="mdi-plus"
                    @click="openDialog(null)"
                    >Add User</v-btn
                >
                <v-dialog v-model="dialogVisible" max-width="1000px">
                    <v-card>
                        <v-card-title>{{
                            editingUser ? "Update User" : "Create User"
                        }}</v-card-title>
                        <v-card-text>
                            <v-form @submit.prevent="submitForm" ref="myForm">
                                <v-row>
                                    <v-col cols="12" md="3" sm="12">
                                        <v-autocomplete
                                            v-model="form.type"
                                            :rules="[rules.required]"
                                            :items="types"
                                            color="blue-grey lighten-2"
                                            label="User Type"
                                            item-title="type"
                                            item-value="type"
                                            variant="outlined"
                                        />
                                    </v-col>

                                    <v-col cols="12" md="9" sm="12">
                                        <v-autocomplete
                                            :items="employees"
                                            color="blue-grey lighten-2"
                                            label="Employee"
                                            item-title="description"
                                            item-value="id"
                                            v-model="form.employeeid"
                                            required
                                            :rules="[rules.required]"
                                            auto-select-first
                                            variant="outlined"
                                        >
                                        </v-autocomplete>
                                    </v-col>
                                </v-row>

                                <v-row>
                                    <v-col cols="12" md="7" sm="12">
                                        <v-text-field
                                            v-model="form.email"
                                            label="Email"
                                            :rules="[rules.required]"
                                            variant="outlined"
                                        ></v-text-field>
                                    </v-col>

                                    <v-col cols="12" md="5" sm="12">
                                        <v-text-field
                                            v-model="form.password"
                                            label="Password"
                                            :rules="[rules.required]"
                                            :append-icon="
                                                showPassword
                                                    ? 'mdi-eye-off'
                                                    : 'mdi-eye'
                                            "
                                            :type="
                                                showPassword
                                                    ? 'text'
                                                    : 'password'
                                            "
                                            @click:append="
                                                showPassword = !showPassword
                                            "
                                            v-if="!editingUser"
                                            variant="outlined"
                                        ></v-text-field>
                                    </v-col>
                                </v-row>

                                <v-row>
                                    <v-col cols="12" md="5" sm="12">
                                        <v-btn
                                            type="submit"
                                            color="primary"
                                            prepend-icon="mdi-check-bold"
                                            >{{
                                                editingUser ? "Update" : "Save"
                                            }}</v-btn
                                        >
                                    </v-col>
                                </v-row>
                            </v-form>
                        </v-card-text>
                    </v-card>
                </v-dialog>
                <v-data-table
                    :headers="headers"
                    :items="users"
                    v-model:search="search"
                >
                    <template v-slot:item.actions="{ item }">
                        <v-icon
                            icon="mdi-pencil"
                            @click="openDialog(item)"
                        ></v-icon>
                        <v-icon
                            icon="mdi-delete"
                            @click="showDeleteDialog(item)"
                        ></v-icon>
                    </template>
                    <!-- Add additional templates for each column -->
                </v-data-table>
            </v-card-text>
        </v-card>
        <DeleteDialog
            v-model="deletedialogVisible"
            @confirm="confirmDelete"
            @cancel="cancelDelete"
        />
    </DashboardLayout>
</template>

<script setup>
import { ref, defineProps } from "vue";
import { useForm, router } from "@inertiajs/vue3";

import DashboardLayout from "@/Layouts/DashboardLayout.vue";
import DeleteDialog from "@/Components/DeleteDialog.vue";
const deletedialogVisible = ref(false);
const user = ref(null);
const confirmDelete = async () => {
    deletedialogVisible.value = false;

    await router.delete(`/users/${user.value.id}`);
};
const cancelDelete = () => {
    deletedialogVisible.value = false;
};
const headers = [
    {
        title: "Name",
        key: "name",
    },
    {
        title: "Email",
        key: "email",
    },
    {
        title: "Type",
        key: "type",
    },
    // {
    //     title: "Area",
    //     key: "area",
    // },
    {
        title: "Actions",
        key: "actions",
        sortable: false,
    },
];
const form = useForm({
    // name: "",
    email: "",
    password: "",
    type: "",
    employeeid: "",
    // areaid: "",
});
const search = ref("");
const myForm = ref();
const props = defineProps({
    users: Array,
    search: "",
    employees: Array,
});
const showPassword = ref(false);

const rules = {
    required: (value) => !!value || "Required.",
};

const types = ref([
    {
        type: "Administrator",
    },
    {
        type: "User",
    },
]);
const dialogVisible = ref(false);
const editingUser = ref(null);

const openDialog = (user) => {
    if (user) {
        editingUser.value = user;
        // form.name = user.name;
        form.email = user.email;
        form.type = user.type;
        form.employeeid = user.employeeid;
        //  form.areaid = user.areaid;
    } else {
        editingUser.value = null;
        // form.name = "";
        form.email = "";
        //  form.areaid = "";
        form.type = "User";
        form.employeeid = "";
        form.password = "";
    }
    dialogVisible.value = true;
};
const showDeleteDialog = (item) => {
    user.value = item; // Store the selected user
    deletedialogVisible.value = true; // Show the delete dialog
};
const submitForm = async () => {
    myForm.value?.validate().then(async ({ valid: isValid }) => {
        if (isValid) {
            try {
                if (editingUser.value) {
                    await form.put(`/users/${editingUser.value.id}`);
                } else {
                    await form.post("/users");
                }
                dialogVisible.value = false; // Close the dialog after successful submission
            } catch (error) {
                // Handle any errors here
                console.error("Error submitting form:", error);
            }
        }
    });
};
</script>
