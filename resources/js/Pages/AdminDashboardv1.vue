<template>
    <div class="dashboard-container">

        <!-- HEADER -->
        <v-row class="mb-5" align="center">
            <v-col cols="12" md="8">
                <v-chip
                    class="dashboard-date"
                    color="primary"
                    variant="tonal"
                    size="small"
                >
                    {{ currentDate }}
                </v-chip>
                <h1 class="dashboard-title">
                    Clinic Dashboard
                </h1>

                <p class="dashboard-subtitle">
                    Patient care, follow-ups, birthdays, and optical services
                </p>

            </v-col>
            

            <v-col cols="12" md="4" class="d-flex justify-md-end">

                <v-btn color="primary" variant="outlined" prepend-icon="mdi-refresh" :loading="loading"
                    @click="loadDashboard">
                    Refresh
                </v-btn>

            </v-col>
        </v-row>

        <!-- SUMMARY -->
        <v-row dense>

            <v-col v-for="item in summaryCards" :key="item.label" cols="12" sm="6" md="4" lg="2" class="d-flex">

                <v-card class="summary-card flex-grow-1" elevation="2">

                    <v-card-text class="pa-5">

                        <div class="d-flex justify-space-between align-start">

                            <div>

                                <div class="summary-label">
                                    {{ item.label }}
                                </div>

                                <div class="summary-value">
                                    {{ item.value }}
                                </div>

                            </div>

                            <div class="summary-icon" :style="{
                                backgroundColor: item.background
                            }">

                                <v-icon :color="item.color" size="26">
                                    {{ item.icon }}
                                </v-icon>

                            </div>

                        </div>

                    </v-card-text>

                </v-card>

            </v-col>

        </v-row>

        <!-- VISITS + FOLLOW UPS -->
        <v-row class="mt-4" dense>

            <!-- CHART -->
            <v-col cols="12" lg="8">

                <v-card class="dashboard-card" elevation="2">

                    <v-card-title class="card-header">

                        <div>

                            <div class="card-title">
                                Patient Visits
                            </div>

                            <div class="card-subtitle">
                                Last 7 days
                            </div>

                        </div>

                        <v-icon color="primary">
                            mdi-chart-line
                        </v-icon>

                    </v-card-title>

                    <v-divider />

<v-card-text class="chart-wrapper">
    <div
        v-if="loadingChart"
        class="loading-container"
    >
        <v-progress-circular
            indeterminate
            color="primary"
        />
    </div>

    <div
        v-else
        class="chart-container"
    >
        <canvas ref="lineChart"></canvas>
    </div>
