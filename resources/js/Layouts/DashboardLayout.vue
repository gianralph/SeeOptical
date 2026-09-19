<template>
    <v-app class="ios-clinic">
        <!-- ================================
             TOP BAR
        ================================= -->

<v-app-bar height="64" flat class="ios-navbar">
    <!-- Drawer Toggle Icon -->
    <v-app-bar-nav-icon @click="drawer = !drawer" class="nav-toggle ms-1 me-2" />

    <!-- App Brand -->
    <div class="app-brand">
      <div class="app-brand-icon">
        <v-icon size="20" color="primary">mdi-eye-outline</v-icon>
      </div>

      <span class="app-brand-name">
        {{ appName }}
      </span>
    </div>

    <v-spacer />

    <!-- Profile Menu -->
    <v-menu location="bottom end" transition="scale-transition" offset="8">
      <template #activator="{ props }">
        <button v-bind="props" class="profile-button">
          <!-- User Avatar / Fallback Initials -->
          <v-avatar size="36" color="primary" class="profile-avatar text-caption font-weight-bold">
            <v-img
              v-if="$page.props.auth.user.avatar"
              :src="$page.props.auth.user.avatar"
              alt="Avatar"
            />
            <span v-else>
              {{ $page.props.auth.user.name ? $page.props.auth.user.name.charAt(0).toUpperCase() : 'U' }}
            </span>
          </v-avatar>

          <div class="profile-info d-none d-sm-flex">
            <span class="profile-name">
              {{ $page.props.auth.user.name }}
            </span>

            <small class="profile-role">
              {{ $page.props.auth.user.type }}
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
              {{ $page.props.auth.user.name }}
            </p>
            <p class="text-caption text-medium-emphasis text-truncate mb-0">
              {{ $page.props.auth.user.email }}
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
            color="error" 
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
            <!-- ================================
                 SIDEBAR CONTENT
            ================================= -->

            <div class="sidebar-content">
                <!-- Clinic -->
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

                <!-- ================================
                     ADMINISTRATION
                ================================= -->

                <template v-if="$page.props.auth.user.type === 'Administrator'">
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

            <!-- ================================
                 SIDEBAR FOOTER
            ================================= -->

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

/* =========================================================
   STATE
========================================================= */

const drawer = ref(true);

const appName = import.meta.env.VITE_APP_NAME;

/* =========================================================
   API TOKEN
========================================================= */

onMounted(() => {
    const apiToken = localStorage.getItem("api_token");

    if (apiToken) {
        window.axios.defaults.headers.common["Authorization"] =
            `Bearer ${apiToken}`;
    }
});

/* =========================================================
   NAVIGATION HELPERS
========================================================= */

const isPath = (path) => {
    return window.location.pathname.startsWith(path);
};

const isActive = (name) => {
    return route().current(name);
};

/* =========================================================
   LOGOUT
========================================================= */

const logout = () => {
    localStorage.removeItem("api_token");

    delete window.axios.defaults.headers.common["Authorization"];

    router.post(route("logout"));
};
</script>

<style scoped>
/* =========================================================
   iOS DESIGN SYSTEM
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

    /*
     * Closest native feeling without requiring
     * Apple's proprietary font files.
     */
    font-family:
        -apple-system, BlinkMacSystemFont, "SF Pro Display", "SF Pro Text",
        "Helvetica Neue", Arial, sans-serif;

    letter-spacing: -0.01em;
}

/* =========================================================
   APP
========================================================= */

.ios-clinic :deep(.v-application) {
    background: var(--ios-bg);
}

/* =========================================================
   NAVIGATION BAR
========================================================= */

.ios-navbar {
    height: 64px !important;

    background: rgba(255, 255, 255, 0.88) !important;

    border-bottom: 0.5px solid rgba(60, 60, 67, 0.18) !important;

    box-shadow: none !important;

    backdrop-filter: saturate(180%) blur(20px);

    -webkit-backdrop-filter: saturate(180%) blur(20px);

    color: var(--ios-text);
}

.nav-toggle {
    color: var(--ios-blue) !important;

    opacity: 0.95;
}

.app-brand {
    display: flex;

    align-items: center;

    gap: 9px;

    margin-left: 2px;
}

