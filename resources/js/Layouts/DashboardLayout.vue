<template>
    <v-app class="ios-clinic">

        <!-- ================================
             TOP BAR
        ================================= -->

        <v-app-bar
            height="64"
            flat
            class="ios-navbar"
        >
            <v-app-bar-nav-icon
                @click="drawer = !drawer"
                class="nav-toggle"
            />

            <div class="app-brand">
                <div class="app-brand-icon">
                    <v-icon size="20">
                        mdi-eye-outline
                    </v-icon>
                </div>

                <span class="app-brand-name">
                    {{ appName }}
                </span>
            </div>

            <v-spacer />

            <v-menu
                location="bottom end"
                transition="scale-transition"
            >
                <template #activator="{ props }">

                    <button
                        v-bind="props"
                        class="profile-button"
                    >


                        <div class="profile-info">
                            <span>
                                {{ $page.props.auth.user.name }}
                            </span>

                            <small>
                                {{ $page.props.auth.user.type }}
                            </small>
                        </div>

                        <v-icon size="16">
                            mdi-chevron-down
                        </v-icon>
                    </button>

                </template>

                <v-card class="ios-menu">

                    <v-list density="comfortable">

                        <v-list-item
                            prepend-icon="mdi-account-outline"
                            @click="
                                $inertia.visit(
                                    route('profile.show')
                                )
                            "
                        >
                            <v-list-item-title>
                                Profile
                            </v-list-item-title>
                        </v-list-item>

                        <v-divider />

                        <v-list-item
                            prepend-icon="mdi-logout"
                            @click="logout"
                        >
                            <v-list-item-title>
                                Sign Out
                            </v-list-item-title>
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

            <!-- Clinic identity -->
            <!-- <div class="sidebar-header">

                <div class="clinic-symbol">
                    <v-icon size="23">
                        mdi-eye-outline
                    </v-icon>
                </div>

                <div>
                    <div class="clinic-name">
                        {{ appName }}
                    </div>

                    <div class="clinic-description">
                        Ophthalmology
                    </div>
                </div>

            </div> -->


            <!-- Navigation -->
            <div class="sidebar-content">

                <div class="section-title">
                    CLINIC
                </div>

                <v-list
                    nav
                    class="ios-navigation"
                >

                    <!-- Dashboard -->
                    <v-list-item
                        prepend-icon="mdi-view-dashboard-outline"
                        :class="[
                            'ios-nav-item',
                            isActive('dashboard')
                                ? 'selected'
                                : ''
                        ]"
                        @click="
                            $inertia.visit(
                                route('dashboard')
                            )
                        "
                    >
                        <v-list-item-title>
                            Dashboard
                        </v-list-item-title>
                    </v-list-item>


                    <!-- Visits -->
                    <v-list-item
                        prepend-icon="mdi-calendar-outline"
                        :class="[
                            'ios-nav-item',
                            isPath('/visits')
                                ? 'selected'
                                : ''
                        ]"
                        @click="
                            $inertia.visit('/visits')
                        "
                    >
                        <v-list-item-title>
                            Visits
                        </v-list-item-title>
                    </v-list-item>


                    <!-- Patients -->
                    <v-list-item
                        prepend-icon="mdi-account-outline"
                        :class="[
                            'ios-nav-item',
                            isPath('/patients')
                                ? 'selected'
                                : ''
                        ]"
                        @click="
                            $inertia.visit('/patients')
                        "
                    >
                        <v-list-item-title>
                            Patients
                        </v-list-item-title>
                    </v-list-item>


                    <!-- Glasses -->
                    <v-list-item
                        prepend-icon="mdi-glasses"
                        :class="[
                            'ios-nav-item',
                            isPath('/glasses-orders')
                                ? 'selected'
                                : ''
                        ]"
                        @click="
                            $inertia.visit(
                                '/glasses-orders'
                            )
                        "
                    >
                        <v-list-item-title>
                            Glasses Orders
                        </v-list-item-title>
                    </v-list-item>

                </v-list>


                <!-- Administration -->
                <template
                    v-if="
                        $page.props.auth.user.type ===
                        'Administrator'
                    "
                >

                    <div class="section-title admin-title">
                        ADMINISTRATION
                    </div>

                    <v-list
                        nav
                        class="ios-navigation"
                    >

                        <!-- <v-list-group value="libraries">

                            <template #activator="{ props }">

                                <v-list-item
                                    v-bind="props"
                                    prepend-icon="mdi-folder-outline"
                                    class="ios-nav-item"
                                >
                                    <v-list-item-title>
                                        Libraries
                                    </v-list-item-title>
                                </v-list-item>

                            </template>

                            <v-list-item
                                prepend-icon="mdi-calendar-outline"
                                class="ios-sub-item"
                                @click="
                                    $inertia.visit(
                                        '/visits'
                                    )
                                "
                            >
                                <v-list-item-title>
                                    Visits
                                </v-list-item-title>
                            </v-list-item>

                        </v-list-group> -->


                        <v-list-item
                            prepend-icon="mdi-account-multiple-outline"
                            :class="[
                                'ios-nav-item',
                                isPath('/users')
                                    ? 'selected'
                                    : ''
                            ]"
                            @click="
                                $inertia.visit('/users')
                            "
                        >
                            <v-list-item-title>
                                User Management
                            </v-list-item-title>
                        </v-list-item>

                    </v-list>

                </template>

            </div>


            <!-- Bottom -->
            <div class="sidebar-footer">

                <div class="system-status">
                    <span class="status-dot"></span>

                    <span>
                        System operational
                    </span>
                </div>

                <button
                    class="signout-button"
                    @click="logout"
                >
                    <v-icon size="17">
                        mdi-arrow-right-box-outline
                    </v-icon>

                    Sign Out
                </button>

            </div>

        </v-navigation-drawer>


        <!-- ================================
             CONTENT
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

