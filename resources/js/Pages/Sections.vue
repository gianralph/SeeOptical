<template>
    <Head title="Sections" />    
    <DashboardLayout>
            <v-card>
                <v-card-title class="d-flex align-center pe-2">
                    <v-icon icon="mdi-home-analytics"></v-icon> &nbsp;
                    Sections
                    <v-spacer></v-spacer>
                    <v-text-field v-model="search" density="compact" label="Search" prepend-inner-icon="mdi-magnify"
                        variant="solo-filled" flat hide-details single-line></v-text-field>
                </v-card-title>

            <v-card-text>
                <v-row>
                 <v-col class="mb-2">
                   <v-btn color="primary" size="small" rounded="lg" prepend-icon="mdi-plus-thick" @click="openDialog()" class="mr-2 mb-2">Add new</v-btn>
                     <v-btn color="#9CCC65"   size="small" rounded="lg" prepend-icon="mdi-refresh" @click="$inertia.visit('/sections')" class="mr-2 mb-2">Refresh</v-btn>
                 </v-col>
                </v-row>
                
                <v-data-table :headers="headers" :items="items" :search="search">
                
                    <template v-slot:item.togglestatus="{ item }">
                        <v-switch v-model="item.statusboolean" color="primary"  hide-details   
                        :value="Boolean(item.statusboolean)" :true-value="1" :false-value="0"></v-switch>                         
                    </template>

                    <template v-slot:item.datecreated="{ item }">
                       {{  formatDate(item.datecreated)  }}                   
                    </template>

                    <template v-slot:item.dateupdated="{ item }">
                        {{  formatDate(item.dateupdated)  }}                   
                     </template>

                     <template v-slot:item.statustext="{ item }">
                        <span :class="getStatusClass(item.statustext)">
                          {{ item.statustext }}
                        </span>
                      </template>
                    

                    <template v-slot:item.actions="{ item }">
                        <v-icon class='mr-2' icon="mdi-pencil" @click="openDialog(item)"></v-icon>
                        <v-icon icon="mdi-cancel" @click="showDeleteDialog(item)"></v-icon>                                                         
                    </template>
                </v-data-table>



                <!-- Dialog for Add and edit -->
                <v-dialog v-model="dialogvisible" max-width="800">
                    <v-form ref="addChecker">
                    
                    <v-card>
  
                      <v-toolbar dark color="#3b3b3b" height="50">
                           
                          <v-toolbar-title>Sections</v-toolbar-title>
                          
                          <v-btn icon  @click="dialogvisible = false">
                              <v-icon>mdi-close-circle-outline</v-icon>
                          </v-btn>
                      </v-toolbar>  
  
                        <v-card-text class="mt-3">
                             <v-row>
                                <v-col cols="12" md="12" sm="12">
                                    <v-text-field v-model="description" label="Section" style="padding-top: 1rem"  variant="outlined" required :rules="[rules.required]"></v-text-field>
                                </v-col>
                            </v-row>  

                            <v-row>
                                <v-col cols="12" md="12" sm="12">
                                    <v-autocomplete v-model="divisionid" 
                                    :items="divisions" color="blue-grey lighten-2" label="Office" 
                                    item-title="description" item-value="id"  
                                    auto-select-first variant="outlined"
                                    required :rules="[rules.required]">
                                </v-autocomplete>
                                </v-col>
                            </v-row>
                           
                            
                            <v-row>
  
                                <v-col cols="12" md="4" sm="12">

                                    <v-select
                                    v-model="status"
                                    :items="statuses"
                                    item-title="status"
                                    item-value="id"
                                    label="Status" variant="outlined">
                                </v-select>
                                </v-col>
                            </v-row>         
                            
                        
                            <v-row>
                                <v-col cols="12" md="12" sm="12" class="d-flex justify-end">
                                    <v-btn color="primary" @click="submitForm()" text  class="mr-2" prepend-icon="mdi-check-bold">Save</v-btn>
                                    <v-btn text @click="dialogvisible = false">Close</v-btn>
                                </v-col>
                            </v-row>
  
                        </v-card-text>
                      
                       
                    </v-card>
                </v-form>
                  </v-dialog>
            
            </v-card-text>
        </v-card>
    </DashboardLayout>