</v-card-text>

                </v-card>

            </v-col>

            <!-- FOLLOW UPS -->
            <v-col cols="12" lg="4">

                <v-card class="dashboard-card h-100" elevation="2">

                    <v-card-title class="card-header">

                        <div>

                            <div class="card-title">
                                Upcoming Follow-ups
                            </div>

                            <div class="card-subtitle">
                                Next 30 days
                            </div>

                        </div>

                        <v-icon color="warning">
                            mdi-calendar-clock
                        </v-icon>

                    </v-card-title>

                    <v-divider />

                    <v-card-text class="pa-0">

                        <div v-if="loadingFollowUps" class="loading-container small">

                            <v-progress-circular indeterminate color="primary" />

                        </div>

                        <v-list v-else-if="followUps.length" density="compact" class="py-0">

                            <template v-for="(item, index) in followUps" :key="item.id">

                                <v-list-item>

                                    <template #prepend>

                                        <v-avatar color="warning" size="38">

                                            <v-icon color="white" size="20">
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

                                    <v-list-item-subtitle v-if="item.doctor_name" class="doctor-text">
                                        {{ item.doctor_name }}
                                    </v-list-item-subtitle>

                                </v-list-item>

                                <v-divider v-if="
                                    index <
                                    followUps.length - 1
                                " />

                            </template>

                        </v-list>

                        <div v-else class="empty-state">

                            <v-icon color="success" size="40">
                                mdi-check-circle-outline
                            </v-icon>

                            <span>
                                No upcoming follow-ups
                            </span>

                        </div>

                    </v-card-text>

                </v-card>

            </v-col>

        </v-row>

        <!-- BIRTHDAYS + RECENT VISITS -->
        <v-row class="mt-4" dense>

            <!-- BIRTHDAYS -->
            <v-col cols="12" md="5">

                <v-card class="dashboard-card" elevation="2">

                    <v-card-title class="card-header">

                        <div>

                            <div class="card-title">
                                Upcoming Birthdays
                            </div>

                            <div class="card-subtitle">
                                Patient birthdays
                            </div>

                        </div>

                        <v-icon color="pink">
                            mdi-cake-variant
                        </v-icon>

                    </v-card-title>

                    <v-divider />

                    <v-card-text class="pa-0">

                        <div v-if="loadingBirthdays" class="loading-container small">

                            <v-progress-circular indeterminate color="primary" />

                        </div>

                        <v-list v-else-if="birthdays.length" density="compact" class="py-0">

                            <template v-for="(patient, index) in birthdays" :key="patient.id">

                                <v-list-item>

                                    <template #prepend>

                                        <v-avatar color="pink-lighten-4" size="40">

                                            <v-icon color="pink">
                                                mdi-cake
                                            </v-icon>

                                        </v-avatar>

                                    </template>

                                    <v-list-item-title class="patient-name">
                                        {{ patient.patient_name }}
                                    </v-list-item-title>

                                    <v-list-item-subtitle>

                                        {{
                                            formatBirthday(
                                                patient.birthday_date
                                            )
                                        }}

                                    </v-list-item-subtitle>

                                    <template #append>

                                        <v-chip v-if="
                                            patient.days_until === 0
                                        " color="pink" size="small" variant="tonal">
                                            Today
                                        </v-chip>

                                        <span v-else class="days-text">
                                            {{
                                                patient.days_until
                                            }}
                                            {{
                                                patient.days_until === 1
                                                    ? "day"
                                                    : "days"
                                            }}
                                        </span>

                                    </template>

                                </v-list-item>

                                <v-divider v-if="
                                    index <
                                    birthdays.length - 1
                                " />

                            </template>

                        </v-list>

                        <div v-else class="empty-state">

                            <v-icon size="40" color="grey">
                                mdi-cake-variant-outline
                            </v-icon>

                            <span>
                                No upcoming birthdays
                            </span>

                        </div>

                    </v-card-text>

                </v-card>

            </v-col>

            <!-- RECENT VISITS -->
            <v-col cols="12" md="7">

                <v-card class="dashboard-card" elevation="2">

                    <v-card-title class="card-header">

                        <div>

                            <div class="card-title">
                                Recent Patient Visits
                            </div>

                            <div class="card-subtitle">
                                Latest clinical activity
                            </div>

                        </div>

                        <v-icon color="primary">
                            mdi-account-clock
                        </v-icon>

                    </v-card-title>

                    <v-divider />

                    <v-card-text class="pa-0">

                        <div v-if="loadingRecent" class="loading-container small">

                            <v-progress-circular indeterminate color="primary" />

                        </div>

                        <v-list v-else-if="recentVisits.length" density="compact" class="py-0">

                            <template v-for="(visit, index) in recentVisits" :key="visit.id">

                                <v-list-item>

                                    <template #prepend>

                                        <v-avatar color="primary" size="38">

                                            <v-icon color="white">
                                                mdi-account
                                            </v-icon>

                                        </v-avatar>

                                    </template>

                                    <v-list-item-title class="patient-name">
                                        {{ visit.patient_name }}
                                    </v-list-item-title>

                                    <v-list-item-subtitle>
                                        {{ formatVisitDate(visit) }}
                                    </v-list-item-subtitle>

                                    <v-list-item-subtitle v-if="visit.chief_complaint" class="complaint-text">
                                        {{ visit.chief_complaint }}
                                    </v-list-item-subtitle>

                                    <template #append>

                                        <v-chip size="x-small" color="primary" variant="tonal">
                                            {{
                                                visit.visit_type ||
                                                "Consultation"
                                            }}
                                        </v-chip>

                                    </template>

                                </v-list-item>

                                <v-divider v-if="
                                    index <
                                    recentVisits.length - 1
                                " />

                            </template>

                        </v-list>

                        <div v-else class="empty-state">

                            <v-icon size="40" color="grey">
                                mdi-account-off-outline
                            </v-icon>

                            <span>
                                No recent visits
                            </span>

                        </div>

                    </v-card-text>

                </v-card>

            </v-col>

        </v-row>

        <!-- GLASSES -->
        <v-row class="mt-4" dense>

            <!-- ORDER STATUS -->
            <v-col cols="12" md="5">

                <v-card class="dashboard-card" elevation="2">

                    <v-card-title class="card-header">

                        <div>

                            <div class="card-title">
                                Glasses Orders
                            </div>

                            <div class="card-subtitle">
                                Current order status
                            </div>

                        </div>

                        <v-icon color="primary">
                            mdi-glasses
                        </v-icon>

                    </v-card-title>

                    <v-divider />

                    <v-card-text>

                        <div class="order-status-list">

                            <div class="order-status">

                                <span>
                                    Ordered
                                </span>

                                <v-chip color="blue" size="small" variant="tonal">
                                    {{ dashboard.glasses_ordered }}
                                </v-chip>

                            </div>

                            <div class="order-status">

                                <span>
                                    Sent to Lab
                                </span>

                                <v-chip color="indigo" size="small" variant="tonal">
                                    {{ dashboard.glasses_sent_to_lab }}
                                </v-chip>

                            </div>

                            <div class="order-status">

                                <span>
                                    On Route to Clinic
                                </span>

                                <v-chip color="orange" size="small" variant="tonal">
                                    {{ dashboard.glasses_on_route }}
                                </v-chip>

                            </div>

                            <div class="order-status">

                                <span>
                                    On Clinic
                                </span>

                                <v-chip color="teal" size="small" variant="tonal">
                                    {{ dashboard.glasses_on_clinic }}
                                </v-chip>

                            </div>

                            <div class="order-status">

                                <span>
                                    Given to Patient
                                </span>

                                <v-chip color="green" size="small" variant="tonal">
                                    {{ dashboard.glasses_given }}
                                </v-chip>

                            </div>

                            <div class="order-status">

                                <span>
                                    For Repair / Defective
                                </span>

                                <v-chip color="error" size="small" variant="tonal">
                                    {{ dashboard.glasses_for_repair }}
                                </v-chip>

                            </div>

                        </div>

                    </v-card-text>

                </v-card>

            </v-col>

            <!-- INVENTORY -->
            <v-col cols="12" md="7">

                <v-card class="dashboard-card" elevation="2">

                    <v-card-title class="card-header">

                        <div>

                            <div class="card-title">
                                Low Stock Glasses
                            </div>

                            <div class="card-subtitle">
                                Inventory requiring attention
                            </div>

                        </div>

                        <v-icon color="warning">
                            mdi-alert-outline
                        </v-icon>

                    </v-card-title>

                    <v-divider />

                    <v-card-text class="pa-0">

                        <div v-if="loadingInventory" class="loading-container small">

                            <v-progress-circular indeterminate color="primary" />

                        </div>

                        <v-table v-else-if="lowStockGlasses.length" density="comfortable">

                            <thead>

                                <tr>
                                    <th>Code</th>
                                    <th>Frame</th>
                                    <th>Color</th>
                                    <th class="text-center">
                                        Available
                                    </th>
                                    <th class="text-end">
                                        Price
                                    </th>
                                </tr>

                            </thead>

                            <tbody>

                                <tr v-for="item in lowStockGlasses" :key="item.id">

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

                                        <v-chip size="small" :color="Number(
                                            item.available_quantity
                                        ) === 0
                                                ? 'error'
                                                : 'warning'
                                            " variant="tonal">
                                            {{
                                                item.available_quantity
                                            }}
                                        </v-chip>

                                    </td>

                                    <td class="text-end price-text">
                                        {{
                                            formatCurrency(
                                                item.selling_price
                                            )
                                        }}
                                    </td>

                                </tr>

                            </tbody>

                        </v-table>

                        <div v-else class="empty-state">

                            <v-icon size="42" color="success">
                                mdi-check-circle-outline
                            </v-icon>

                            <span>
                                No low-stock glasses
                            </span>

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
        label: "Birthdays",
        value: 0,
        color: "#E91E63",
        background: "#FCE4EC",
        icon: "mdi-cake-variant",
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
    background: #f8fafc;
    min-height: 100vh;
    padding: 24px;
}

