<template>
    <div class="dashboard-container">
        <!-- HERO HEADER -->
        <section class="dashboard-hero">
            <div class="hero-glow hero-glow-one"></div>
            <div class="hero-glow hero-glow-two"></div>

            <div class="hero-content">
                <div class="hero-left">
                    <div class="date-pill">
                        <v-icon size="16">mdi-calendar-blank</v-icon>
                        <span>{{ currentDate }}</span>
                    </div>

                    <h1 class="dashboard-title">Clinic Dashboard</h1>

                    <p class="dashboard-subtitle">
                        Patient care, follow-ups, birthdays, and optical services
                    </p>
                </div>

                <v-btn
                    class="refresh-btn"
                    variant="flat"
                    prepend-icon="mdi-refresh"
                    :loading="loading"
                    @click="loadDashboard"
                >
                    Refresh
                </v-btn>
            </div>
        </section>

        <!-- SUMMARY -->
        <v-row class="summary-grid" dense justify="start">
            <v-col
                v-for="item in summaryCards"
                :key="item.label"
                cols="12"
                sm="6"
                md="4"
                lg="2"
                class="d-flex summary-col"
            >
                <v-card class="summary-card flex-grow-1" elevation="0">
                    <v-card-text class="summary-content">
                        <div class="summary-top">
                            <div
                                class="summary-icon"
                                :style="{
                                    backgroundColor: item.background,
                                    color: item.color
                                }"
                            >
                                <v-icon size="23">{{ item.icon }}</v-icon>
                            </div>
                        </div>

                        <div class="summary-label">{{ item.label }}</div>

                        <div
                            class="summary-value"
                            :style="{ color: item.color }"
                        >
                            {{ item.value }}
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- VISITS + FOLLOW UPS -->
        <v-row class="section-row" dense>
            <v-col cols="12" lg="8">
                <v-card class="dashboard-card chart-card" elevation="0">
                    <v-card-title class="card-header">
                        <div class="card-heading">
                            <div class="heading-icon blue-icon">
                                <v-icon size="19">mdi-chart-line</v-icon>
                            </div>

                            <div>
                                <div class="card-title">Patient Visits</div>
                                <div class="card-subtitle">Last 7 days</div>
                            </div>
                        </div>

                        <v-chip
                            class="soft-chip"
                            color="primary"
                            variant="tonal"
                            size="small"
                        >
                            <v-icon start size="15">mdi-chart-timeline-variant</v-icon>
                            Visits
                        </v-chip>
                    </v-card-title>

                    <v-divider class="soft-divider" />

                    <v-card-text class="chart-wrapper">
                        <div v-if="loadingChart" class="loading-container">
                            <div class="loading-inner">
                                <v-progress-circular
                                    indeterminate
                                    color="primary"
                                    size="32"
                                    width="3"
                                />
                                <span>Loading visits...</span>
                            </div>
                        </div>

                        <div v-else class="chart-container">
                            <canvas ref="lineChart"></canvas>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>

            <v-col cols="12" lg="4">
                <v-card class="dashboard-card h-100" elevation="0">
                    <v-card-title class="card-header">
                        <div class="card-heading">
                            <div class="heading-icon orange-icon">
                                <v-icon size="19">mdi-calendar-clock</v-icon>
                            </div>

                            <div>
                                <div class="card-title">Upcoming Follow-ups</div>
                                <div class="card-subtitle">Next 30 days</div>
                            </div>
                        </div>

                        <v-icon color="warning">mdi-arrow-top-right</v-icon>
                    </v-card-title>

                    <v-divider class="soft-divider" />

                    <v-card-text class="pa-0">
                        <div
                            v-if="loadingFollowUps"
                            class="loading-container small"
                        >
                            <div class="loading-inner">
                                <v-progress-circular
                                    indeterminate
                                    color="primary"
                                    size="28"
                                />
                                <span>Loading...</span>
                            </div>
                        </div>

                        <v-list
                            v-else-if="followUps.length"
                            density="compact"
                            class="dashboard-list py-2"
                        >
                            <template
                                v-for="(item, index) in followUps"
                                :key="item.id"
                            >
                                <v-list-item class="dashboard-list-item">
                                    <template #prepend>
                                        <v-avatar
                                            class="list-avatar orange-avatar"
                                            size="40"
                                        >
                                            <v-icon size="19">
                                                mdi-calendar-check
                                            </v-icon>
                                        </v-avatar>
                                    </template>

                                    <v-list-item-title class="patient-name">
                                        {{ item.patient_name }}
                                    </v-list-item-title>

                                    <v-list-item-subtitle>
                                        {{ formatDate(item.follow_up_date) }}
                                    </v-list-item-subtitle>

                                    <v-list-item-subtitle
                                        v-if="item.doctor_name"
                                        class="doctor-text"
                                    >
                                        {{ item.doctor_name }}
                                    </v-list-item-subtitle>
                                </v-list-item>

                                <v-divider
                                    v-if="index < followUps.length - 1"
                                    class="list-divider"
                                />
                            </template>
                        </v-list>

                        <div v-else class="empty-state">
                            <div class="empty-icon success-empty">
                                <v-icon size="27">mdi-check-circle-outline</v-icon>
                            </div>
                            <span>No upcoming follow-ups</span>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- BIRTHDAYS + RECENT VISITS -->
        <v-row class="section-row" dense>
            <v-col cols="12" md="5">
                <v-card class="dashboard-card" elevation="0">
                    <v-card-title class="card-header">
                        <div class="card-heading">
                            <div class="heading-icon pink-icon">
                                <v-icon size="19">mdi-cake-variant</v-icon>
                            </div>

                            <div>
                                <div class="card-title">Upcoming Birthdays</div>
                                <div class="card-subtitle">Patient birthdays</div>
                            </div>
                        </div>

                        <v-icon color="pink">mdi-cake-variant-outline</v-icon>
                    </v-card-title>

                    <v-divider class="soft-divider" />

                    <v-card-text class="pa-0">
                        <div
                            v-if="loadingBirthdays"
                            class="loading-container small"
                        >
                            <div class="loading-inner">
                                <v-progress-circular
                                    indeterminate
                                    color="primary"
                                    size="28"
                                />
                                <span>Loading...</span>
                            </div>
                        </div>

                        <v-list
                            v-else-if="birthdays.length"
                            density="compact"
                            class="dashboard-list py-2"
                        >
                            <template
                                v-for="(patient, index) in birthdays"
                                :key="patient.id"
                            >
                                <v-list-item class="dashboard-list-item">
                                    <template #prepend>
                                        <v-avatar
                                            class="list-avatar pink-avatar"
                                            size="40"
                                        >
                                            <v-icon size="19">mdi-cake</v-icon>
                                        </v-avatar>
                                    </template>

                                    <v-list-item-title class="patient-name">
                                        {{ patient.patient_name }}
                                    </v-list-item-title>

                                    <v-list-item-subtitle>
                                        {{ formatBirthday(patient.birthday_date) }}
                                    </v-list-item-subtitle>

                                    <template #append>
                                        <v-chip
                                            v-if="patient.days_until === 0"
                                            color="pink"
                                            size="small"
                                            variant="tonal"
                                        >
                                            Today
                                        </v-chip>

                                        <span v-else class="days-text">
                                            {{ patient.days_until }}
                                            {{ patient.days_until === 1 ? "day" : "days" }}
                                        </span>
                                    </template>
                                </v-list-item>

                                <v-divider
                                    v-if="index < birthdays.length - 1"
                                    class="list-divider"
                                />
                            </template>
                        </v-list>

                        <div v-else class="empty-state">
                            <div class="empty-icon neutral-empty">
                                <v-icon size="27">mdi-cake-variant-outline</v-icon>
                            </div>
                            <span>No upcoming birthdays</span>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>

            <v-col cols="12" md="7">
                <v-card class="dashboard-card" elevation="0">
                    <v-card-title class="card-header">
                        <div class="card-heading">
                            <div class="heading-icon blue-icon">
                                <v-icon size="19">mdi-account-clock</v-icon>
                            </div>

                            <div>
                                <div class="card-title">Recent Patient Visits</div>
                                <div class="card-subtitle">Latest clinical activity</div>
                            </div>
                        </div>

                        <v-icon color="primary">mdi-history</v-icon>
                    </v-card-title>

                    <v-divider class="soft-divider" />

                    <v-card-text class="pa-0">
                        <div
                            v-if="loadingRecent"
                            class="loading-container small"
                        >
                            <div class="loading-inner">
                                <v-progress-circular
                                    indeterminate
                                    color="primary"
                                    size="28"
                                />
                                <span>Loading...</span>
                            </div>
                        </div>

                        <v-list
                            v-else-if="recentVisits.length"
                            density="compact"
                            class="dashboard-list py-2"
                        >
                            <template
                                v-for="(visit, index) in recentVisits"
                                :key="visit.id"
                            >
                                <v-list-item class="dashboard-list-item">
                                    <template #prepend>
                                        <v-avatar
                                            class="list-avatar blue-avatar"
                                            size="40"
                                        >
                                            <v-icon size="19">mdi-account</v-icon>
                                        </v-avatar>
                                    </template>

                                    <v-list-item-title class="patient-name">
                                        {{ visit.patient_name }}
                                    </v-list-item-title>

                                    <v-list-item-subtitle>
                                        {{ formatVisitDate(visit) }}
                                    </v-list-item-subtitle>

                                    <v-list-item-subtitle
                                        v-if="visit.chief_complaint"
                                        class="complaint-text"
                                    >
                                        {{ visit.chief_complaint }}
                                    </v-list-item-subtitle>

                                    <template #append>
                                        <v-chip
                                            size="x-small"
                                            color="primary"
                                            variant="tonal"
                                            class="visit-type-chip"
                                        >
                                            {{ visit.visit_type || "Consultation" }}
                                        </v-chip>
                                    </template>
                                </v-list-item>

                                <v-divider
                                    v-if="index < recentVisits.length - 1"
                                    class="list-divider"
                                />
                            </template>
                        </v-list>

                        <div v-else class="empty-state">
                            <div class="empty-icon neutral-empty">
                                <v-icon size="27">mdi-account-off-outline</v-icon>
                            </div>
                            <span>No recent visits</span>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- GLASSES -->
        <v-row class="section-row" dense>
            <v-col cols="12" md="5">
                <v-card class="dashboard-card" elevation="0">
                    <v-card-title class="card-header">
                        <div class="card-heading">
                            <div class="heading-icon blue-icon">
                                <v-icon size="19">mdi-glasses</v-icon>
                            </div>

                            <div>
                                <div class="card-title">Glasses Orders</div>
                                <div class="card-subtitle">Current order status</div>
                            </div>
                        </div>

                        <v-icon color="primary">mdi-package-variant</v-icon>
                    </v-card-title>

                    <v-divider class="soft-divider" />

                    <v-card-text>
                        <div class="order-status-list">
                            <div class="order-status">
                                <div class="status-label">
                                    <span class="status-dot blue-dot"></span>
                                    Ordered
                                </div>
                                <v-chip color="blue" size="small" variant="tonal">
                                    {{ dashboard.glasses_ordered }}
                                </v-chip>
                            </div>

                            <div class="order-status">
                                <div class="status-label">
                                    <span class="status-dot indigo-dot"></span>
                                    Sent to Lab
                                </div>
                                <v-chip color="indigo" size="small" variant="tonal">
                                    {{ dashboard.glasses_sent_to_lab }}
                                </v-chip>
                            </div>

                            <div class="order-status">
                                <div class="status-label">
                                    <span class="status-dot orange-dot"></span>
                                    On Route to Clinic
                                </div>
                                <v-chip color="orange" size="small" variant="tonal">
                                    {{ dashboard.glasses_on_route }}
                                </v-chip>
                            </div>

                            <div class="order-status">
                                <div class="status-label">
                                    <span class="status-dot teal-dot"></span>
                                    On Clinic
                                </div>
                                <v-chip color="teal" size="small" variant="tonal">
                                    {{ dashboard.glasses_on_clinic }}
                                </v-chip>
                            </div>

                            <div class="order-status">
                                <div class="status-label">
                                    <span class="status-dot green-dot"></span>
                                    Given to Patient
                                </div>
                                <v-chip color="green" size="small" variant="tonal">
                                    {{ dashboard.glasses_given }}
                                </v-chip>
                            </div>

                            <div class="order-status">
                                <div class="status-label">
                                    <span class="status-dot red-dot"></span>
                                    For Repair / Defective
                                </div>
                                <v-chip color="error" size="small" variant="tonal">
                                    {{ dashboard.glasses_for_repair }}
                                </v-chip>
                            </div>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>

            <v-col cols="12" md="7">
                <v-card class="dashboard-card" elevation="0">
                    <v-card-title class="card-header">
                        <div class="card-heading">
                            <div class="heading-icon orange-icon">
                                <v-icon size="19">mdi-alert-outline</v-icon>
                            </div>

                            <div>
                                <div class="card-title">Low Stock Glasses</div>
                                <div class="card-subtitle">
                                    Inventory requiring attention
                                </div>
                            </div>
                        </div>

                        <v-chip
                            color="warning"
                            variant="tonal"
                            size="small"
                        >
                            {{ dashboard.low_stock_glasses }} low stock
                        </v-chip>
                    </v-card-title>

                    <v-divider class="soft-divider" />

                    <v-card-text class="pa-0">
                        <div
                            v-if="loadingInventory"
                            class="loading-container small"
                        >
                            <div class="loading-inner">
                                <v-progress-circular
                                    indeterminate
                                    color="primary"
                                    size="28"
                                />
                                <span>Loading inventory...</span>
                            </div>
                        </div>

                        <v-table
                            v-else-if="lowStockGlasses.length"
                            density="comfortable"
                            class="inventory-table"
                        >
                            <thead>
                                <tr>
                                    <th>Code</th>
                                    <th>Frame</th>
                                    <th>Color</th>
                                    <th class="text-center">Available</th>
                                    <th class="text-end">Price</th>
                                </tr>
                            </thead>

                            <tbody>
                                <tr
                                    v-for="item in lowStockGlasses"
                                    :key="item.id"
                                >
                                    <td>
                                        <span class="inventory-code">
                                            {{ item.code }}
                                        </span>
                                    </td>

                                    <td>
                                        <div class="frame-name">
                                            {{ item.brand || "Generic" }}
                                            <span v-if="item.model">
                                                - {{ item.model }}
                                            </span>
                                        </div>

                                        <div class="frame-description">
                                            {{ item.description }}
                                        </div>
                                    </td>

                                    <td>
                                        {{ item.color || "-" }}
                                    </td>

                                    <td class="text-center">
                                        <v-chip
                                            size="small"
                                            :color="
                                                Number(item.available_quantity) === 0
                                                    ? 'error'
                                                    : 'warning'
                                            "
                                            variant="tonal"
                                        >
                                            {{ item.available_quantity }}
                                        </v-chip>
                                    </td>

                                    <td class="text-end price-text">
                                        {{ formatCurrency(item.selling_price) }}
                                    </td>
                                </tr>
                            </tbody>
                        </v-table>

                        <div v-else class="empty-state">
                            <div class="empty-icon success-empty">
                                <v-icon size="27">mdi-check-circle-outline</v-icon>
                            </div>
                            <span>No low-stock glasses</span>
                        </div>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </div>
