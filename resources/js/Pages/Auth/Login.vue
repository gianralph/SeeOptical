<template>
  <Head title="Sign in" />

  <div class="login-page">
    <!-- Top Header Bar -->
    <header class="top-header">
      <div class="header-brand">
        <div class="header-logo">
          <svg
            viewBox="0 0 64 64"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M7 32C13.8 20.8 22.2 15.5 32 15.5C41.8 15.5 50.2 20.8 57 32C50.2 43.2 41.8 48.5 32 48.5C22.2 48.5 13.8 43.2 7 32Z"
              fill="#EAF7FA"
              stroke="#168FA3"
              stroke-width="3"
            />
            <circle cx="32" cy="32" r="10" fill="#168FA3" />
            <circle cx="32" cy="32" r="4" fill="#143D50" />
            <circle cx="35" cy="29" r="2" fill="white" />
          </svg>
        </div>
        <div>
          <div class="header-title">See Optical</div>
          <div class="header-subtitle">OPHTHALMOLOGY CLINIC</div>
        </div>
      </div>
    </header>

    <!-- Background Image Layer -->
    <div class="bg-image"></div>
    
    <!-- Dark Blue Overlay -->
    <div class="bg-overlay"></div>

    <main class="login-wrapper">

      <!-- Main Logo Badge -->
      <div class="badge-logo">
        <svg
          viewBox="0 0 64 64"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M7 32C13.8 20.8 22.2 15.5 32 15.5C41.8 15.5 50.2 20.8 57 32C50.2 43.2 41.8 48.5 32 48.5C22.2 48.5 13.8 43.2 7 32Z"
            fill="#EAF7FA"
            stroke="#168FA3"
            stroke-width="3"
          />
          <circle cx="32" cy="32" r="10" fill="#168FA3" />
          <circle cx="32" cy="32" r="4" fill="#143D50" />
          <circle cx="35" cy="29" r="2" fill="white" />
        </svg>
      </div>

      <!-- Main Page Title -->

      <section class="login-card">

        <!-- Login Form -->
        <v-form
          ref="myForm"
          @submit.prevent="submit"
        >

          <!-- Email -->
          <div class="form-group">
            <label for="email">
              Email Address
            </label>

            <v-text-field
              id="email"
              v-model="form.email"
              type="email"
              placeholder="Enter your email"
              autocomplete="username"
              variant="outlined"
              density="comfortable"
              hide-details="auto"
              :rules="[rules.required]"
              class="custom-input"
              prepend-inner-icon="mdi-email-outline"
            />
          </div>

          <!-- Password -->
          <div class="form-group password-group">
            <label for="password">
              Password
            </label>

            <v-text-field
              id="password"
              v-model="form.password"
              :type="showPassword ? 'text' : 'password'"
              placeholder="Enter your password"
              autocomplete="current-password"
              variant="outlined"
              density="comfortable"
              hide-details="auto"
              :rules="[rules.required]"
              class="custom-input"
              prepend-inner-icon="mdi-lock-outline"
              :append-inner-icon="
                showPassword
                  ? 'mdi-eye-off-outline'
                  : 'mdi-eye-outline'
              "
              @click:append-inner="
                showPassword = !showPassword
              "
            />
          </div>

          <!-- Submit -->
          <v-btn
            type="submit"
            block
            size="large"
            :loading="form.processing"
            :disabled="form.processing"
            class="signin-button"
          >
            <span v-if="!form.processing">
              Sign in
            </span>

            <span v-else>
              Signing in...
            </span>
          </v-btn>

        </v-form>

        <!-- Secure login -->
        <div class="secure-login">
          <v-icon
            size="17"
            color="#168FA3"
          >
            mdi-shield-check-outline
          </v-icon>

          <span>
            Secure clinic portal access
          </span>
        </div>

      </section>

      <!-- Footer -->
      <footer>
        <span>
          © {{ new Date().getFullYear() }} {{ appName }}
        </span>

        <span class="footer-divider">·</span>

        <span>
          Ophthalmology & Eye Care Services
        </span>
      </footer>
    </main>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { Head, useForm } from "@inertiajs/vue3";

defineProps({
  canResetPassword: Boolean,
  status: String,
});

const myForm = ref();
const showPassword = ref(false);

const rules = {
  required: (value) =>
    !!value || "This field is required.",
};

const appName = import.meta.env.VITE_APP_NAME || "Clinic Portal";

const form = useForm({
  email: "",
  password: "",
  remember: false,
});

const apiLogin = async (formData) => {
  try {
    const response = await axios.post(
      "/api/sanctum/token",
      formData
    );

    return response.data;
  } catch (error) {
    swal.fire({
      icon: "error",
      title: "Unable to sign in",
      text: "Please check your email and password.",
      showConfirmButton: false,
      timer: 1800,
    });

    if (error.response?.data?.errors) {
      return error.response.data.errors;
    }

    throw error;
  }
};

