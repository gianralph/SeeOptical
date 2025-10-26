import "./bootstrap";
import "../css/app.css";
import "@mdi/font/css/materialdesignicons.css";
import { createApp, h } from "vue";
import { createInertiaApp } from "@inertiajs/vue3";
import { resolvePageComponent } from "laravel-vite-plugin/inertia-helpers";
import { ZiggyVue } from "../../vendor/tightenco/ziggy";
import vuetify from "./vuetify"; // Import vuetify.js
import { createPinia } from "pinia"; // Import Pinia
import "vuetify/styles"; // Import Vuetify styles
import moment from "moment/moment";
import numeral from "numeral";

// import pdfMake from 'pdfmake/build/pdfmake';
// import pdfFonts from 'pdfmake/build/vfs_fonts';
import "@sweetalert2/theme-material-ui/material-ui.scss";
import "sweetalert2/dist/sweetalert2.min.css";
import Swal from "sweetalert2/dist/sweetalert2.js";

import printJS from "print-js";
import { PDFPlugin } from "vue3-pdfmake";
import { usePDF } from "vue3-pdfmake";

import CanvasJSChart from "@canvasjs/vue-charts";

const appName = import.meta.env.VITE_APP_NAME || "Laravel";

const myPlugin = {
    install(app) {
        app.config.globalProperties.$moment = moment;
        app.config.globalProperties.$pdfMake = pdfMake;
        // app.config.globalProperties.$pdfFonts = pdfFonts;
        app.config.globalProperties.$printJS = printJS;
        app.config.globalProperties.$swal = Swal;
    },
};
window.swal = Swal;
window.usePDF = usePDF;
window.moment = moment;
window.numeral = numeral;

createInertiaApp({
    title: (title) => `${title} - ${appName}`,
    resolve: (name) =>
        resolvePageComponent(
            `./Pages/${name}.vue`,
            import.meta.glob("./Pages/**/*.vue")
        ),
    setup({ el, App, props, plugin }) {
        const pinia = createPinia(); // Create a Pinia instance
        return createApp({ render: () => h(App, props) })
            .use(plugin)
            .use(ZiggyVue)
            .use(vuetify)
            .use(pinia) // Use Pinia in your application
            .use(myPlugin)
            .use(PDFPlugin)
            .use(CanvasJSChart)
            .mount(el);
    },
    progress: {
        color: "#4B5563",
    },
});