.dashboard-title {
    color: #162a4e;
    font-size: clamp(1.6rem, 4vw, 2.2rem);
    font-weight: 700;
}

.dashboard-subtitle {
    color: #64748b;
    margin-top: 5px;
    font-size: 0.95rem;
}

/* Summary */

.summary-card {
    background: white;
    border-radius: 14px;
    transition: 0.2s ease;
}

.summary-card:hover {
    transform: translateY(-3px);
}

.summary-label {
    color: #64748b;
    font-size: 0.8rem;
}

.summary-value {
    color: #162a4e;
    font-size: 1.75rem;
    font-weight: 700;
    margin-top: 4px;
}

.summary-icon {
    width: 46px;
    height: 46px;
    border-radius: 12px;

    display: flex;
    align-items: center;
    justify-content: center;
}

/* Cards */

.dashboard-card {
    background: white;
    border-radius: 14px;
    overflow: hidden;
}

.card-header {
    min-height: 72px;

    display: flex;
    justify-content: space-between;
    align-items: center;
}

.card-title {
    color: #162a4e;
    font-size: 1.05rem;
    font-weight: 600;
}

.card-subtitle {
    color: #94a3b8;
    font-size: 0.78rem;
}

/* Chart */

.chart-wrapper {
    height: 320px;
    position: relative;
    padding: 20px !important;
}

