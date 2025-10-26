// stores/user.js
import { defineStore } from 'pinia';

export const useUserStore = defineStore('user', {
  state: () => ({
    id: null,
    name: '',
    email: '',
  }),
  actions: {
    updateUser(user) {
      this.id = user.id;
      this.name = user.name;
      this.email = user.email;
    },
  },
});
