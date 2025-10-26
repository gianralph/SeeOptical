<template>
    <div class="dashboard-container">
        <!-- Header -->
        <v-row class="mb-6" justify="center">
            <v-col cols="12" md="8" class="text-center">
                <h1 class="dashboard-title">Clinic Dashboard</h1>
                <p class="dashboard-subtitle">
                    Overview of patient activity and clinic performance
                </p>
            </v-col>
        </v-row>

        <!-- Summary Cards -->
        <v-row dense>
            <v-col
                v-for="(item, i) in summaryCards"
                :key="i"
                cols="12"
                sm="6"
                md="4"
                class="d-flex"
            >
                <v-card elevation="3" class="summary-card flex-grow-1">
                    <v-card-text class="text-center pa-6">
                        <v-icon :color="item.color" size="44">{{ item.icon }}</v-icon>
                        <h2 class="summary-value">{{ item.value }}</h2>
                        <p class="summary-label">{{ item.label }}</p>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>

        <!-- Charts and Appointments -->
        <v-row class="mt-4" dense>
            <!-- Chart -->
            <v-col cols="12" md="8">
                <v-card elevation="3" class="chart-card pa-4">
                    <v-toolbar flat color="transparent" class="px-0">
                        <v-toolbar-title class="chart-title">
                            Patient Visits - Last 7 Days
                        </v-toolbar-title>
                    </v-toolbar>
                    <v-card-text class="chart-container">
                        <canvas ref="lineChart"></canvas>
                    </v-card-text>
                </v-card>
            </v-col>

            <!-- Recent Appointments -->
            <v-col cols="12" md="4">
                <v-card elevation="3" class="list-card pa-4">
                    <v-toolbar flat color="transparent" class="px-0">
                        <v-toolbar-title class="chart-title">
                            Recent Appointments
                        </v-toolbar-title>
                    </v-toolbar>
                    <v-card-text class="py-0">
                        <v-list density="compact">
                            <template
                                v-for="(item, index) in recentAppointments"
                                :key="index"
                            >
                                <v-list-item class="appointment-item">
                                    <v-list-item-title class="patient-name">
                                        {{ item.patient_name }}
                                    </v-list-item-title>
                                    <v-list-item-subtitle>
                                        {{ moment(item.date).format("MMM DD, YYYY - h:mm A") }}
                                    </v-list-item-subtitle>
                                    <v-list-item-subtitle class="service-text">
                                        {{ item.service }}
                                    </v-list-item-subtitle>
                                </v-list-item>
                                <v-divider
                                    v-if="index < recentAppointments.length - 1"
                                ></v-divider>
                            </template>
                        </v-list>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from "vue";
import { Chart, registerables } from "chart.js";
import axios from "axios";
import moment from "moment";

Chart.register(...registerables);

const patientsToday = ref(0);
const patientsWeek = ref(0);
const patientsMonth = ref(0);
const recentAppointments = ref([]);
const lineChart = ref(null);
let lineChartInstance = null;

// summary card info
const summaryCards = ref([
    {
        label: "Patients Today",
        value: 0,
        color: "#1976D2",
        icon: "mdi-account-heart",
    },
    {
        label: "Patients This Week",
        value: 0,
        color: "#00BFA5",
        icon: "mdi-calendar-week",
    },
    {
        label: "Patients This Month",
        value: 0,
        color: "#FB8C00",
        icon: "mdi-calendar-month",
    },
]);

// Fetch stats
const fetchDashboardStats = async () => {
    try {
        const [today, week, month] = await Promise.all([
            axios.get("/api/patients/today"),
            axios.get("/api/patients/week"),
            axios.get("/api/patients/month"),
        ]);

        patientsToday.value = today.data.count;
        patientsWeek.value = week.data.count;
        patientsMonth.value = month.data.count;

        summaryCards.value[0].value = patientsToday.value;
        summaryCards.value[1].value = patientsWeek.value;
        summaryCards.value[2].value = patientsMonth.value;
    } catch (err) {
        console.error("Error loading patient stats:", err);
    }
};

// Fetch line chart data
const fetchLineChartData = async () => {
    try {
        const res = await axios.get("/api/patients/last7days");
        return res.data;
    } catch (err) {
        console.error("Error loading chart data:", err);
        return [];
    }
};

// Fetch recent appointments
const fetchRecentAppointments = async () => {
    try {
        const res = await axios.get("/api/appointments/recent");
        recentAppointments.value = res.data;
    } catch (err) {
        console.error("Error loading appointments:", err);
    }
};

// Create line chart
const createLineChart = (data) => {
    const labels = data.map((d) => d.day);
    const values = data.map((d) => d.count);

    if (lineChartInstance) lineChartInstance.destroy();

    lineChartInstance = new Chart(lineChart.value, {
        type: "line",
        data: {
            labels,
            datasets: [
                {
                    label: "Patients per Day",
                    data: values,
                    borderColor: "#1976D2",
                    backgroundColor: "rgba(25, 118, 210, 0.15)",
                    borderWidth: 3,
                    fill: true,
                    tension: 0.4,
                    pointRadius: 4,
                    pointBackgroundColor: "#1976D2",
                },
            ],
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                x: {
                    ticks: { color: "#555" },
                    grid: { color: "rgba(0,0,0,0.05)" },
                },
                y: {
                    ticks: { color: "#555" },
                    grid: { color: "rgba(0,0,0,0.05)" },
                },
            },
        },
    });
};

onMounted(async () => {
    await fetchDashboardStats();
    const chartData = await fetchLineChartData();
    createLineChart(chartData);
    await fetchRecentAppointments();
});

onUnmounted(() => {
    if (lineChartInstance) lineChartInstance.destroy();
});
</script>

<style scoped>
.dashboard-container {
    background-color: #f8fafc;
    min-height: 100vh;
    padding: 20px;
}

/* Responsive typography */
.dashboard-title {
    font-weight: 700;
    font-size: clamp(1.6rem, 4vw, 2.2rem);
    color: #162a4e;
}

.dashboard-subtitle {
    color: #6c757d;
    font-size: clamp(0.9rem, 2.5vw, 1rem);
    margin-top: -4px;
}

/* Cards */
.summary-card {
    border-radius: 16px;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
    background: white;
}

.summary-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
}

.summary-value {
    font-size: clamp(1.4rem, 3vw, 2rem);
    font-weight: 700;
    color: #162a4e;
    margin-top: 10px;
}

.summary-label {
    color: #6c757d;
    font-size: clamp(0.8rem, 2.5vw, 0.95rem);
}

/* Chart & List Cards */
.chart-card,
.list-card {
    border-radius: 16px;
    background: white;
}

.chart-title {
    font-weight: 600;
    color: #162a4e;
}

.chart-container {
    height: 280px;
    @media (max-width: 600px) {
        height: 200px;
    }
}

/* Appointment list */
.patient-name {
    font-weight: 600;
    color: #162a4e;
}

.service-text {
    color: #00bfa5;
    font-weight: 500;
}

.appointment-item {
    padding: 8px 0;
}
</style>
