// src/plugins/myPlugin.js
import moment from 'moment';
import pdfMake from 'pdfmake/build/pdfmake';
import pdfFonts from 'pdfmake/build/vfs_fonts';
import Swal from 'sweetalert2/dist/sweetalert2.js';

pdfMake.vfs = pdfFonts.pdfMake.vfs;

const myPlugin = {
    install(app) {
        app.config.globalProperties.$moment = moment;
        app.config.globalProperties.$pdfMake = pdfMake;
        app.config.globalProperties.$swal = Swal;
    }
};

export default myPlugin;