</template>

<script setup>
import {
    ref,
    onMounted,
    onUnmounted,
    nextTick
} from "vue";

import axios from "axios";
import moment from "moment";

import {
    Chart,
    registerables
} from "chart.js";

Chart.register(...registerables);

/*
|--------------------------------------------------------------------------
| Loading
|--------------------------------------------------------------------------
*/

const loading = ref(false);
const loadingChart = ref(false);
const loadingFollowUps = ref(false);
const loadingBirthdays = ref(false);
const loadingRecent = ref(false);
const loadingInventory = ref(false);

/*
|--------------------------------------------------------------------------
| Data
|--------------------------------------------------------------------------
*/

const recentVisits = ref([]);
const followUps = ref([]);
const birthdays = ref([]);
const lowStockGlasses = ref([]);

const lineChart = ref(null);

let lineChartInstance = null;

/*
|--------------------------------------------------------------------------
| Dashboard
|--------------------------------------------------------------------------
*/

const dashboard = ref({

    patients_today: 0,
    patients_week: 0,
    patients_month: 0,

    active_patients: 0,

    follow_ups_today: 0,
    follow_ups_week: 0,
    overdue_follow_ups: 0,

    birthdays_this_month: 0,

    available_glasses: 0,
    low_stock_glasses: 0,
    out_of_stock_glasses: 0,

    glasses_orders: 0,
    glasses_ordered: 0,
    glasses_sent_to_lab: 0,
    glasses_on_route: 0,
    glasses_on_clinic: 0,
    glasses_given: 0,
    glasses_for_repair: 0,
});

