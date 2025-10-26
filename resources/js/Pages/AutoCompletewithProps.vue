<template>
    <v-autocomplete
      :items="items"
      item-text="name"
      item-value="id"
      label="Select an item"
      solo
      v-model="selectedItemId"
    ></v-autocomplete>
  </template>
  
  <script>
  export default {
    name: 'AutocompleteWithProps',
    props: {
      items: {
        type: Array,
        required: true,
      },
    },
    data() {
      return {
        selectedItemId: null,
      };
    },
  };
  </script>
  
  <style scoped>
  /* Your styles here */
  </style>
  