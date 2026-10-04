<template>
  <v-app class="ios-clinic">
    <!-- ================================
         TOP BAR
    ================================= -->
    <v-app-bar height="64" flat class="ios-navbar">
      <!-- Drawer Toggle Icon -->
      <v-app-bar-nav-icon @click="drawer = !drawer" class="nav-toggle ms-1 me-2" color="primary" />

      <!-- App Brand -->
      <div class="app-brand">
        <div class="app-brand-icon">
          <v-icon size="20" color="primary">mdi-eye-outline</v-icon>
        </div>

        <span class="app-brand-name">
          {{ appName || 'Clinic EMR' }}
        </span>
      </div>

      <v-spacer />

      <!-- Profile Menu -->
      <v-menu location="bottom end" transition="scale-transition" :offset="8">
        <template #activator="{ props }">
          <button v-bind="props" class="profile-button">
            <!-- User Avatar / Fallback Initials -->
            <v-avatar size="34" color="primary" class="profile-avatar text-caption font-weight-bold">
              <v-img
                v-if="$page?.props?.auth?.user?.avatar"
                :src="$page.props.auth.user.avatar"
                alt="Avatar"
              />
              <span v-else class="text-white">
                {{ $page?.props?.auth?.user?.name ? $page.props.auth.user.name.charAt(0).toUpperCase() : 'U' }}
              </span>
            </v-avatar>

            <div class="profile-info d-none d-sm-flex">
              <span class="profile-name">
                {{ $page?.props?.auth?.user?.name || 'User' }}
              </span>

              <small class="profile-role">
                {{ $page?.props?.auth?.user?.type || 'Staff' }}
              </small>
            </div>

            <v-icon size="18" class="chevron-icon text-medium-emphasis">
              mdi-chevron-down
            </v-icon>
          </button>
        </template>

        <!-- Glass Dropdown Menu -->
        <v-card class="ios-menu rounded-xl pa-2" width="220" elevation="8">
          <v-list density="comfortable" class="bg-transparent pa-0">
            <!-- Mini Profile Header inside Menu -->
            <div class="px-3 py-2 mb-1">
              <p class="text-subtitle-2 font-weight-bold text-truncate mb-0">
                {{ $page?.props?.auth?.user?.name }}
              </p>
              <p class="text-caption text-medium-emphasis text-truncate mb-0">
                {{ $page?.props?.auth?.user?.email }}
              </p>
            </div>

            <v-divider class="my-1 border-opacity-25" />

            <v-list-item
              prepend-icon="mdi-account-outline"
              class="rounded-lg my-1"
              @click="$inertia.visit(route('profile.show'))"
            >
              <v-list-item-title class="font-weight-medium">Profile</v-list-item-title>
            </v-list-item>

            <v-divider class="my-1 border-opacity-25" />

            <v-list-item 
              prepend-icon="mdi-logout" 
              class="rounded-lg my-1 logout-item" 
              @click="logout"
            >
              <v-list-item-title class="font-weight-medium text-error">Sign Out</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-card>
      </v-menu>
    </v-app-bar>

    <!-- ================================
         SIDEBAR
    ================================= -->
    <v-navigation-drawer
      v-model="drawer"
      :permanent="!$vuetify.display.smAndDown"
      :temporary="$vuetify.display.smAndDown"
      width="245"
      class="ios-sidebar"
    >
      <div class="sidebar-content">
        <!-- Clinic Section -->
        <div class="section-title">CLINIC</div>

        <v-list nav class="ios-navigation">
          <!-- Dashboard -->
          <v-list-item
            prepend-icon="mdi-view-dashboard-outline"
            :class="[
              'ios-nav-item',
              isActive('dashboard') ? 'selected' : '',
            ]"
            @click="$inertia.visit(route('dashboard'))"
          >
            <v-list-item-title> Dashboard </v-list-item-title>
          </v-list-item>

          <!-- Visits -->
          <v-list-item
            prepend-icon="mdi-calendar-outline"
            :class="[
              'ios-nav-item',
              isPath('/visits') ? 'selected' : '',
            ]"
            @click="$inertia.visit('/visits')"
          >
            <v-list-item-title> Visits </v-list-item-title>
          </v-list-item>

          <!-- Patients -->
          <v-list-item
            prepend-icon="mdi-account-outline"
            :class="[
              'ios-nav-item',
              isPath('/patients') ? 'selected' : '',
            ]"
            @click="$inertia.visit('/patients')"
          >
            <v-list-item-title> Patients </v-list-item-title>
          </v-list-item>

          <!-- Glasses Orders -->
          <v-list-item
            prepend-icon="mdi-account-eye-outline"
            :class="[
              'ios-nav-item',
              isPath('/glasses-orders') ? 'selected' : '',
            ]"
            @click="$inertia.visit('/glasses-orders')"
          >
            <v-list-item-title> Glasses Orders </v-list-item-title>
          </v-list-item>

          <!-- Glasses Inventory -->
          <v-list-item
            prepend-icon="mdi-glasses"
            :class="[
              'ios-nav-item',
              isPath('/glasses-inventory') ? 'selected' : '',
            ]"
            @click="$inertia.visit('/glasses-inventory')"
          >
            <v-list-item-title>
              Glasses Inventory
            </v-list-item-title>
          </v-list-item>
        </v-list>

        <!-- Administration Section -->
        <template v-if="$page?.props?.auth?.user?.type === 'Administrator'">
          <div class="section-title admin-title">ADMINISTRATION</div>

          <v-list nav class="ios-navigation">
            <!-- User Management -->
            <v-list-item
              prepend-icon="mdi-account-multiple-outline"
              :class="[
                'ios-nav-item',
                isPath('/users') ? 'selected' : '',
              ]"
              @click="$inertia.visit('/users')"
            >
              <v-list-item-title>
                User Management
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </template>
      </div>

      <!-- Sidebar Footer -->
      <div class="sidebar-footer">
        <div class="system-status">
          <span class="status-dot"></span>
          <span> System operational </span>
        </div>

        <button class="signout-button" @click="logout">
          <v-icon size="17"> mdi-arrow-right-box-outline </v-icon>
          <span> Sign Out </span>
        </button>
      </div>
    </v-navigation-drawer>

    <!-- ================================
         MAIN CONTENT
    ================================= -->
    <v-main class="ios-main">
      <div class="page-content">
        <slot />
      </div>
    </v-main>
  </v-app>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { router } from "@inertiajs/vue3";

