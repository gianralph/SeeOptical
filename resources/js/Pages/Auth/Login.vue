<template>
  <Head title="Sign in" />

  <div class="login-page">
    <!-- Soft medical background -->
    <div class="background-shape shape-one"></div>
    <div class="background-shape shape-two"></div>
    <div class="background-glow"></div>

    <main class="login-wrapper">
      <section class="login-card">

        <!-- Clinic Brand -->
        <div class="brand">
          <div class="eye-logo">
            <svg
              viewBox="0 0 64 64"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <!-- Eye -->
              <path
                d="M7 32C13.8 20.8 22.2 15.5 32 15.5C41.8 15.5 50.2 20.8 57 32C50.2 43.2 41.8 48.5 32 48.5C22.2 48.5 13.8 43.2 7 32Z"
                fill="#EAF7FA"
                stroke="#168FA3"
                stroke-width="3"
              />

              <!-- Iris -->
              <circle
                cx="32"
                cy="32"
                r="10"
                fill="#168FA3"
              />

              <!-- Pupil -->
              <circle
                cx="32"
                cy="32"
                r="4"
                fill="#143D50"
              />

              <!-- Highlight -->
              <circle
                cx="35"
                cy="29"
                r="2"
                fill="white"
              />
            </svg>
          </div>

          <div>
            <div class="clinic-name">
              {{ appName }}
            </div>

            <div class="clinic-type">
              OPHTHALMOLOGY CLINIC
            </div>
          </div>
        </div>

        <!-- Heading -->
        <!-- <div class="heading">
          <h1>Welcome back</h1>
          <p>
            Sign in to continue to your clinic portal
          </p>
        </div> -->

        <!-- Login Form -->
        <v-form
          ref="myForm"
          @submit.prevent="submit"
        >

          <!-- Email -->
          <div class="form-group">
            <label for="email">
              Email
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
              class="google-input"
              prepend-inner-icon="mdi-email-outline"
            />
          </div>

          <!-- Password -->
          <div class="form-group password-group">
            <div class="password-header">
              <label for="password">
                Password
              </label>
<!-- 
              <a
                v-if="canResetPassword"
                :href="route('password.request')"
                class="forgot-password"
              >
                Forgot password?
              </a> -->
            </div>

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
              class="google-input"
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
            Secure clinic access
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
          Ophthalmology & Eye Care
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

const appName = import.meta.env.VITE_APP_NAME;

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
   PAGE
========================================= */

.login-page {
  min-height: 100vh;
  width: 100%;

  position: relative;

  display: flex;
  align-items: center;
  justify-content: center;

  overflow: hidden;

  background:
    linear-gradient(
      135deg,
      #f8fcfd 0%,
      #f4f9fb 45%,
      #eef8fa 100%
    );

  font-family:
    Inter,
    "Google Sans",
    Roboto,
    Arial,
    sans-serif;
}


/* =========================================
   BACKGROUND
========================================= */

.background-glow {
  position: absolute;

  width: 700px;
  height: 700px;

  top: -350px;
  right: -200px;

  border-radius: 50%;

  background:
    radial-gradient(
      circle,
      rgba(22, 143, 163, 0.12),
      rgba(22, 143, 163, 0) 70%
    );
}

.background-shape {
  position: absolute;

  border-radius: 50%;

  pointer-events: none;
}

.shape-one {
  width: 350px;
  height: 350px;

  bottom: -190px;
  left: -100px;

  background:
    radial-gradient(
      circle,
      rgba(55, 171, 190, 0.10),
      transparent 70%
    );
}

.shape-two {
  width: 220px;
  height: 220px;

  top: 18%;
  left: 12%;

  border: 1px solid rgba(22, 143, 163, 0.08);
}


/* =========================================
   WRAPPER
========================================= */

.login-wrapper {
  position: relative;
  z-index: 2;

  width: 100%;
  max-width: 440px;

  padding: 28px 20px;
}


/* =========================================
   CARD
========================================= */

.login-card {
  background: #ffffff;

  border: 1px solid #e3ecef;

  border-radius: 16px;

  padding: 42px 40px 32px;

  box-shadow:
    0 2px 4px rgba(20, 55, 70, 0.04),
    0 12px 35px rgba(20, 55, 70, 0.07);
}


/* =========================================
   BRAND
========================================= */

