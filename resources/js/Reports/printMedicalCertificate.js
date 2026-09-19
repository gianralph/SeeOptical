import pdfMake from "pdfmake/build/pdfmake";
import pdfFonts from "pdfmake/build/vfs_fonts";
import printJS from "print-js";

const vfs = pdfFonts.pdfMake.vfs;

const formatDate = (date) => {
    if (!date) return "";

    const parsed = new Date(date);

    if (Number.isNaN(parsed.getTime())) {
        return date;
    }

    return parsed.toLocaleDateString("en-PH", {
        year: "numeric",
        month: "long",
        day: "numeric",
    });
};

const displayValue = (value) => {
    if (value === null || value === undefined || value === "") {
        return "";
    }

    return String(value);
};

const row = (label, value) => [
    {
        text: label,
        bold: true,
    },
    {
        text: displayValue(value),
    },
];

export const printMedicalCertificate = async (visit) => {
    if (!visit) {
        console.error("Medical certificate: no visit supplied.");
        return;
    }

    console.log("Printing medical certificate for visit:", visit);

    const patientName = visit.patient_name ?? "-";
    const doctorName = visit.doctor_name ?? "-";
    const chiefComplaint = visit.chief_complaint ?? "-";

    const eyeExaminationRows = [];

    if (visit.external_exam) {
        eyeExaminationRows.push(
            row("External Examination", visit.external_exam)
        );
    }

    if (visit.anterior_segment) {
        eyeExaminationRows.push(
            row("Anterior Segment", visit.anterior_segment)
        );
    }

    if (visit.fundus_exam) {
        eyeExaminationRows.push(
            row("Fundus Examination", visit.fundus_exam)
        );
    }

    if (visit.other_findings) {
        eyeExaminationRows.push(
            row("Other Findings", visit.other_findings)
        );
    }

    const docDefinition = {
        pageSize: "LETTER",

        pageMargins: [45, 35, 45, 40],

        defaultStyle: {
            fontSize: 9,
        },

        content: [
            {
                text: "SEE SYSTEM",
                fontSize: 15,
                bold: true,
                alignment: "center",
                margin: [0, 0, 0, 2],
            },

            {
                text: "OPHTHALMOLOGY CLINIC",
                fontSize: 10,
                bold: true,
                alignment: "center",
                margin: [0, 0, 0, 8],
            },

            {
                canvas: [
                    {
                        type: "line",
                        x1: 0,
                        y1: 0,
                        x2: 522,
                        y2: 0,
                        lineWidth: 0.7,
                    },
                ],
                margin: [0, 0, 0, 12],
            },

            {
                text: "MEDICAL CERTIFICATE",
                fontSize: 16,
                bold: true,
                alignment: "center",
                margin: [0, 0, 0, 12],
            },

            {
                text: `Date: ${formatDate(visit.visit_date)}`,
                alignment: "right",
                fontSize: 8,
                margin: [0, 0, 0, 10],
            },

            {
                text: "TO WHOM IT MAY CONCERN:",
                bold: true,
                margin: [0, 0, 0, 8],
            },

            {
                text: [
                    "This is to certify that ",
                    {
                        text: patientName,
                        bold: true,
                    },
                    " was examined at this clinic on ",
                    {
                        text: formatDate(visit.visit_date),
                        bold: true,
                    },
                    ".",
                ],
                lineHeight: 1.25,
                margin: [0, 0, 0, 10],
            },

            {
                table: {
                    widths: ["28%", "72%"],
                    body: [
                        row("Patient Name", patientName),
                        row("Visit Type", visit.visit_type),
                        row("Chief Complaint", chiefComplaint),
                    ],
                },

                layout: {
                    hLineWidth: () => 0.4,
                    vLineWidth: () => 0.4,
                    paddingLeft: () => 5,
                    paddingRight: () => 5,
                    paddingTop: () => 3,
                    paddingBottom: () => 3,
                },

                margin: [0, 0, 0, 10],
            },

            {
                text: "VISUAL ASSESSMENT",
                bold: true,
                fontSize: 10,
                margin: [0, 2, 0, 5],
            },

            {
                table: {
                    widths: ["40%", "30%", "30%"],

                    body: [
                        [
                            {
                                text: "Examination",
                                bold: true,
                            },
                            {
                                text: "OD",
                                bold: true,
                                alignment: "center",
                            },
                            {
                                text: "OS",
                                bold: true,
                                alignment: "center",
                            },
                        ],

                        [
                            "Visual Acuity",
                            {
                                text: displayValue(
                                    visit.visual_acuity_od
                                ),
                                alignment: "center",
                            },
                            {
                                text: displayValue(
                                    visit.visual_acuity_os
                                ),
                                alignment: "center",
                            },
                        ],

                        [
                            "IOP",
                            {
                                text: displayValue(visit.iop_od),
                                alignment: "center",
                            },
                            {
                                text: displayValue(visit.iop_os),
                                alignment: "center",
                            },
                        ],
                    ],
                },

                layout: {
                    hLineWidth: () => 0.4,
                    vLineWidth: () => 0.4,
                    paddingLeft: () => 5,
                    paddingRight: () => 5,
                    paddingTop: () => 3,
                    paddingBottom: () => 3,
                },

                margin: [0, 0, 0, 10],
            },

            ...(eyeExaminationRows.length
                ? [
                      {
                          text: "EYE EXAMINATION",
                          bold: true,
                          fontSize: 10,
                          margin: [0, 2, 0, 5],
                      },

                      {
                          table: {
                              widths: ["30%", "70%"],
                              body: eyeExaminationRows,
                          },

                          layout: {
                              hLineWidth: () => 0.4,
                              vLineWidth: () => 0.4,
                              paddingLeft: () => 5,
                              paddingRight: () => 5,
                              paddingTop: () => 3,
                              paddingBottom: () => 3,
                          },

                          margin: [0, 0, 0, 10],
                      },
                  ]
                : []),

            {
                text: "DIAGNOSIS / CLINICAL IMPRESSION",
                bold: true,
                fontSize: 10,
                margin: [0, 2, 0, 3],
            },

            {
                text: displayValue(visit.diagnosis) || "-",
                lineHeight: 1.2,
                margin: [0, 0, 0, 8],
            },

            ...(visit.treatment
                ? [
                      {
                          text: "TREATMENT / RECOMMENDATION",
                          bold: true,
                          fontSize: 10,
                          margin: [0, 2, 0, 3],
                      },

                      {
                          text: displayValue(visit.treatment),
                          lineHeight: 1.2,
                          margin: [0, 0, 0, 8],
                      },
                  ]
                : []),

            ...(visit.follow_up_date
                ? [
                      {
                          text: [
                              {
                                  text: "Follow-up Date: ",
                                  bold: true,
                              },
                              formatDate(visit.follow_up_date),
                          ],
                          margin: [0, 0, 0, 15],
                      },
                  ]
                : []),

            {
                text: "This certificate is issued upon the request of the patient for whatever lawful purpose it may serve.",
                lineHeight: 1.25,
                margin: [0, 0, 0, 30],
            },

            {
                text: doctorName,
                bold: true,
                alignment: "center",
                margin: [0, 0, 0, 2],
            },

            {
                text: "Ophthalmologist",
                alignment: "center",
            },
        ],
    };

    pdfMake
        .createPdf(
            docDefinition,
            null,
            null,
            vfs
        )
        .getBlob((blob) => {
            const url = URL.createObjectURL(blob);

            printJS({
                printable: url,
                type: "pdf",
                showModal: true,
                modalMessage: "Preparing medical certificate...",

                onPrintDialogClose: () => {
                    setTimeout(() => {
                        URL.revokeObjectURL(url);
                    }, 1000);
                },
            });
        });
};