/* STATE */
const drawer = ref(true);
const appName = import.meta.env.VITE_APP_NAME;

/* API TOKEN INITIALIZATION */
onMounted(() => {
  const apiToken = localStorage.getItem("api_token");
  if (apiToken && window.axios) {
    window.axios.defaults.headers.common["Authorization"] = `Bearer ${apiToken}`;
  }
});

/* NAVIGATION HELPERS */
const isPath = (path) => {
  return window.location.pathname.startsWith(path);
};

const isActive = (name) => {
  return typeof route === 'function' ? route().current(name) : false;
};

/* LOGOUT */
const logout = () => {
  localStorage.removeItem("api_token");
  if (window.axios) {
    delete window.axios.defaults.headers.common["Authorization"];
  }
  router.post(route("logout"));
};
</script>

<style scoped>
/* =========================================================
   iOS DESIGN SYSTEM TOKENS
========================================================= */
.ios-clinic {
  --ios-blue: #007aff;
  --ios-blue-light: #eaf4ff;
  --ios-blue-soft: #f5f9ff;
  --ios-bg: #f2f2f7;
  --ios-card: #ffffff;
  --ios-text: #1c1c1e;
  --ios-secondary: #636366;
  --ios-tertiary: #8e8e93;
  --ios-separator: #d1d1d6;
  --ios-green: #34c759;
  --ios-red: #ff3b30;

  font-family: -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text",
    "Helvetica Neue", Arial, sans-serif;
  letter-spacing: -0.01em;
}

.ios-clinic :deep(.v-application) {
  background: var(--ios-bg);
}

/* =========================================================
   TOP NAVIGATION BAR (GLASSMORPHISM WITH BLUE TINT)
========================================================= */
:deep(.ios-navbar),
.ios-navbar {
  height: 64px !important;
  
  /* Layered semi-transparent blue base over image */
  background-color: rgba(224, 242, 254, 0.5) !important;
  background-image: 
    linear-gradient(135deg, rgba(242, 243, 243, 0.904) 0%, rgba(30, 58, 138, 0.18) 100%);
  background-position: center top !important;
  background-size: cover !important;
  background-repeat: no-repeat !important;

  /* Frosted Glass Effect */
  backdrop-filter: blur(25px) saturate(190%) !important;
  -webkit-backdrop-filter: blur(25px) saturate(190%) !important;

  /* Border & Inner Specular Highlight Line */
  border-bottom: 1px solid rgba(255, 255, 255, 0.45) !important;
  box-shadow: 
    inset 0 1px 0 0 rgba(255, 255, 255, 0.5),
    0 4px 20px -2px rgba(14, 165, 233, 0.08) !important;

  color: var(--ios-text) !important;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

:deep(.v-toolbar__content) {
  background: transparent !important;
}

.nav-toggle {
  color: var(--ios-blue) !important;
  opacity: 0.95;
}

.app-brand {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-left: 2px;
}

.app-brand-icon {
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 10px;
  background: rgba(255, 255, 255, 0.65);
  border: 1px solid rgba(14, 165, 233, 0.35);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.04);
}

.app-brand-name {
  color: #0369a1;
  font-size: 16px;
  font-weight: 700;
  letter-spacing: -0.35px;
}

/* =========================================================
   PROFILE BUTTON & DROPDOWN
========================================================= */
.profile-button {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-right: 12px;
  padding: 4px 10px 4px 4px;
  background: rgba(255, 255, 255, 0.55);
  border: 1px solid rgba(255, 255, 255, 0.7);
  border-radius: 30px;
  cursor: pointer;
  outline: none;
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}

