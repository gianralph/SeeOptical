<template>
    <AppLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Dashboard
            </h2>
        </template>

        <!-- <v-card class="bg-grey-lighten-2 fill-height d-flex" style="height: 100%;"> -->

            <!-- Place AdminDashboard at the top -->
         <!-- Container for AdminDashboard with limited width -->
         
         
         
         
         <div class="w-4/5 mx-auto my-4 mt-30"> <!-- Width set to 80% and centered -->
            <!-- <v-card>
                <v-card-text> -->
                    <!-- <AdminDashboard/> -->
                    <AdminDashboardv1/>
                <!-- </v-card-text>
            </v-card> -->
        </div>

            <!-- Additional content below AdminDashboard -->
            <!-- <v-card-text> -->
                <!-- <span class="ml-5 mt-5">Dashboard</span> -->
                <!-- You can include other components or content here if needed -->
            <!-- </v-card-text> -->
        <!-- </v-card> -->

        <!-- Uncomment and adjust this section if needed -->
        <!-- 
        <div class="py-12" width="1400px">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                    <Welcome />
                    <AdminDashboard/>
                </div>
            </div>
        </div>
        -->
    </AppLayout>
</template>

<script setup>
import AppLayout from '@/Layouts/AppLayout.vue';
import Welcome from '@/Components/Welcome.vue';
import AdminDashboard from '@/Pages/AdminDashboard.vue';
import AdminDashboardv1 from '@/Pages/AdminDashboardv1.vue';

import AdminDashboardv3 from '@/Pages/AdminDashboardv3.vue';

import { Chart } from 'chart.js';
import { ref, onMounted } from 'vue';
</script>
