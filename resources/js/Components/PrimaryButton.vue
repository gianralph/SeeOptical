<template>
    <v-btn
      :type="type"
      color="primary"
      class="font-semibold text-uppercase"
      :disabled="disabled"
      @click="$emit('click')"
    >
      <slot />
    </v-btn>
  </template>

  <script setup>
  import { defineProps } from 'vue';

  const props = defineProps({
    type: {
      type: String,
      default: 'submit',
    },
    disabled: Boolean,
  });
  </script>
