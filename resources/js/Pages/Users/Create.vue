<template>
    <v-container>
      <v-row>
        <v-col>
          <v-form @submit.prevent="createUser">
            <v-text-field v-model="form.name" label="Name" required></v-text-field>
            <v-text-field v-model="form.email" label="Email" required></v-text-field>
            <v-text-field v-model="form.password" label="Password" type="password" required></v-text-field>
            <v-btn type="submit" color="primary">Save</v-btn>
          </v-form>
        </v-col>
      </v-row>
    </v-container>
  </template>

  <script>
  import { ref } from 'vue';
  import { useForm } from '@inertiajs/vue3';

  export default {
    setup() {
      const form = useForm({
        name: '',
        email: '',
        password: '',
      });

      const createUser = () => {
        form.post('/users');
      };

      return { form, createUser };
    },
  };
  </script>