/*
|--------------------------------------------------------------------------
| Summary Cards
|--------------------------------------------------------------------------
*/
const currentDate = ref("");

const updateCurrentDate = () => {
    currentDate.value = moment().format(
        "dddd, MMMM DD, YYYY"
    );
};
const summaryCards = ref([

    {
        label: "Patients Today",
        value: 0,
        color: "#1976D2",
        background: "#E3F2FD",
        icon: "mdi-account-heart",
    },

    {
        label: "Visits This Week",
        value: 0,
        color: "#00897B",
        background: "#E0F2F1",
        icon: "mdi-calendar-week",
    },

    {
        label: "Visits This Month",
        value: 0,
        color: "#FB8C00",
        background: "#FFF3E0",
        icon: "mdi-calendar-month",
    },

    {
        label: "Follow-ups",
        value: 0,
        color: "#7E57C2",
        background: "#EDE7F6",
        icon: "mdi-calendar-clock",
    },

    {
        label: "Available Glasses",
        value: 0,
        color: "#00897B",
        background: "#E0F2F1",
        icon: "mdi-glasses",
    },

]);

/*
|--------------------------------------------------------------------------
| Currency
|--------------------------------------------------------------------------
*/

const formatCurrency = (value) => {

    return new Intl.NumberFormat(
        "en-PH",
        {
            style: "currency",
            currency: "PHP",
        }
    ).format(Number(value || 0));
};