.brand {
  display: flex;
  align-items: center;

  gap: 13px;

  margin-bottom: 38px;
}

.eye-logo {
  width: 48px;
  height: 48px;

  display: flex;
  align-items: center;
  justify-content: center;

  flex-shrink: 0;
}

.eye-logo svg {
  width: 100%;
  height: 100%;
}

.clinic-name {
  color: #173d4f;

  font-size: 17px;
  font-weight: 700;

  letter-spacing: -0.25px;
}

.clinic-type {
  margin-top: 3px;

  color: #7b919c;

  font-size: 9px;
  font-weight: 700;

  letter-spacing: 1.5px;
}


/* =========================================
   HEADING
========================================= */

.heading {
  margin-bottom: 30px;
}

.heading h1 {
  margin: 0 0 8px;

  color: #202c33;

  font-size: 28px;
  line-height: 1.2;

  font-weight: 500;

  letter-spacing: -0.5px;
}

.heading p {
  margin: 0;

  color: #6f818a;

  font-size: 14px;
  line-height: 1.5;
}


/* =========================================
   FORM
========================================= */

.form-group {
  margin-bottom: 21px;
}

.form-group label {
  display: block;

  margin-bottom: 7px;

  color: #40545d;

  font-size: 13px;
  font-weight: 500;
}

.password-group {
  margin-bottom: 9px;
}

.password-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.forgot-password {
  color: #16839a;

  font-size: 12px;
  font-weight: 600;

  text-decoration: none;
}

.forgot-password:hover {
  text-decoration: underline;
}


/* =========================================
   INPUTS
========================================= */

.google-input :deep(.v-field) {
  min-height: 48px;

  border-radius: 7px;

  background: #ffffff;

  transition:
    box-shadow 0.15s ease,
    border-color 0.15s ease;
}

.google-input :deep(.v-field__outline) {
  --v-field-border-opacity: 1;

  color: #c7d4d9;
}

.google-input :deep(.v-field:hover .v-field__outline) {
  color: #9db1ba;
}

.google-input :deep(.v-field--focused .v-field__outline) {
  color: #168fa3;
}

.google-input :deep(.v-field--focused) {
  box-shadow:
    0 0 0 2px rgba(22, 143, 163, 0.12);
}

.google-input :deep(input) {
  color: #263c46;

  font-size: 14px;
}

.google-input :deep(input::placeholder) {
  color: #9aaab1;
  opacity: 1;
}

.google-input :deep(.v-icon) {
  color: #8499a2;
}


/* =========================================
   REMEMBER
========================================= */

.remember {
  margin-bottom: 18px;
}

.remember :deep(.v-label) {
  color: #657982;

  font-size: 12px;
}


/* =========================================
   SIGN IN
========================================= */

.signin-button {
  height: 48px !important;

  border-radius: 7px !important;

  background: #168fa3 !important;

  color: #ffffff !important;

  font-size: 14px !important;

  font-weight: 600 !important;

  text-transform: none !important;

  letter-spacing: 0 !important;

  box-shadow:
    0 2px 5px rgba(22, 143, 163, 0.20);

  transition:
    background 0.15s ease,
    box-shadow 0.15s ease,
    transform 0.15s ease;
}

.signin-button:hover {
  background: #117e91 !important;

  box-shadow:
    0 4px 10px rgba(22, 143, 163, 0.25);
}

.signin-button:active {
  transform: translateY(1px);
}


/* =========================================
   SECURITY
========================================= */

.secure-login {
  display: flex;
  align-items: center;
  justify-content: center;

  gap: 6px;

  margin-top: 25px;
  padding-top: 20px;

  border-top: 1px solid #edf2f4;

  color: #8799a1;

  font-size: 11px;
}


/* =========================================
   FOOTER
========================================= */

footer {
  display: flex;
  justify-content: center;
  align-items: center;

  gap: 8px;

  margin-top: 18px;

  color: #8da0a8;

  font-size: 10px;
}

.footer-divider {
  color: #c3ced2;
}


/* =========================================
   MOBILE
========================================= */

@media (max-width: 480px) {

  .login-wrapper {
    padding: 16px;
  }

  .login-card {
    padding: 32px 24px 27px;

    border-radius: 14px;
  }

  .brand {
    margin-bottom: 30px;
  }

  .heading h1 {
    font-size: 25px;
  }

  .heading {
    margin-bottom: 25px;
  }
}

</style>