const inertiaLogin = async (formData) => {
  await form.post(route("login"), {
    onFinish: () => {
      form.reset("password");
    },
  });
};

const submit = async () => {
  const { valid } = await myForm.value.validate();

  if (!valid) return;

  try {
    const formData = {
      email: form.email,
      password: form.password,
      device_name: "web",
      remember: form.remember ? "on" : "",
    };

    const apiToken = await apiLogin(formData);

    localStorage.setItem(
      "api_token",
      apiToken
    );

    axios.defaults.headers.common[
      "Authorization"
    ] = `Bearer ${apiToken}`;

    await inertiaLogin(formData);

  } catch (error) {
    console.error(
      "Login failed:",
      error
    );
  }
};
</script>

<style scoped>

/* =========================================
   PAGE & BACKGROUND LAYERS
========================================= */

.login-page {
  min-height: 100vh;
  width: 100%;
  position: relative;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;
  overflow: hidden;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
}

/* Local Public Image Asset Path */
.bg-image {
  position: absolute;
  top: -20px;
  left: -20px;
  right: -20px;
  bottom: -20px;
  background-image: url('/assets/images/loginbg.jpg');
  background-size: cover;
  background-position: center;
  filter: blur(8px);
  z-index: 0;
}

/* Dark Navy-Blue Tint Overlay */
.bg-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(10, 28, 51, 0.82);
  z-index: 1;
}

/* =========================================
   TOP HEADER BAR
========================================= */

.top-header {
  position: relative;
  z-index: 3;
  width: 100%;
  height: 60px;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(5px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 0 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.header-brand {
  display: flex;
  align-items: center;
  gap: 12px;
}

.header-logo {
  width: 36px;
  height: 36px;
}

.header-logo svg {
  width: 100%;
  height: 100%;
}

.header-title {
  color: #1a202c;
  font-size: 14px;
  font-weight: 700;
  line-height: 1.2;
}

.header-subtitle {
  color: #718096;
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.5px;
}

/* =========================================
   WRAPPER & CENTERED CONTENT
========================================= */

.login-wrapper {
  position: relative;
  z-index: 2;
  width: 100%;
  max-width: 460px;
  padding: 48px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.badge-logo {
  width: 72px;
  height: 72px;
  background: #ffffff;
  border-radius: 50%;
  padding: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
  margin-bottom: 20px;
}

.badge-logo svg {
  width: 100%;
  height: 100%;
}

.portal-title {
  color: #ffffff;
  font-size: 26px;
  font-weight: 700;
  text-align: center;
  margin-bottom: 28px;
  letter-spacing: -0.3px;
  text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

/* =========================================
   CARD
========================================= */

.login-card {
  width: 100%;
  background: #f8fafc;
  border-radius: 20px;
  padding: 36px 32px 28px;
  box-shadow: 0 20px 30px -10px rgba(0, 0, 0, 0.3);
}

/* =========================================
   FORM ELEMENTS
========================================= */

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  margin-bottom: 8px;
  color: #334155;
  font-size: 13px;
  font-weight: 600;
}

.custom-input :deep(.v-field) {
  min-height: 48px;
  border-radius: 10px;
  background: #ffffff;
}

.custom-input :deep(.v-field__outline) {
  --v-field-border-opacity: 1;
  color: #cbd5e1;
}

.custom-input :deep(.v-field--focused .v-field__outline) {
  color: #0284c7;
}

.custom-input :deep(input) {
  color: #0f172a;
  font-size: 14px;
}

/* =========================================
   BUTTON & SECURITY
========================================= */

.signin-button {
  height: 48px !important;
  border-radius: 10px !important;
  background: #0284c7 !important;
  color: #ffffff !important;
  font-size: 15px !important;
  font-weight: 600 !important;
  text-transform: none !important;
  letter-spacing: 0 !important;
  margin-top: 8px;
  box-shadow: 0 4px 12px rgba(2, 132, 199, 0.3);
}

.signin-button:hover {
  background: #0369a1 !important;
}

.secure-login {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 6px;
  margin-top: 24px;
  padding-top: 18px;
  border-top: 1px solid #e2e8f0;
  color: #64748b;
  font-size: 12px;
}

/* =========================================
   FOOTER
========================================= */

footer {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px;
  margin-top: 28px;
  color: #94a3b8;
  font-size: 12px;
}

.footer-divider {
  color: #64748b;
}

/* =========================================
   MOBILE
========================================= */

@media (max-width: 480px) {
  .login-card {
    padding: 28px 20px 22px;
    border-radius: 16px;
  }

  .portal-title {
    font-size: 22px;
  }
}
</style>