/*
|--------------------------------------------------------------------------
| Date
|--------------------------------------------------------------------------
*/

const formatDate = (date) => {

    if (!date) {
        return "-";
    }

    return moment(date).format(
        "MMM DD, YYYY"
    );
};

/*
|--------------------------------------------------------------------------
| Birthday
|--------------------------------------------------------------------------
*/

const formatBirthday = (date) => {

    if (!date) {
        return "-";
    }

    return moment(date).format(
        "MMMM DD"
    );
};

/*
|--------------------------------------------------------------------------
| Visit Date
|--------------------------------------------------------------------------
*/

const formatVisitDate = (visit) => {

    if (!visit.visit_date) {
        return "-";
    }

    let result = moment(
        visit.visit_date
    ).format("MMM DD, YYYY");

    if (visit.visit_time) {

        result +=
            " - " +
            moment(
                visit.visit_time,
                "HH:mm:ss"
            ).format("h:mm A");
    }

    return result;
};

/*
|--------------------------------------------------------------------------
| Dashboard Stats
|--------------------------------------------------------------------------
*/

const fetchStats = async () => {

    try {

        const response = await axios.get(
            "/api/dashboard/stats"
        );

        dashboard.value = {
            ...dashboard.value,
            ...response.data,
        };

        summaryCards.value[0].value =
            response.data.patients_today;

        summaryCards.value[1].value =
            response.data.patients_week;

        summaryCards.value[2].value =
            response.data.patients_month;

        summaryCards.value[3].value =
            response.data.follow_ups_today;

        summaryCards.value[4].value =
            response.data.birthdays_this_month;

        summaryCards.value[5].value =
            response.data.available_glasses;

    } catch (error) {

        console.error(
            "Dashboard statistics error:",
            error
        );
    }
};

