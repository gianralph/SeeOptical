<template>
    <div>
        <DashboardLayout>
            <slot></slot>
        </DashboardLayout>
    </div>
</template>

<script>
import DashboardLayout from "@/Layouts/DashboardLayout.vue";

export default {
    components: {
        DashboardLayout,
    },
};
</script>
