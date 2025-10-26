<script setup>
defineProps({
    type: {
        type: String,
        default: 'button',
    },
});
</script>

<template>
   <v-btn
        :type="type"
        class="inline-flex items-center px-4 py-2 font-semibold text-xs uppercase tracking-widest shadow-sm"
        color="white"
        dark
        outlined
        :disabled="type === 'disabled'"
    >
        <slot />
    </v-btn>
</template>