/*
|--------------------------------------------------------------------------
| Visits Chart
|--------------------------------------------------------------------------
*/

const fetchVisitsChart = async () => {
    loadingChart.value = true;

    try {
        const response = await axios.get(
            "/api/dashboard/visits-last-7-days"
        );

        // Store the chart data first
        const chartData = response.data ?? [];

        // Allow Vue to remove the loading state
        loadingChart.value = false;

        // Wait until the canvas is rendered
        await nextTick();

        createLineChart(chartData);

    } catch (error) {
        console.error(
            "Visits chart error:",
            error
        );

        loadingChart.value = false;
    }
};

/*
|--------------------------------------------------------------------------
| Recent Visits
|--------------------------------------------------------------------------
*/

const fetchRecentVisits = async () => {

    loadingRecent.value = true;

    try {

        const response = await axios.get(
            "/api/dashboard/recent-visits"
        );

        recentVisits.value =
            response.data;

    } catch (error) {

        console.error(
            "Recent visits error:",
            error
        );

    } finally {

        loadingRecent.value = false;
    }
};

/*
|--------------------------------------------------------------------------
| Follow-ups
|--------------------------------------------------------------------------
*/

const fetchFollowUps = async () => {

    loadingFollowUps.value = true;

    try {

        const response = await axios.get(
            "/api/dashboard/upcoming-follow-ups"
        );

        followUps.value =
            response.data;

    } catch (error) {

        console.error(
            "Follow-up error:",
            error
        );

    } finally {

        loadingFollowUps.value = false;
    }
};

/*
|--------------------------------------------------------------------------
| Birthdays
|--------------------------------------------------------------------------
*/

const fetchBirthdays = async () => {

    loadingBirthdays.value = true;

    try {

        const response = await axios.get(
            "/api/dashboard/upcoming-birthdays"
        );

        birthdays.value =
            response.data;

    } catch (error) {

        console.error(
            "Birthday error:",
            error
        );

    } finally {

        loadingBirthdays.value = false;
    }
};

/*
|--------------------------------------------------------------------------
| Inventory
|--------------------------------------------------------------------------
*/

const fetchLowStock = async () => {

    loadingInventory.value = true;

    try {

        const response = await axios.get(
            "/api/dashboard/low-stock-glasses"
        );

        lowStockGlasses.value =
            response.data;

    } catch (error) {

        console.error(
            "Inventory error:",
            error
        );

    } finally {

        loadingInventory.value = false;
    }
};

/*
|--------------------------------------------------------------------------
| Chart
|--------------------------------------------------------------------------
*/

