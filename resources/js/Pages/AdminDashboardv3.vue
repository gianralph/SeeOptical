<template>
    <div style="color: grey;">

        
                <v-row>
                    <v-col cols="12" md="12" sm="12">
                            <v-icon>mdi-home</v-icon>
                            <span class="ml-3" color="black" >Dashboard</span>

                    </v-col>
                </v-row>



                <v-row>

                    <v-col md="4">
                            <v-card>
                                <v-card-text>
                                    <v-col cols="12" md="12" sm="12">
                                        <v-card min-height="500"> 
                                            
                                            <v-card-text>
                  
                  
                                              <v-card min-height="80px" class="elevation-2">
                  
                                                <v-card-text>
                                                   
                                                    <v-row>
                                                        <v-col>
                                                        
                                                                <span style="font-weight: bold;" >TOTAL PPE COUNT</span>
                                                        
                                                        </v-col>
                                                    </v-row>
                    
                                                    <v-row>
                                                        <v-col>
                                                            <span class="large-bold-text">{{ ppecount }}</span>
                                                            <span  class="ml-2">ppes</span>
                                                        </v-col>
                    
                                                        <v-col class="d-flex justify-end">
                                                          <v-icon size="40" color="grey">mdi-cart</v-icon>
                                                        </v-col>
                                                    </v-row>
                    
                                                    
                                               </v-card-text>
                                               <v-toolbar height="5" color="#0061F2"></v-toolbar>
                                              </v-card>
                  
                                           
                                            <v-card min-height="100px" class="elevation-2">
                  
                                              <v-card-text>
                                                
                                                  <v-row>
                                                      <v-col>
                                                          <span style="font-weight: bold;">MY PPE UNITS</span>
                                                      </v-col>
                                                  </v-row>
                  
                                                  <v-row>
                                                      <v-col>
                                                          <span class="large-bold-text">{{ myppeunitscount }}</span>
                                                          <span class="ml-2">ppes</span>
                                                      </v-col>
                                      
                  
                                                      <v-col class="d-flex justify-end">
                                                          <v-icon size="40" color="grey">mdi-counter</v-icon>
                                                      </v-col>
                                                  </v-row>
                  
                                             </v-card-text>
                                             <v-toolbar height="5" color="#00AC69"></v-toolbar>
                                            </v-card>
                                            
                                            <v-card min-height="100px" class="elevation-2">
                  
                                              <v-card-text>
                                                
                                                  <v-row>
                                                      <v-col>
                                                          <span style="font-weight: bold;">MY OVERALL PPE VALUATION</span>
                                                      </v-col>
                                                  </v-row>
                  
                                                  <v-row>
                                                      <v-col>
                                                          <span class="large-bold-text"> {{ formatToDecimal(myppeunitsvaluation) }}</span>
                                                          <span class="ml-2">php</span>
                                                      </v-col>
                                      
                  
                                                      <v-col class="d-flex justify-end">
                                                          <v-icon size="30" color="grey">mdi-currency-php</v-icon>
                                                      </v-col>
                                                  </v-row>
                  
                                             </v-card-text>
                                             <v-toolbar height="5" color="#E81400"></v-toolbar>
                                          </v-card>
                  
                                            </v-card-text>
                                        </v-card>
                  
                                    </v-col>
                                     
                                </v-card-text>
                            </v-card>
                    </v-col>

                    <v-col cols="12" md="8" sm="12">
                        <v-row>
                            <v-col md="12">
                                <v-card min-height="350">
                                    <canvas ref="lineChart" style="width: 100%; height: 100%;"></canvas>
                                </v-card>
                            </v-col>
                        </v-row>

                        <v-row>
                            <v-col md="12">
                                <v-card min-height="350">
                                    <canvas id="myChart" style="flex-grow: 1;"></canvas>
                                </v-card>
                            </v-col>
                        </v-row>
                            
                    </v-col>

                </v-row>


                <!-- <v-row>
                  <v-col cols="4" md="4" sm="12">
                    <v-card min-height="350">
                      
                      <v-row class="ml-4 mt-4">
                        <v-col>
                          <h2 >Welcome,</h2>
                        </v-col>
                      </v-row>

                      <v-row class="ml-4">
                        <v-col>
                         
                        </v-col>
                      </v-row>

                    </v-card>
                  </v-col>

                  <v-col cols="8" md="8" sm="12">
                   
                  </v-col>
                </v-row>
     -->
    

                <v-row>
                  <!-- <v-col cols="12" md="" sm="12">
                        <v-card min-height="500"> 
                            <v-toolbar height="50" color="white">
                                <span class="ml-3">Count per category</span>
                                
                            </v-toolbar>
                            <v-card-text>
                            </v-card-text>
                        </v-card>

                    </v-col> -->

                    <v-col cols="12" md="5" sm="12">
                      <v-card min-height="500"> 
                          
                          <v-card-text>


                            <v-card min-height="80px" class="elevation-2">

                              <v-card-text>
                                 
                                  <v-row>
                                      <v-col>
                                      
                                              <span style="font-weight: bold;" >TOTAL PPE COUNT</span>
                                      
                                      </v-col>
                                  </v-row>
  
                                  <v-row>
                                      <v-col>
                                          <span class="large-bold-text">{{ ppecount }}</span>
                                          <span  class="ml-2">ppes</span>
                                      </v-col>
  
                                      <v-col class="d-flex justify-end">
                                        <v-icon size="40" color="grey">mdi-cart</v-icon>
                                      </v-col>
                                  </v-row>
  
                                  
                             </v-card-text>
                             <v-toolbar height="5" color="#0061F2"></v-toolbar>
                            </v-card>

                            <!-- <v-card min-height="100px" class="elevation-2">

                              <v-card-text>
                                
                                  <v-row>
                                      <v-col>
                                          <span >TODAY'S TRANSACTIONS</span>
                                      </v-col>
                                  </v-row>
  
                                  <v-row>
                                      <v-col>
                                          <span class="large-bold-text">{{dailytransactioncount}}</span>
                                          <span  class="ml-2">transactions</span>
                                      </v-col>
                      
  
                                      <v-col class="d-flex justify-end">
                                          <v-icon size="40" color="grey">mdi-account-arrow-down</v-icon>
                                      </v-col>
                                  </v-row>
  
                             </v-card-text>
                             <v-toolbar height="5" color="#F4A000"></v-toolbar>
                          </v-card> -->

                          <v-card min-height="100px" class="elevation-2">

                            <v-card-text>
                              
                                <v-row>
                                    <v-col>
                                        <span style="font-weight: bold;">MY PPE UNITS</span>
                                    </v-col>
                                </v-row>

                                <v-row>
                                    <v-col>
                                        <span class="large-bold-text">{{ myppeunitscount }}</span>
                                        <span class="ml-2">ppes</span>
                                    </v-col>
                    

                                    <v-col class="d-flex justify-end">
                                        <v-icon size="40" color="grey">mdi-counter</v-icon>
                                    </v-col>
                                </v-row>

                           </v-card-text>
                           <v-toolbar height="5" color="#00AC69"></v-toolbar>
                          </v-card>
                          
                          <v-card min-height="100px" class="elevation-2">

                            <v-card-text>
                              
                                <v-row>
                                    <v-col>
                                        <span style="font-weight: bold;">MY OVERALL PPE VALUATION</span>
                                    </v-col>
                                </v-row>

                                <v-row>
                                    <v-col>
                                        <span class="large-bold-text"> {{ formatToDecimal(myppeunitsvaluation) }}</span>
                                        <span class="ml-2">php</span>
                                    </v-col>
                    

                                    <v-col class="d-flex justify-end">
                                        <v-icon size="30" color="grey">mdi-currency-php</v-icon>
                                    </v-col>
                                </v-row>

                           </v-card-text>
                           <v-toolbar height="5" color="#E81400"></v-toolbar>
                        </v-card>

                          </v-card-text>
                      </v-card>

                  </v-col>
                   
                </v-row>
       

     
    </div>
  </template>
  
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import { Chart, registerables } from 'chart.js';
import axios from 'axios';


