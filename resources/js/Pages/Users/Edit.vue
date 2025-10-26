<template>
    <v-container>
      <v-row>
        <v-col>
          <v-form @submit.prevent="updateUser">
            <v-text-field v-model="form.name" label="Name" required></v-text-field>
            <v-text-field v-model="form.email" label="Email" required></v-text-field>
            <v-btn type="submit" color="primary">Save</v-btn>
          </v-form>
        </v-col>
      </v-row>
    </v-container>
  </template>

  <script>
  import { ref } from 'vue';
  // import { useForm } from '@inertiajs/inertia-vue3';

  export default {
    props: {
      user: Object,
    },
    setup(props) {
      const form = useForm({
        ...props.user,
      });

      const updateUser = () => {
        form.put(`/users/${form.id}`);
      };

      return { form, updateUser };
    },
  };
  </script>