</template>

<script setup>
    import { ref, defineProps, computed, watch,} from 'vue';
    import { useForm, router, Head } from '@inertiajs/vue3';
    import DashboardLayout from '@/Layouts/DashboardLayout.vue';
    import axios from 'axios';
    
    const rules = {
        required: value => !!value || 'Required.',
    };

    const search = ref('');
    const dialogvisible = ref(false);
    const addChecker = ref();
   

    const headers = [
        { title: ' ', key: 'view',width: "30px"},
        { title: 'Description', key: 'description' ,width: "500px"},
        { title: 'Created by', key: 'createdby' },
        { title: 'Date created', key: 'datecreated' },
        { title: 'Updated by', key: 'updatedby' },
        { title: 'Date updated', key: 'dateupdated' },
        { title: 'Status', key: 'statustext' },
        {title: 'Actions', key: 'actions',width: "100px" },
    ];  

    const props = defineProps({
        items: Array,
        divisions: Array,
    });
    
    const items = ref(props.items);

    const statuses = [
        { id: 'A', status: 'Active' },
        { id: 'I', status: 'Inactive' },
    ];

    const id = ref(null);
    const description= ref();
    const divisionid = ref();
    const status = ref();

    const openDialog = (items) => {

        if (items) {
            id.value = items.id;
            description.value = items.description;
            status.value = items.statustext;
            divisionid.value = items.divisionid,
            dialogvisible.value = true;
        }else{
            dialogvisible.value = true;
            id.value = '';
            description.value = '';
            divisionid.value = null,
            status.value = 'Active'
        };

    };

    const formatDate = (date) => {
      return moment(date).format('MMMM DD, YYYY h:mm a'); // Customize the format as needed
    }

    const submitForm = async () => {
        addChecker.value ?.validate().then(async ({
            valid: isValid
        }) => {
            if (isValid) {

                try {

                    await axios.post(`sections`,{params: {
                    id: id.value,
                    description: description.value,
                    divisionid: divisionid.value,
                    status:status.value,
                }})
                .then(response => {
                    
                })
                .catch(error => {
                console.error('There was an error in submitting form.', error);
                });          
                
                    loaditems();
                    dialogvisible.value = false;    
                
                    swal.fire({
                        text: "Item has been saved.",
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1500
                    });

                } catch (error) {
                    console.error('Error submitting form:', error);
                }
            }
        })
    };

    const loaditems = async () => {
     

        await axios.get(`/api/loadsections`)
        .then(response => {
            items.value = response.data;
        })
        .catch(error => {
          console.error('There was an error in retrieving data.', error);
        });       
    }


    const showDeleteDialog = (item) => {

    swal.fire({
    title: 'Confirm',
    icon: 'question',
    text: "Are you sure to deactivate selected item?",
    showCancelButton: true,
    confirmButtonColor: "#3085d6",
    cancelButtonColor: "#d33",
    confirmButtonText: "Yes, delete it!"
    }).then(async (result) => {
    if (result.isConfirmed) {

        if (item.id === undefined || item.id === null || item.id === '') {
        }        
        else{

        //delete using axios
        await axios.delete('api/sections/' + item.id);

        swal.fire({
        icon: "success",
        text: "Successfully deleted selected item.",
        showConfirmButton: false,
        timer: 1000});

        loaditems();

        }
    }
    });
    };



           // Function to get status class
           const getStatusClass = (status) => {
        switch (status) {
        case 'Active':
        return 'status-active';
        case 'Inactive':
        return 'status-inactive';
        default:
        return '';
         }
        };

</script>


<style>

.status-inactive {
  color: rgb(209, 27, 43);
  font-weight: bold;
}

.status-active {
  color: rgb(26, 185, 66);
  font-weight: bold;
}


</style>