const drawer = ref(true);

const appName =
    import.meta.env.VITE_APP_NAME;


onMounted(() => {
    const apiToken =
        localStorage.getItem("api_token");

    if (apiToken) {
        window.axios.defaults.headers.common[
            "Authorization"
        ] = `Bearer ${apiToken}`;
    }
});


const isPath = (path) => {
    return window.location.pathname.startsWith(path);
};


const isActive = (name) => {
    return route().current(name);
};


const logout = () => {
    localStorage.removeItem("api_token");

    delete window.axios.defaults.headers.common[
        "Authorization"
    ];

    router.post(route("logout"));
};
</script>

<style scoped>

/* =========================================================
   iOS DESIGN SYSTEM
========================================================= */

.ios-clinic {
    --ios-blue: #007AFF;
    --ios-blue-light: #EAF4FF;
    --ios-blue-soft: #F5F9FF;

    --ios-bg: #F2F2F7;
    --ios-card: #FFFFFF;

    --ios-text: #1C1C1E;
    --ios-secondary: #636366;
    --ios-tertiary: #8E8E93;

    --ios-separator: #D1D1D6;

    --ios-green: #34C759;
    --ios-red: #FF3B30;

    /*
     * Closest native feeling without requiring
     * Apple's proprietary font files.
     */
    font-family:
        -apple-system,
        BlinkMacSystemFont,
        "SF Pro Display",
        "SF Pro Text",
        "Helvetica Neue",
        Arial,
        sans-serif;

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

    background:
        rgba(255, 255, 255, 0.88) !important;

    border-bottom:
        0.5px solid rgba(60, 60, 67, 0.18) !important;

    box-shadow: none !important;

    backdrop-filter:
        saturate(180%) blur(20px);

    -webkit-backdrop-filter:
        saturate(180%) blur(20px);

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

    background:
        linear-gradient(
            145deg,
            #E8F3FF,
            #DCEEFF
        );

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

    transition:
        background 0.15s ease;
}

