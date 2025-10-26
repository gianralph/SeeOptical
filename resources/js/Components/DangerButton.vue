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
        class="inline-flex items-center justify-center px-4 py-2 font-semibold text-xs uppercase tracking-widest transition ease-in-out duration-150"
        color="red"
        :style="{
            'background-color': 'red',
            'color': 'white',
        }"
        :hover="{
            'background-color': 'red darken-1',
        }"
        :active="{
            'background-color': 'red darken-3',
        }"
    >
        <slot />
    </v-btn>
</template>