const createLineChart = (data = []) => {
    if (!lineChart.value) {
        return;
    }

    // Destroy previous chart
    if (lineChartInstance) {
        lineChartInstance.destroy();
        lineChartInstance = null;
    }

    const labels = data.map((item) => item.label);

    const values = data.map((item) =>
        Number(item.count || 0)
    );

    lineChartInstance = new Chart(
        lineChart.value,
        {
            type: "line",

            data: {
                labels,

                datasets: [
                    {
                        label: "Patient Visits",
                        data: values,

                        borderColor: "#1976D2",
                        backgroundColor: "rgba(25, 118, 210, 0.10)",

                        borderWidth: 3,

                        fill: true,

                        tension: 0.35,

                        pointRadius: 4,
                        pointHoverRadius: 7,

                        pointBackgroundColor: "#1976D2",
                        pointBorderColor: "#ffffff",
                        pointBorderWidth: 2,
                    },
                ],
            },

            options: {
                responsive: true,

                maintainAspectRatio: false,

                interaction: {
                    mode: "index",
                    intersect: false,
                },

                plugins: {
                    legend: {
                        display: false,
                    },

                    tooltip: {
                        enabled: true,

                        callbacks: {
                            label: (context) => {
                                return ` Visits: ${context.parsed.y}`;
                            },
                        },
                    },
                },

                scales: {
                    x: {
                        grid: {
                            display: false,
                        },

                        border: {
                            display: false,
                        },

                        ticks: {
                            color: "#64748B",

                            maxRotation: 0,

                            autoSkip: false,
                        },
                    },

                    y: {
                        beginAtZero: true,

                        border: {
                            display: false,
                        },

                        ticks: {
                            precision: 0,
                            color: "#64748B",
                        },

                        grid: {
                            color: "rgba(0, 0, 0, 0.06)",
                        },
                    },
                },

                animation: {
                    duration: 700,
                },
            },
        }
    );
};
/*
|--------------------------------------------------------------------------
| Load Everything
|--------------------------------------------------------------------------
*/

const loadDashboard = async () => {

    loading.value = true;

    try {

        await Promise.all([
            fetchStats(),
            fetchVisitsChart(),
            fetchRecentVisits(),
            fetchFollowUps(),
            fetchBirthdays(),
            fetchLowStock(),
        ]);

    } finally {

        loading.value = false;
    }
};

/*
|--------------------------------------------------------------------------
| Lifecycle
|--------------------------------------------------------------------------
*/

onMounted(() => {
        updateCurrentDate();
    loadDashboard();
});

onUnmounted(() => {

    if (lineChartInstance) {

        lineChartInstance.destroy();

        lineChartInstance = null;
    }

});
</script>
<style scoped>
.dashboard-container {
    min-height: 100vh;
    padding: 26px;
    background:
        radial-gradient(circle at 8% 5%, rgba(25, 118, 210, 0.10), transparent 27%),
        radial-gradient(circle at 95% 20%, rgba(66, 133, 244, 0.07), transparent 24%),
        #f5f8fc;
    color: #162a4e;
}

/* HERO */

.dashboard-hero {
    position: relative;
    overflow: hidden;
    min-height: 178px;
    margin-bottom: 22px;
    padding: 28px 30px;
    border: 1px solid rgba(255, 255, 255, 0.72);
    border-radius: 26px;
    background:
        linear-gradient(135deg, rgba(25, 118, 210, 0.98), rgba(21, 101, 192, 0.94));
    box-shadow:
        0 18px 45px rgba(25, 118, 210, 0.18),
        inset 0 1px 0 rgba(255, 255, 255, 0.20);
}

.hero-content {
    position: relative;
    z-index: 2;
    min-height: 120px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 24px;
}

.hero-left {
    min-width: 0;
}

.hero-glow {
    position: absolute;
    border-radius: 50%;
    pointer-events: none;
    filter: blur(2px);
}

.hero-glow-one {
    width: 260px;
    height: 260px;
    top: -160px;
    right: 7%;
    background: rgba(255, 255, 255, 0.11);
}

.hero-glow-two {
    width: 180px;
    height: 180px;
    bottom: -120px;
    left: 38%;
    background: rgba(255, 255, 255, 0.08);
}

.date-pill {
    width: fit-content;
    display: flex;
    align-items: center;
    gap: 7px;
    margin-bottom: 12px;
    padding: 7px 12px;
    border: 1px solid rgba(255, 255, 255, 0.20);
    border-radius: 999px;
    background: rgba(255, 255, 255, 0.13);
    color: rgba(255, 255, 255, 0.94);
    font-size: 0.76rem;
    font-weight: 600;
    backdrop-filter: blur(14px);
    -webkit-backdrop-filter: blur(14px);
}

.dashboard-title {
    margin: 0;
    color: #ffffff;
    font-size: clamp(1.75rem, 4vw, 2.35rem);
    line-height: 1.12;
    font-weight: 750;
    letter-spacing: -0.035em;
}

