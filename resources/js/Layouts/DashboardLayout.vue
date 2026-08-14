<template>
    <v-app>
        <!-- APP BAR -->
        <v-app-bar
            color="#518ded"
            prominent
            app
            flat
            class="elevation-3 app-bar"
        >
            <!-- Drawer toggle -->
            <v-app-bar-nav-icon
                @click="drawer = !drawer"
                color="white"
                class="mr-2"
            ></v-app-bar-nav-icon>

            <!-- Title -->
            <v-toolbar-title class="white--text font-weight-bold text-uppercase tracking-wider">
                <v-icon color="white" class="mr-2">mdi-eye</v-icon>
                {{ appName }}
            </v-toolbar-title>

            <v-spacer></v-spacer>

            <!-- Profile Menu -->
            <v-menu transition="slide-y-transition" offset-y>
                <template v-slot:activator="{ props }">
                    <div class="d-flex align-center">
                        <span class="white--text font-weight-medium mr-2">
                            {{ $page.props.auth.user.name }}
                        </span>
                        <v-btn v-bind="props" icon color="white">
                            <v-icon>mdi-account-circle</v-icon>
                        </v-btn>
                    </div>
                </template>

                <v-list class="py-2">
                    <v-list-item prepend-icon="mdi-account-cog" @click="$inertia.visit(route('profile.show'))">
                        <v-list-item-title>Manage Profile</v-list-item-title>
                    </v-list-item>
                    <v-divider></v-divider>
                    <v-list-item prepend-icon="mdi-logout" @click="logout">
                        <v-list-item-title>Logout</v-list-item-title>
                    </v-list-item>
                </v-list>
            </v-menu>
        </v-app-bar>

        <!-- NAVIGATION DRAWER -->
        <v-navigation-drawer
            v-model="drawer"
            app
    :permanent="!$vuetify.display.smAndDown"
    :temporary="$vuetify.display.smAndDown"
            width="280"
            color="#ffffff"
            elevation="3"
            class="drawer"
        >
            <!-- Drawer Header -->
            <div class="px-4 pt-6 pb-4 text-center border-bottom">
                <v-avatar size="64" class="elevation-2">
                    <v-icon size="42" color="#002868">mdi-account</v-icon>
                </v-avatar>
                <h3 class="mt-3 mb-1 font-weight-medium text-primary">
                    {{ $page.props.auth.user.name }}
                </h3>
                <p class="text-caption text-grey-darken-1">
                    {{ $page.props.auth.user.type }}
                </p>
            </div>

            <v-divider class="my-2"></v-divider>

            <v-list nav dense>
                <!-- Dashboard -->
                <v-list-item
                    prepend-icon="mdi-view-dashboard"
                    class="drawer-link"
                    @click="$inertia.visit(route('dashboard'))"
                >
                    <v-list-item-title>Dashboard</v-list-item-title>
                </v-list-item>
                                    <v-list-item prepend-icon="mdi-calendar-check" class="drawer-link" @click="$inertia.visit('/visits')">
                        <v-list-item-title>Visits</v-list-item-title>
                    </v-list-item>
                                                        <v-list-item prepend-icon="mdi-account-group" class="drawer-link" @click="$inertia.visit('/patients')">
                        <v-list-item-title>Patients</v-list-item-title>
                    </v-list-item>


                <!-- Admin Libraries -->
                <v-list-group
                    v-if="$page.props.auth.user.type === 'Administrator'"
                    prepend-icon="mdi-cog-play"
                    value="true"
                    class="drawer-group"
                >
                    <template v-slot:activator="{ props }">
                        <v-list-item v-bind="props" class="drawer-link">
                            <v-list-item-title>Libraries</v-list-item-title>
                        </v-list-item>
                    </template>

                    <v-list-item prepend-icon="mdi-cash-multiple" class="drawer-link" @click="$inertia.visit('/visits')">
                        <v-list-item-title>Visits</v-list-item-title>
                    </v-list-item>
                </v-list-group>

                <!-- User Management -->
                <v-list-item
                    v-if="$page.props.auth.user.type === 'Administrator'"
                    prepend-icon="mdi-account-cog"
                    class="drawer-link"
                    @click="$inertia.visit('/users')"
                >
                    <v-list-item-title>User Management</v-list-item-title>
                </v-list-item>

                <v-divider class="my-2"></v-divider>

                <!-- Logout -->
                <v-list-item prepend-icon="mdi-logout" class="drawer-link" @click="logout">
                    <v-list-item-title>Logout</v-list-item-title>
                </v-list-item>
            </v-list>
        </v-navigation-drawer>

        <!-- MAIN CONTENT -->
        <v-main class="bg-light">
            <v-container fluid class="py-6 px-8">
                <slot></slot>
            </v-container>
        </v-main>
    </v-app>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { usePage, router } from "@inertiajs/vue3";
import { useUserStore } from "@/stores/user";

const page = usePage();
const drawer = ref(true);
const appName = import.meta.env.VITE_APP_NAME;
const userStore = useUserStore();

onMounted(() => {
    const apiToken = localStorage.getItem("api_token");
    if (apiToken) {
        window.axios.defaults.headers.common["Authorization"] = `Bearer ${apiToken}`;
    }
});

const logout = () => {
    localStorage.removeItem("api_token");
    router.post(route("logout"));
};
</script>

<style scoped>
/* --- Global look --- */
.bg-light {
    background-color: #f4f7fb;
}

/* --- App Bar --- */
.app-bar {
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
}

/* --- Drawer look --- */
.drawer {
    border-right: 1px solid #e0e6f1;
}

/* --- Drawer hover effects --- */
.drawer-link {
    border-radius: 12px;
    margin: 4px 8px;
    color: #333;
    font-weight: 500;
    transition: all 0.25s ease;
}

.drawer-link:hover {
    background-color: #e9eefc;
    color: #002868;
    transform: translateX(3px);
}

/* --- Animations --- */
.v-list-item {
    transition: background-color 0.3s ease, color 0.3s ease;
}

.text-primary {
    color: #002868;
}
</style>