.chart-container {
    position: relative;
    width: 100%;
    height: 280px;
}

.chart-container canvas {
    display: block;
    width: 100% !important;
    height: 100% !important;
}

.loading-container {
    height: 280px;

    display: flex;
    align-items: center;
    justify-content: center;
}

.loading-container.small {
    height: 180px;
}

.loading-container {
    height: 100%;

    display: flex;
    align-items: center;
    justify-content: center;
}

.loading-container.small {
    height: 180px;
}

/* Patient */

.patient-name {
    color: #162a4e !important;
    font-weight: 600;
}

.doctor-text {
    color: #64748b !important;
    font-size: 0.75rem;
}

.complaint-text {
    color: #1976d2 !important;
    font-size: 0.75rem;
}

.days-text {
    color: #64748b;
    font-size: 0.75rem;
}

/* Glasses */

.order-status-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
}

.order-status {
    display: flex;
    justify-content: space-between;
    align-items: center;

    color: #475569;
    font-size: 0.9rem;
}

.inventory-code {
    color: #1976d2;
    font-weight: 600;
}

.frame-name {
    color: #162a4e;
    font-weight: 600;
    font-size: 0.85rem;
}

.frame-description {
    color: #94a3b8;
    font-size: 0.73rem;
}

.price-text {
    color: #162a4e;
    font-weight: 600;
}

/* Empty */

.empty-state {
    min-height: 160px;

    display: flex;
    flex-direction: column;

    align-items: center;
    justify-content: center;

    gap: 8px;

    color: #94a3b8;
    font-size: 0.85rem;
}

/* Mobile */

@media (max-width: 600px) {
    .dashboard-container {
        padding: 14px;
    }

    .chart-wrapper {
        height: 260px;
        padding: 12px !important;
    }

    .chart-container {
        height: 230px;
    }

    .summary-value {
        font-size: 1.5rem;
    }
}
</style>