.profile-button:hover {
    background:
        rgba(118, 118, 128, 0.10);
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

    background:
        rgba(255, 255, 255, 0.96) !important;

    border:
        0.5px solid rgba(60, 60, 67, 0.12) !important;

    border-radius: 14px !important;

    box-shadow:
        0 10px 35px rgba(0, 0, 0, 0.12) !important;

    backdrop-filter:
        blur(20px);
}


/* =========================================================
   SIDEBAR
========================================================= */

.ios-sidebar {
    background:
        rgba(255, 255, 255, 0.94) !important;

    border-right:
        0.5px solid rgba(60, 60, 67, 0.15) !important;

    box-shadow: none !important;

    backdrop-filter:
        blur(20px);

    -webkit-backdrop-filter:
        blur(20px);
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

    border-bottom:
        0.5px solid rgba(60, 60, 67, 0.12);
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

.sidebar-content {
    padding: 20px 10px;
}

.section-title {
    padding:
        0 13px 8px;

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
    color: #8E9AA4;

    font-size: 20px;

    margin-inline-end: 13px;
}

.ios-nav-item:hover {
    background:
        rgba(0, 122, 255, 0.06);

    color: var(--ios-blue);
}

.ios-nav-item:active {
    transform: scale(0.985);
}


/* =========================================================
   SELECTED
========================================================= */

.ios-nav-item.selected {
    background:
        var(--ios-blue-light) !important;

    color:
        var(--ios-blue) !important;

    font-weight: 600;
}

.ios-nav-item.selected
:deep(.v-list-item__prepend > .v-icon) {
    color:
        var(--ios-blue) !important;
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
    position: absolute;

    right: 13px;
    bottom: 14px;
    left: 13px;
}

.system-status {
    display: flex;
    align-items: center;

    gap: 7px;

    margin-bottom: 8px;

    padding: 8px 11px;

    border-radius: 9px;

    background:
        rgba(52, 199, 89, 0.08);

    color:
        #64806C;

    font-size: 10px;
}

.status-dot {
    width: 7px;
    height: 7px;

    border-radius: 50%;

    background: var(--ios-green);

    box-shadow:
        0 0 0 3px rgba(52, 199, 89, 0.10);
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
}

.signout-button:hover {
    background:
        rgba(255, 59, 48, 0.07);

    color: var(--ios-red);
}


/* =========================================================
   MAIN CONTENT
========================================================= */

.ios-main {
    background:
        var(--ios-bg) !important;
}

.page-content {
    min-height:
        calc(100vh - 64px);

    padding:
        28px 32px;
}


/* =========================================================
   VUETIFY CARDS
========================================================= */

.ios-clinic :deep(.v-card) {
    border-radius: 14px;

    border:
        0.5px solid rgba(60, 60, 67, 0.10);

    box-shadow:
        0 1px 2px rgba(0, 0, 0, 0.025);
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
    background:
        var(--ios-blue) !important;
}


/* =========================================================
   TEXT FIELDS
========================================================= */

.ios-clinic :deep(.v-field) {
    border-radius: 11px;

    background:
        rgba(255, 255, 255, 0.90);
}

.ios-clinic :deep(.v-field--focused) {
    box-shadow:
        0 0 0 3px rgba(0, 122, 255, 0.12);
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
    background: #F9F9FB;

    color: var(--ios-secondary);

    font-size: 11px;
    font-weight: 600;

    border-bottom:
        0.5px solid var(--ios-separator);
}

.ios-clinic :deep(.v-data-table tbody td) {
    color: var(--ios-text);

    font-size: 13px;

    border-bottom:
        0.5px solid #E5E5EA;
}


/* =========================================================
   MOBILE
========================================================= */

@media (max-width: 600px) {

    .profile-info {
        display: none;
    }

    .app-brand-name {
        font-size: 15px;
    }

    .page-content {
        padding:
            18px 14px;
    }
}

</style>

