<template>
    <v-dialog v-model="dialogVisible" max-width="500px">
      <v-card>
        <v-card-title>Delete User</v-card-title>
        <v-card-text>
          Are you sure you want to delete this user?
        </v-card-text>
        <v-card-actions>
          <v-btn color="red" @click="confirmDelete" variant="flat">Delete</v-btn>
          <v-btn @click="cancelDelete">Cancel</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
</template>

<script>
import { ref } from 'vue';

export default {
    setup(props, { emit }) {
        const dialogVisible = ref(false);

        const confirmDelete = () => {
            dialogVisible.value = false;
            emit('confirm', props.id);
        };

        const cancelDelete = () => {
            dialogVisible.value = false;
        };

        return {
            dialogVisible,
            confirmDelete,
            cancelDelete
        };
    }
};
</script>
