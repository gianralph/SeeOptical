<!-- QrCodeScanner.vue -->
<template>
  <!-- <v-toolbar-title class="mb-2">QR Code Scanner</v-toolbar-title> -->

  <v-card>

    <v-card-text>
      <v-toolbar-title class="mb-2">QR Code Scanner</v-toolbar-title> 
      <v-row>
        <v-col cols="12" md="12" sm="12">
            <v-btn color="primary" prepend-icon="mdi-qrcode-scan" @click="startScan" class="mr-3 mb-2">New scan</v-btn>
            <v-btn prepend-icon="mdi-qrcode-minus" @click="stopScan" class="mr-2 mb-2">Stop scan</v-btn>
            <!-- <v-btn prepend-icon="mdi-qrcode-edit" @click="resumeScan" :disabled="!isPaused" class="mr-2">Resume scan</v-btn> -->
        </v-col>
      </v-row>
      

      <div class="mt-2 mb-2" id="reader" width="600px"></div>

      <v-row>
        <v-col cols="12" md="3" sm="12"  >
          <div class="d-flex align-items-center">
              <v-icon class="mr-2">mdi-calendar-range</v-icon>
              <span>Property number</span>
          </div>

          <div class="d-flex align-items-center">
              <span style="font-weight: bold;" class="ml-7" >{{ propertynumber}}</span>
          </div>
        </v-col>

        <v-col cols="12" md="3" sm="12"  >
          <div class="d-flex align-items-center">
              <v-icon class="mr-2">mdi-calendar-range</v-icon>
              <span>Accountable officer</span>
          </div>

          <div class="d-flex align-items-center">
              <span style="font-weight: bold;" class="ml-7" >{{ accountableofficer }}</span>
          </div>
        </v-col>

        <v-col cols="12" md="6" sm="12"  >
          <div class="d-flex align-items-center">
              <v-icon class="mr-2">mdi-calendar-range</v-icon>
              <span>Current Location</span>
          </div>

          <div class="d-flex align-items-center">
              <span style="font-weight: bold;" class="ml-7" >{{ location }}</span>
          </div>
        </v-col>

      </v-row>

      <v-row>
        <v-col cols="12" md="12" sm="12"  >
          <div class="d-flex align-items-center">
              <v-icon class="mr-2">mdi-calendar-range</v-icon>
              <span>Description</span>
          </div>

          <div class="d-flex align-items-center">
              <span style="font-weight: bold;" class="ml-7" >{{ description }}</span>
          </div>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12" md="12" sm="12"  >
          <v-checkbox
          v-model="autoadd"
          color="success"
          label="Automatically add scanned items"
          value="success"
          hide-details
        ></v-checkbox>
        </v-col>
      </v-row>

      <v-row>
        <v-col cols="12" md="12" sm="12">
            <v-btn color="green" text class="mr-2" prepend-icon="mdi-check-bold" @click="addItem" v-if="!autoadd"  >Add</v-btn>
        </v-col>
    </v-row>
    </v-card-text>
  </v-card>


</template>

<script setup>
import { ref, onMounted, onBeforeUnmount,defineEmits } from 'vue';
import { Html5QrcodeScanner } from 'html5-qrcode';
import axios from 'axios';

const qrCodeScanner = ref(null);
const isPaused = ref(false); 
const qrCodeScannerId = 'reader';

const scannedid = ref();
const propertynumber =ref();
const accountableofficer = ref();
const description = ref();
const location = ref();

const autoadd = ref('success');

const emit = defineEmits(['scan-success','close']);


    const onScanSuccess = (decodedText, decodedResult) => {

      scannedid.value = decodedText;

        if (qrCodeScanner.value) {
          qrCodeScanner.value.clear().then(() => {
          qrCodeScanner.value = null;
          isPaused.value = false; 
        }).catch((err) => {
          console.error('Unable to stop scanning.', err);
        });
       }

        if (autoadd.value === 'success') {

          // swal.fire({
          //       icon: "success",
          //       text: "Successfully counted scanned item.",
          //       showConfirmButton: false,
          //       timer: 1000});

          emit('scan-success', scannedid.value);   
        }
        else{
          getppeinfo(scannedid.value);
        }

    };


    const onScanError = (errorMessage) => {
      
    };


    const startScan = () => {
      if (!qrCodeScanner.value) {
        qrCodeScanner.value = new Html5QrcodeScanner(qrCodeScannerId, { fps: 10, qrbox: 250 });
      }
      qrCodeScanner.value.render(onScanSuccess, onScanError);
      isPaused.value = false; 
    };

    const stopScan = () => {
      emit('close');
      if (qrCodeScanner.value) {
        qrCodeScanner.value.clear().then(() => {
          // console.log('QR Code scanning stopped.');
          qrCodeScanner.value = null; 
         
        }).catch((err) => {
          console.error('Unable to stop scanning.', err);
        });
      }
    };

    onBeforeUnmount(() => {
      if (qrCodeScanner.value) {
        qrCodeScanner.value.clear().catch((err) => {
          console.error('Error stopping the QR code scanner.', err);
        });
      }
   
    });

  

    

    const getppeinfo = async (id) => {
      await axios.get(`api/getscannedppeinfo/${id}`)
        .then(response => {
          propertynumber.value = response.data.propertynumber;
          accountableofficer.value = response.data.accountableofficer;
          description.value = response.data.description;
          location.value = response.data.location;

        })
        .catch(error => {
          console.error('There was an error in retrieving brands.', error);
        });

    }

    const addItem = () => {
      emit('scan-success', scannedid.value);
      // emit('close'); // Emit a 'close' event to signal that the component should be hidden
    };

</script>

<style scoped>
/* Style for the QR Code Scanner */
#reader {
  margin: auto;
  text-align: center;
}
.swal2-container {
  z-index: 9999 !important; /* Increase this value if needed */ 
}
</style>