// Register all necessary Chart.js components
Chart.register(...registerables);

// Reactive references to chart data
const chartInstance = ref(null);
const dailytransactioncount = ref(0);
const myppeunitscount = ref(0);
const myppeunitsvaluation = ref(0);
const ppecount = ref(0);

const fetchChartData = async () => {
    try {
      const response = await axios.get('/api/ppedata');
      return response.data;
    } catch (error) {
      console.error('Error fetching chart data:', error);
      return [];
    }
  };

  
const fetchLineChartData = async () => {
    try {
      const response = await axios.get('/api/getPast7DaysTransactionCounts');
      return response.data;
    } catch (error) {
      console.error('Error fetching chart data:', error);
      return [];
    }
  };

// Function to get dashboard values
const getDashboardValues = async () => {
  try {
    const responses = await Promise.all([
      axios.get('/api/getdailytransactions'),
      axios.get('/api/getmyppeunits'),
      axios.get('/api/getmyppevaluation'),
      axios.get('/api/getppecount')
    ]);

    dailytransactioncount.value = responses[0].data;
    myppeunitscount.value = responses[1].data;
    myppeunitsvaluation.value = responses[2].data;
    ppecount.value = responses[3].data;
  } catch (error) {
    console.error('Error fetching dashboard values:', error);
  }
};

