<template>
  <Head title="Log in" />

  <!-- Fullscreen wrapper -->
  <div class="h-screen w-screen relative flex items-center justify-center overflow-hidden">
    <!-- Background Image -->
    <div
      class="absolute inset-0 bg-cover bg-center"
      style="background-image: url('/assets/images/background.jpg');"
    ></div>

    <!-- Dark Overlay -->
    <div class="absolute inset-0 bg-black/30"></div>

    <!-- Centered Glass Card -->
    <div
      class="relative z-10 bg-white/60 backdrop-blur-md rounded-2xl shadow-2xl p-10 w-full max-w-sm text-center"
    >
      <!-- Logo -->
      <!-- <div class="mb-6">
        <img src="/assets/images/logo.png" alt="Logo" class="h-20 w-auto mx-auto" />
      </div> -->

      <!-- Title -->
      <h1 class="text-3xl font-bold text-gray-800 mb-2">Log In</h1>
      <p class="text-gray-600 mb-6">{{ appName }}</p>

      <!-- Form -->
      <v-form @submit.prevent="submit" ref="myForm" class="space-y-5">
        <!-- Email -->
        <v-text-field
          prepend-inner-icon="mdi-account-circle-outline"
          label="Email"
          v-model="form.email"
          type="email"
          required
          autofocus
          variant="outlined"
          autocomplete="username"
          :rules="[rules.required]"
          dense
          rounded
        />

        <!-- Password -->
        <v-text-field
          prepend-inner-icon="mdi-lock-outline"
          label="Password"
          v-model="form.password"
          type="password"
          required
          autocomplete="current-password"
          :rules="[rules.required]"
          dense
          variant="outlined"
          rounded
        />


        <!-- Submit Button -->
<v-btn
  :disabled="form.processing"
  color="blue darken-2"
  class="w-full py-3 text-lg font-medium rounded-xl flex items-center justify-center"
  @click="submit"
>
  <template v-if="form.processing">
    Logging in...
  </template>
  <template v-else>
    Log In
  </template>
</v-btn>
      </v-form>
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { Head, Link, useForm } from "@inertiajs/vue3";

defineProps({ canResetPassword: Boolean, status: String });

const myForm = ref();
const rules = { required: (value) => !!value || "Required." };
const appName = import.meta.env.VITE_APP_NAME;

const form = useForm({ email: "", password: "", remember: false });

const apiLogin = async (formData) => {
  try {
    const response = await axios.post("api/sanctum/token", formData);
    return response.data;
  } catch (error) {
    swal.fire({
      icon: "error",
      title: "Invalid Username/Password",
      showConfirmButton: false,
      timer: 1500,
    });
    if (error.response?.data?.errors) return error.response.data.errors;
    else throw error;
  }
};

const inertiaLogin = async (formData) => {
  await form.post(route("login"), {
    onFinish: () => form.reset("password"),
  });
};

const submit = async () => {
  myForm.value?.validate().then(async ({ valid: isValid }) => {
    if (isValid) {
      try {
        const formData = {
          email: form.email,
          password: form.password,
          device_name: "web",
          remember: form.remember ? "on" : "",
        };
        const apiToken = await apiLogin(formData);
        localStorage.setItem("api_token", apiToken);
        axios.defaults.headers.common["Authorization"] = `Bearer ${apiToken}`;
        await inertiaLogin(formData);
      } catch (error) {
        console.error("Login failed:", error);
      }
    }
  });
};
</script>

<style scoped>
html, body, #app {
  height: 100%;
}

body {
  font-family: 'Inter', sans-serif;
}
</style>
