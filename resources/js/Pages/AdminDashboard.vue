<template>
    <div style="color: gray">
        <v-row>
            <v-col cols="12" md="12" sm="12">
                <!-- <v-card min-height="20"> -->
                <!-- <v-card-text> -->
                <v-icon>mdi-home</v-icon>
                <span class="ml-3">Dashboard</span>
                <!-- </v-card-text>
                        
                    </v-card> -->
            </v-col>
        </v-row>

        <v-row>
            <v-col md="3">
                <v-card min-height="100px" class="elevation-2">
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <span>TOTAL PPE COUNT</span>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <span class="large-bold-text">{{
                                    ppecount
                                }}</span>
                                <span class="ml-2">ppes</span>
                            </v-col>

                            <v-col class="d-flex justify-end">
                                <v-icon size="40" color="grey">mdi-cart</v-icon>
                            </v-col>
                        </v-row>
                    </v-card-text>
                    <v-toolbar height="5" color="#0061F2"></v-toolbar>
                </v-card>
            </v-col>
            <v-col md="3">
                <v-card min-height="100px" class="elevation-2">
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <span>TODAY'S TRANSACTIONS</span>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <span class="large-bold-text">{{
                                    dailytransactioncount
                                }}</span>
                                <span class="ml-2">transactions</span>
                            </v-col>

                            <v-col class="d-flex justify-end">
                                <v-icon size="40" color="grey"
                                    >mdi-account-arrow-down</v-icon
                                >
                            </v-col>
                        </v-row>
                    </v-card-text>
                    <v-toolbar height="5" color="#F4A000"></v-toolbar>
                </v-card>
            </v-col>
            <v-col md="3">
                <v-card min-height="100px" class="elevation-2">
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <span>MY PPE UNITS</span>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <span class="large-bold-text">{{
                                    myppeunitscount
                                }}</span>
                                <span class="ml-2">ppes</span>
                            </v-col>

                            <v-col class="d-flex justify-end">
                                <v-icon size="40" color="grey"
                                    >mdi-counter</v-icon
                                >
                            </v-col>
                        </v-row>
                    </v-card-text>
                    <v-toolbar height="5" color="#00AC69"></v-toolbar>
                </v-card>
            </v-col>
            <v-col md="3">
                <v-card min-height="100px" class="elevation-2">
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <span>MY OVERALL PPE VALUATION</span>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col>
                                <span class="large-bold-text">
                                    {{
                                        formatToDecimal(myppeunitsvaluation)
                                    }}</span
                                >
                                <span class="ml-2">php</span>
                            </v-col>

                            <v-col class="d-flex justify-end">
                                <v-icon size="30" color="grey"
                                    >mdi-currency-php</v-icon
                                >
                            </v-col>
                        </v-row>
                    </v-card-text>
                    <v-toolbar height="5" color="#E81400"></v-toolbar>
                </v-card>
            </v-col>
        </v-row>

        <v-row class="mt-5">
            <v-col cols="12" md="12" sm="12">
                <v-card>
                    <v-toolbar height="50">
                        <v-icon class="ml-5">mdi-set-left</v-icon>
                        <span class="ml-3">Count per category</span>
                        <v-spacer></v-spacer>
                        <v-btn color="green">RESET FILTER</v-btn>
                    </v-toolbar>
                    <v-card-text>
                        <canvas id="myChart"></canvas>
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

// Register all necessary Chart.js components
Chart.register(...registerables);

// Reactive reference to the chart instance
const chartInstance = ref(null);

// Function to fetch chart data
const fetchChartData = async () => {
    try {
        const response = await axios.get("/api/ppedata");
        return response.data;
    } catch (error) {
        console.error("Error fetching chart data:", error);
        return [];
    }
};

// Function to generate a random dark RGB color ensuring uniqueness
const generatedColors = new Set();

const getRandomDarkColor = () => {
    let color;
    do {
        const r = Math.floor(Math.random() * 128); // Darker red range (0-127)
        const g = Math.floor(Math.random() * 128); // Darker green range (0-127)
        const b = Math.floor(Math.random() * 128); // Darker blue range (0-127)
        color = `rgba(${r}, ${g}, ${b}, 0.8)`; // Adjust the alpha (0.8) for slightly less transparency
    } while (generatedColors.has(color)); // Ensure uniqueness

    generatedColors.add(color); // Add the new color to the Set
    return color;
};

const dailytransactioncount = ref(0);
const myppeunitscount = ref(0);
const myppeunitsvaluation = ref(0);
const ppecount = ref(0);

const getdashboardvalues = async () => {
    await axios
        .get(`/api/getdailytransactions`)
        .then((response) => {
            dailytransactioncount.value = response.data;
        })
        .catch((error) => {
            console.error("There was an error.", error);
        });

    await axios
        .get(`/api/getmyppeunits`)
        .then((response) => {
            myppeunitscount.value = response.data;
        })
        .catch((error) => {
            console.error("There was an error.", error);
        });

    await axios
        .get(`/api/getmyppevaluation`)
        .then((response) => {
            myppeunitsvaluation.value = response.data;
        })
        .catch((error) => {
            console.error("There was an error.", error);
        });

    await axios
        .get(`/api/getmyppeunits`)
        .then((response) => {
            myppeunitscount.value = response.data;
        })
        .catch((error) => {
            console.error("There was an error.", error);
        });

    await axios
        .get(`/api/getppecount`)
        .then((response) => {
            ppecount.value = response.data;
        })
        .catch((error) => {
            console.error("There was an error.", error);
        });
};

const formatToDecimal = (value) => {
    if (value == null) {
        return "";
    }
    return value.toLocaleString("en-US", {
        minimumFractionDigits: 2,
        maximumFractionDigits: 2,
    });
};

onMounted(async () => {
    const chartData = await fetchChartData();

    // Ensure chartData is available and not empty before proceeding
    if (!chartData || chartData.length === 0) {
        console.warn("Chart data is empty or unavailable.");
        return;
    }

    // Create the chart when the component is mounted
    const ctx = document.getElementById("myChart").getContext("2d");

    // Extracting labels and data from chartData
    const labels = chartData.map((item) => item.article);
    const data = chartData.map((item) => item.count);

    const blueShade = "rgba(62, 162, 248, 0.8)"; // Color #3EA2F8 with transparency

    // Instantiate the chart
    chartInstance.value = new Chart(ctx, {
        type: "bar",
        data: {
            labels: labels, // Article names
            datasets: [
                {
                    label: "PPE count per category",
                    data: data, // Count of each article
                    backgroundColor: blueShade, // Unique dark background colors
                    borderColor: blueShade, // Optional: use same colors for borders
                    borderWidth: 1,
                    borderRadius: 10, // Rounded corners
                },
            ],
        },
        options: {
            plugins: {
                legend: {
                    position: "top",
                },
                //   title: {
                //     display: true,
                //     text: 'Chart.js Bar Chart'
                //   }
            },
            scales: {
                y: {
                    beginAtZero: true,
                },
            },
        },
    });

    getdashboardvalues();
});

// Cleanup the chart instance when the component is unmounted
onUnmounted(() => {
    if (chartInstance.value) {
        chartInstance.value.destroy();
    }
});
</script>

<style>
.large-bold-text {
    font-size: 32px;
    font-weight: bold;
    color: rgb(39, 37, 37);
}
</style>