.app-brand-icon {
    width: 34px;
    height: 34px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 10px;

    background: linear-gradient(145deg, #e8f3ff, #dceeff);

    color: var(--ios-blue);
}

.app-brand-name {
    color: var(--ios-text);

    font-size: 16px;

    font-weight: 600;

    letter-spacing: -0.35px;
}

/* =========================================================
   PROFILE
========================================================= */

.profile-button {
    display: flex;

    align-items: center;

    gap: 8px;

    margin-right: 12px;

    padding: 4px 8px 4px 4px;

    border: none;

    border-radius: 20px;

    background: transparent;

    color: var(--ios-secondary);

    font-family: inherit;

    cursor: pointer;

    transition: background 0.15s ease;
}

.profile-button:hover {
    background: rgba(118, 118, 128, 0.1);
}

.profile-avatar {
    background: var(--ios-blue-light) !important;

    color: var(--ios-blue) !important;

    font-size: 13px;

    font-weight: 600;
}

.profile-info {
    display: flex;

    flex-direction: column;

    align-items: flex-start;
}

.profile-info span {
    color: var(--ios-text);

    font-size: 13px;

    font-weight: 500;
}

.profile-info small {
    margin-top: 1px;

    color: var(--ios-tertiary);

    font-size: 10px;
}

.ios-menu {
    min-width: 220px;

    overflow: hidden;

    background: rgba(255, 255, 255, 0.96) !important;

    border: 0.5px solid rgba(60, 60, 67, 0.12) !important;

    border-radius: 14px !important;

    box-shadow: 0 10px 35px rgba(0, 0, 0, 0.12) !important;

    backdrop-filter: blur(20px);
}

/* =========================================================
   SIDEBAR
========================================================= */

.ios-sidebar {
    background: rgba(255, 255, 255, 0.94) !important;

    border-right: 0.5px solid rgba(60, 60, 67, 0.15) !important;

    box-shadow: none !important;

    backdrop-filter: blur(20px);

    -webkit-backdrop-filter: blur(20px);
}

/*
 * IMPORTANT:
 *
 * Vuetify's drawer content is made into a flex column.
 *
 * This allows:
 *
 * 1. Menu to take available height.
 * 2. Menu to scroll independently.
 * 3. Footer to stay at the bottom.
 * 4. Footer never to overlap menu items.
 */

.ios-sidebar :deep(.v-navigation-drawer__content) {
    display: flex;

    flex-direction: column;

    overflow: hidden;
}

/* =========================================================
   SIDEBAR CONTENT
========================================================= */

.sidebar-content {
    flex: 1;

    min-height: 0;

    padding: 20px 10px;

    overflow-y: auto;

    overflow-x: hidden;

    /*
     * Firefox
     */
    scrollbar-width: thin;
}

/*
 * WebKit scrollbar
 */

.sidebar-content::-webkit-scrollbar {
    width: 5px;
}

.sidebar-content::-webkit-scrollbar-track {
    background: transparent;
}

.sidebar-content::-webkit-scrollbar-thumb {
    background: rgba(0, 0, 0, 0.12);

    border-radius: 10px;
}

/* =========================================================
   SIDEBAR HEADER
========================================================= */

.sidebar-header {
    display: flex;

    align-items: center;

    gap: 11px;

    height: 70px;

    padding: 0 18px;

    border-bottom: 0.5px solid rgba(60, 60, 67, 0.12);
}

.clinic-symbol {
    width: 36px;
    height: 36px;

    display: flex;

    align-items: center;
    justify-content: center;

    border-radius: 10px;

    background: var(--ios-blue-light);

    color: var(--ios-blue);
}

.clinic-name {
    color: var(--ios-text);

    font-size: 14px;

    font-weight: 600;

    letter-spacing: -0.15px;
}

.clinic-description {
    margin-top: 1px;

    color: var(--ios-tertiary);

    font-size: 10px;
}

/* =========================================================
   NAVIGATION
========================================================= */

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

/* =========================================================
   iOS NAV ITEM
========================================================= */

.ios-nav-item {
    position: relative;

    min-height: 43px;

    margin: 3px 0;

    border-radius: 11px;

    color: var(--ios-secondary);

    font-size: 13px;

    font-weight: 500;

    letter-spacing: -0.1px;

    transition:
        background 0.15s ease,
        color 0.15s ease,
        transform 0.12s ease;
}

.ios-nav-item :deep(.v-list-item__prepend > .v-icon) {
    color: #8e9aa4;

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

/* =========================================================
   SELECTED
========================================================= */

.ios-nav-item.selected {
    background: var(--ios-blue-light) !important;

    color: var(--ios-blue) !important;

    font-weight: 600;
}

.ios-nav-item.selected :deep(.v-list-item__prepend > .v-icon) {
    color: var(--ios-blue) !important;
}

/* =========================================================
   SUB NAVIGATION
========================================================= */

.ios-sub-item {
    min-height: 38px;

    margin-left: 12px;

    border-radius: 9px;

    color: var(--ios-secondary);

    font-size: 12px;
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

/* =========================================================
   SYSTEM STATUS
========================================================= */

.system-status {
    display: flex;

    align-items: center;

    gap: 7px;

    margin-bottom: 8px;

    padding: 8px 11px;

    border-radius: 9px;

    background: rgba(52, 199, 89, 0.08);

    color: #64806c;

    font-size: 10px;
}

.status-dot {
    width: 7px;
    height: 7px;

    flex-shrink: 0;

    border-radius: 50%;

    background: var(--ios-green);

    box-shadow: 0 0 0 3px rgba(52, 199, 89, 0.1);
}

/* =========================================================
   SIGN OUT
========================================================= */

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

    transition:
        background 0.15s ease,
        color 0.15s ease;
}

.signout-button:hover {
    background: rgba(255, 59, 48, 0.07);

    color: var(--ios-red);
}

/* =========================================================
   MAIN CONTENT
========================================================= */

.ios-main {
    background: var(--ios-bg) !important;
}

.page-content {
    min-height: calc(100vh - 64px);

    padding: 28px 32px;
}

/* =========================================================
   VUETIFY CARDS
========================================================= */

.ios-clinic :deep(.v-card) {
    border-radius: 14px;

    border: 0.5px solid rgba(60, 60, 67, 0.1);

    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.025);
}

/* =========================================================
   BUTTONS
========================================================= */

.ios-clinic :deep(.v-btn) {
    border-radius: 10px;

    font-family: inherit;

    letter-spacing: -0.1px;

    text-transform: none;

    box-shadow: none;
}

.ios-clinic :deep(.v-btn.bg-primary) {
    background: var(--ios-blue) !important;
}

/* =========================================================
   TEXT FIELDS
========================================================= */

.ios-clinic :deep(.v-field) {
    border-radius: 11px;

    background: rgba(255, 255, 255, 0.9);
}

.ios-clinic :deep(.v-field--focused) {
    box-shadow: 0 0 0 3px rgba(0, 122, 255, 0.12);
}

/* =========================================================
   TABLES
========================================================= */

.ios-clinic :deep(.v-data-table) {
    background: white;

    border-radius: 14px;

    overflow: hidden;
}

.ios-clinic :deep(.v-data-table thead th) {
    background: #f9f9fb;

    color: var(--ios-secondary);

    font-size: 11px;

    font-weight: 600;

    border-bottom: 0.5px solid var(--ios-separator);
}

.ios-clinic :deep(.v-data-table tbody td) {
    color: var(--ios-text);

    font-size: 13px;

    border-bottom: 0.5px solid #e5e5ea;
}

/* =========================================================
   MOBILE
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

    /*
     * Slightly smaller footer on phones.
     */

    .sidebar-footer {
        padding: 8px 13px 12px;
    }

    .system-status {
        margin-bottom: 5px;

        padding: 7px 10px;
    }

    .signout-button {
        min-height: 36px;

        padding: 7px 10px;
    }
}

/* =========================================================
   SMALL PHONES
========================================================= */

@media (max-width: 380px) {
    .app-brand-icon {
        width: 31px;

        height: 31px;
    }

    .app-brand-name {
        font-size: 14px;
    }

    .sidebar-content {
        padding: 16px 8px;
    }

    .sidebar-footer {
        padding: 7px 11px 10px;
    }
}
</style>