.profile-button:hover {
  background: rgba(255, 255, 255, 0.85);
  border-color: rgba(14, 165, 233, 0.4);
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(14, 165, 233, 0.15);
}

.profile-avatar {
  border: 1.5px solid rgba(255, 255, 255, 0.9);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
}

.profile-info {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  line-height: 1.2;
}

.profile-name {
  color: var(--ios-text);
  font-size: 13px;
  font-weight: 600;
}

.profile-role {
  color: #0284c7;
  font-size: 10px;
  font-weight: 500;
}

.ios-menu {
  min-width: 220px;
  overflow: hidden;
  background: rgba(255, 255, 255, 0.88) !important;
  border: 0.5px solid rgba(255, 255, 255, 0.8) !important;
  border-radius: 16px !important;
  box-shadow: 0 10px 35px rgba(0, 0, 0, 0.12) !important;
  backdrop-filter: blur(20px) saturate(180%);
  -webkit-backdrop-filter: blur(20px) saturate(180%);
}

.logout-item:hover {
  background: rgba(239, 68, 68, 0.1) !important;
}

/* =========================================================
   SIDEBAR
========================================================= */
.ios-sidebar {
  background: rgba(255, 255, 255, 0.92) !important;
  border-right: 0.5px solid rgba(60, 60, 67, 0.12) !important;
  box-shadow: none !important;
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
}

.ios-sidebar :deep(.v-navigation-drawer__content) {
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.sidebar-content {
  flex: 1;
  min-height: 0;
  padding: 20px 10px;
  overflow-y: auto;
  overflow-x: hidden;
  scrollbar-width: thin;
}

.sidebar-content::-webkit-scrollbar {
  width: 4px;
}

.sidebar-content::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.12);
  border-radius: 10px;
}

.section-title {
  padding: 0 13px 8px;
  color: var(--ios-tertiary);
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.2px;
  text-transform: uppercase;
}

.admin-title {
  margin-top: 25px;
}

.ios-navigation {
  padding: 0 !important;
}

.ios-nav-item {
  position: relative;
  min-height: 42px;
  margin: 3px 0;
  border-radius: 11px;
  color: var(--ios-secondary);
  font-size: 13px;
  font-weight: 500;
  letter-spacing: -0.1px;
  transition: background 0.15s ease, color 0.15s ease, transform 0.12s ease;
}

.ios-nav-item :deep(.v-list-item__prepend > .v-icon) {
  color: #070707;
  font-size: 20px;
  margin-inline-end: 13px;
}

.ios-nav-item:hover {
  background: rgba(0, 122, 255, 0.06);
  color: var(--ios-blue);
}

.ios-nav-item:active {
  transform: scale(0.985);
}

.ios-nav-item.selected {
  background: var(--ios-blue-light) !important;
  color: var(--ios-blue) !important;
  font-weight: 600;
}

.ios-nav-item.selected :deep(.v-list-item__prepend > .v-icon) {
  color: var(--ios-blue) !important;
}

/* =========================================================
   SIDEBAR FOOTER
========================================================= */
.sidebar-footer {
  flex-shrink: 0;
  padding: 10px 13px 14px;
  background: rgba(255, 255, 255, 0.94);
  border-top: 0.5px solid rgba(60, 60, 67, 0.08);
}

.system-status {
  display: flex;
  align-items: center;
  gap: 7px;
  margin-bottom: 8px;
  padding: 8px 11px;
  border-radius: 9px;
  background: rgba(52, 199, 89, 0.08);
  color: #3b7a4a;
  font-size: 10px;
  font-weight: 500;
}

.status-dot {
  width: 7px;
  height: 7px;
  flex-shrink: 0;
  border-radius: 50%;
  background: var(--ios-green);
  box-shadow: 0 0 0 3px rgba(52, 199, 89, 0.15);
}

.signout-button {
  width: 100%;
  display: flex;
  align-items: center;
  gap: 8px;
  min-height: 38px;
  padding: 8px 11px;
  border: 0;
  border-radius: 9px;
  background: transparent;
  color: var(--ios-secondary);
  font-family: inherit;
  font-size: 12px;
  cursor: pointer;
  transition: background 0.15s ease, color 0.15s ease;
}

.signout-button:hover {
  background: rgba(255, 59, 48, 0.08);
  color: var(--ios-red);
}

/* =========================================================
   MAIN CONTENT AREA
========================================================= */
.ios-main {
  background: var(--ios-bg) !important;
}

.page-content {
  min-height: calc(100vh - 64px);
  padding: 28px 32px;
}

/* =========================================================
   RESPONSIVE ADJUSTMENTS
========================================================= */
@media (max-width: 600px) {
  .profile-info {
    display: none;
  }

  .profile-button {
    margin-right: 6px;
  }

  .app-brand-name {
    font-size: 15px;
  }

  .page-content {
    padding: 18px 14px;
  }

  .sidebar-footer {
    padding: 8px 13px 12px;
  }
}
</style>