.dashboard-subtitle {
    margin: 8px 0 0;
    color: rgba(255, 255, 255, 0.76);
    font-size: 0.92rem;
}

.refresh-btn {
    min-width: 112px;
    height: 42px !important;
    border-radius: 13px !important;
    background: rgba(255, 255, 255, 0.96) !important;
    color: #1565c0 !important;
    font-weight: 650;
    box-shadow: 0 8px 22px rgba(0, 0, 0, 0.10);
}

/* SUMMARY */

.summary-grid {
    margin-left: -6px;
    margin-right: -6px;
}

/* Five KPI cards now fill the desktop row evenly after removing Birthdays. */
.summary-col {
    flex: 0 0 20% !important;
    max-width: 20% !important;
    padding: 6px !important;

    margin-bottom: 2px;
}

.summary-card {
    min-height: 146px;
    overflow: hidden;
    border: 1px solid rgba(255, 255, 255, 0.90) !important;
    border-radius: 21px !important;
    background: rgba(255, 255, 255, 0.72) !important;
    box-shadow:
        0 9px 28px rgba(38, 72, 117, 0.07),
        inset 0 1px 0 rgba(255, 255, 255, 0.90) !important;
    backdrop-filter: blur(18px);
    -webkit-backdrop-filter: blur(18px);
    transition: transform 0.22s ease, box-shadow 0.22s ease;
}

.summary-card:hover {
    transform: translateY(-4px);
    box-shadow:
        0 16px 34px rgba(38, 72, 117, 0.11),
        inset 0 1px 0 rgba(255, 255, 255, 0.90) !important;
}

.summary-content {
    padding: 18px 19px !important;
}

.summary-top {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 17px;
}

.summary-icon {
    width: 43px;
    height: 43px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 14px;
}

.summary-arrow {
    color: #b7c3d4;
}

.summary-label {
    color: #64748b;
    font-size: 0.76rem;
    font-weight: 600;
}

.summary-value {
    margin-top: 3px;
    font-size: 1.72rem;
    line-height: 1.1;
    font-weight: 760;
    letter-spacing: -0.025em;
}

/* CARDS */

.section-row {
    margin-top: 20px;
}

.dashboard-card {
    overflow: hidden;
    border: 1px solid rgba(255, 255, 255, 0.88) !important;
    border-radius: 22px !important;
    background: rgba(255, 255, 255, 0.78) !important;
    box-shadow:
        0 9px 30px rgba(38, 72, 117, 0.065),
        inset 0 1px 0 rgba(255, 255, 255, 0.9) !important;
    backdrop-filter: blur(18px);
    -webkit-backdrop-filter: blur(18px);
}

.card-header {
    min-height: 78px;
    padding: 16px 20px !important;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 14px;
}

.card-heading {
    min-width: 0;
    display: flex;
    align-items: center;
    gap: 12px;
}

.heading-icon {
    width: 39px;
    height: 39px;
    flex: 0 0 39px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
}

.blue-icon {
    color: #1976d2;
    background: #e8f2ff;
}

.orange-icon {
    color: #f57c00;
    background: #fff1df;
}

.pink-icon {
    color: #e91e63;
    background: #fde7ef;
}

.card-title {
    color: #162a4e;
    font-size: 0.96rem;
    font-weight: 700;
    line-height: 1.3;
}

.card-subtitle {
    margin-top: 2px;
    color: #94a3b8;
    font-size: 0.73rem;
}

.soft-divider,
.list-divider {
    border-color: rgba(148, 163, 184, 0.14) !important;
}

.soft-chip {
    font-size: 0.7rem;
    font-weight: 650;
}

/* CHART */

.chart-wrapper {
    position: relative;
    height: 322px;
    padding: 19px !important;
}

.chart-container {
    position: relative;
    width: 100%;
    height: 282px;
}

.chart-container canvas {
    display: block;
    width: 100% !important;
    height: 100% !important;
}