// Format value to decimal with two decimal places
const formatToDecimal = (value) => {
  return value != null ? value.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) : '';
};

const processData  = (data) => {
  // Initialize datasets
  const datasets = {};

  // Process data into datasets by status
  data.forEach(item => {
    const { article, statuslist, count } = item;


    const activeStatusList = ['Active']; // Replace with your logic to determine active statuses

   // Create a dataset for each status if it doesn't exist
   if (!datasets[statuslist]) {
      datasets[statuslist] = {
        label: statuslist,
        data: [],
        backgroundColor: activeStatusList.includes(statuslist) ? '#26A0FC' : getRandomColor(),
        backgroundColor: activeStatusList.includes(statuslist) ? '#26A0FC' : getRandomColor(),
        borderWidth: 2,
      };
    }

    // Add data to the corresponding dataset
    datasets[statuslist].data.push({ x: article, y: count });
  });

  // Convert the datasets object to an array of datasets
  return Object.values(datasets);
};

// Helper function to get a random color for the dataset
const getRandomColor = () => {
  const letters = '0123456789ABCDEF';
  let color = '#';
  for (let i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
};


const lineChart = ref(null);

const createLineChart = (data) => {
  new Chart(lineChart.value, {
    type: 'line',
    data: {
      labels: data.labels,
      datasets: [{
        label: 'Daily transaction count',
        data: data.values,
        borderColor: '#25D694',
        backgroundColor: 'rgba(37, 214, 148, 0.2)',
        fill: true,
        tension: 0.4, // Smooth curve
      }],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false, // Ensures it fills the container without preserving aspect ratio
      scales: {
        x: {
          beginAtZero: true,
        },
        y: {
          beginAtZero: true,
        },
      },
    },
  });
};


onMounted(async () => {

  const lineChartData = await fetchLineChartData();

  const chartData = await fetchChartData(); // Assume this function fetches the processed data
  const ctx = document.getElementById('myChart').getContext('2d');

  // Process chart data to separate datasets
  const processedData = processData(chartData);

  chartInstance.value = new Chart(ctx, {
    type: 'bar',
    data: {
      datasets: processedData
    },
    options: {
      responsive: true,
      // maintainAspectRatio: false, 
      plugins: {
        legend: {
          position: 'bottom',
        },
      },


      scales: {
        x: {
          stacked: true,
          barThickness: 10,
        },
        y: {
          stacked: true,
        },
      },
    },
  });
  getDashboardValues();



  const labels = lineChartData.map(transaction => transaction.day);
  const values = lineChartData.map(transaction => transaction.count);

    createLineChart({
      labels: labels,
      values: values,
    });



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
  color: rgb(63, 62, 62);
}
</style>