.loading-container {
    height: 282px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.loading-container.small {
    height: 180px;
}

.loading-inner {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 9px;
    color: #94a3b8;
    font-size: 0.74rem;
}

/* LISTS */

.dashboard-list {
    background: transparent !important;
}

.dashboard-list-item {
    min-height: 68px;
    padding: 8px 18px !important;
}

.list-avatar {
    margin-right: 3px;
}

.blue-avatar {
    color: #1976d2;
    background: #e8f2ff;
}

.orange-avatar {
    color: #f57c00;
    background: #fff0dc;
}

.pink-avatar {
    color: #e91e63;
    background: #fde7ef;
}

.patient-name {
    color: #162a4e !important;
    font-size: 0.84rem !important;
    font-weight: 650 !important;
}

.doctor-text {
    color: #94a3b8 !important;
    font-size: 0.7rem !important;
}

.complaint-text {
    color: #1976d2 !important;
    font-size: 0.7rem !important;
}

.days-text {
    color: #64748b;
    font-size: 0.7rem;
    font-weight: 600;
}

.visit-type-chip {
    font-weight: 600;
}

/* EMPTY */

.empty-state {
    min-height: 174px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    gap: 9px;
    color: #94a3b8;
    font-size: 0.78rem;
}

.empty-icon {
    width: 50px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 15px;
}

.success-empty {
    color: #16a085;
    background: #e8f8f3;
}

.neutral-empty {
    color: #94a3b8;
    background: #f1f5f9;
}

/* GLASSES ORDERS */

.order-status-list {
    display: flex;
    flex-direction: column;
    gap: 4px;
}

.order-status {
    min-height: 46px;
    padding: 8px 4px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid rgba(148, 163, 184, 0.11);
}

.order-status:last-child {
    border-bottom: 0;
}

.status-label {
    display: flex;
    align-items: center;
    gap: 10px;
    color: #475569;
    font-size: 0.82rem;
    font-weight: 550;
}

.status-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
}

.blue-dot {
    background: #2196f3;
}

.indigo-dot {
    background: #3f51b5;
}

.orange-dot {
    background: #fb8c00;
}

.teal-dot {
    background: #009688;
}

.green-dot {
    background: #43a047;
}

.red-dot {
    background: #e53935;
}

/* INVENTORY */

.inventory-table {
    background: transparent !important;
}

.inventory-table :deep(thead th) {
    height: 45px !important;
    color: #94a3b8 !important;
    background: rgba(248, 250, 252, 0.72) !important;
    font-size: 0.7rem !important;
    font-weight: 700 !important;
    letter-spacing: 0.025em;
    text-transform: uppercase;
    border-bottom: 1px solid rgba(148, 163, 184, 0.13) !important;
}

.inventory-table :deep(tbody td) {
    height: 62px !important;
    color: #64748b;
    font-size: 0.78rem;
    border-bottom: 1px solid rgba(148, 163, 184, 0.10) !important;
}

.inventory-table :deep(tbody tr:last-child td) {
    border-bottom: 0 !important;
}

.inventory-table :deep(tbody tr:hover) {
    background: rgba(25, 118, 210, 0.035);
}

.inventory-code {
    color: #1976d2;
    font-weight: 700;
}

.frame-name {
    color: #162a4e;
    font-size: 0.78rem;
    font-weight: 650;
}

.frame-description {
    max-width: 260px;
    margin-top: 2px;
    overflow: hidden;
    color: #94a3b8;
    font-size: 0.68rem;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.price-text {
    color: #162a4e;
    font-weight: 650;
}

/* RESPONSIVE */

@media (max-width: 1260px) {
    .summary-col {
        flex: 0 0 33.333333% !important;
        max-width: 33.333333% !important;
    }
}

@media (max-width: 960px) {
    .dashboard-container {
        padding: 20px;
    }

    .dashboard-hero {
        padding: 24px;
        border-radius: 22px;
    }

    .hero-content {
        align-items: flex-start;
        flex-direction: column;
    }

    .refresh-btn {
        align-self: flex-start;
    }
}

@media (max-width: 600px) {
    .summary-col {
        flex: 0 0 50% !important;
        max-width: 50% !important;
    }

    .dashboard-container {
        padding: 12px;
    }

    .dashboard-hero {
        min-height: auto;
        margin-bottom: 14px;
        padding: 20px;
        border-radius: 20px;
    }

    .dashboard-title {
        font-size: 1.7rem;
    }

    .dashboard-subtitle {
        font-size: 0.8rem;
        line-height: 1.5;
    }

    .summary-card {
        min-height: 132px;
        border-radius: 18px !important;
    }

    .summary-content {
        padding: 16px !important;
    }

    .summary-value {
        font-size: 1.5rem;
    }

    .section-row {
        margin-top: 14px;
    }

    .dashboard-card {
        border-radius: 18px !important;
    }

    .card-header {
        min-height: 70px;
        padding: 14px 15px !important;
    }

    .card-title {
        font-size: 0.9rem;
    }

    .chart-wrapper {
        height: 260px;
        padding: 12px !important;
    }

    .chart-container {
        height: 230px;
    }

    .loading-container {
        height: 230px;
    }

    .dashboard-list-item {
        padding: 8px 12px !important;
    }

    .inventory-table {
        min-width: 650px;
    }

    .inventory-table :deep(.v-table__wrapper) {
        overflow-x: auto;
    }
}
</style>
