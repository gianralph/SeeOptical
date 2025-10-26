    import axios from 'axios';
    import moment from 'moment';

    import pdfMake from 'pdfmake/build/pdfmake';
    // import pdfFonts from 'pdfmake/build/vfs_fonts';
    
    // pdfMake.vfs = pdfFonts.pdfMake.vfs;


    const loadImageAsBase64 = (url) => {
        return new Promise((resolve, reject) => {
        const image = new Image();
        image.crossOrigin = 'Anonymous';
        image.onload = () => {
        const canvas = document.createElement('canvas');
        canvas.width = image.width;
        canvas.height = image.height;
        const ctx = canvas.getContext('2d');
        ctx.drawImage(image, 0, 0);
        const dataURL = canvas.toDataURL('image/png');
        resolve(dataURL);
        };
        image.onerror = () => {
        reject(new Error('Failed to load image'));
        };
        image.src = url;
    });
    
    };  

                
    export const printReturnReceipt = async (transactionid) => {

        const pccdalogo  = await loadImageAsBase64('/assets/images/logo.png');
        let returninfo  = await axios.get('api/getreturnreceipt/' + transactionid)

        const tableBody = [];

        let division  = returninfo.data[0].division === null ? '' : returninfo.data[0].division 
        let section  = returninfo.data[0].section === null ? '' : returninfo.data[0].section 
        let responsibilitycode  = returninfo.data[0].responsibilitycode === null ? '' : returninfo.data[0].responsibilitycode

        let returnedby  = returninfo.data[0].returnedby === null ? '' : returninfo.data[0].returnedby
        let returndate  = returninfo.data[0].returndate     === null ? '' : moment(returninfo.data[0].returndate).format('DD-MMM-YYYY'); 
        let receivedby  = returninfo.data[0].receivedby === null ? '' : returninfo.data[0].receivedby


        let rowcount = 0;

        // Loop through the fetched data and add them to the table body
        returninfo.data.forEach((info) => {
        tableBody.push([
        { text: info.description, alignment: "center",fontSize: 9.5,border: [true,false,true,true]},
        { text: info.unitofmeasurement,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
        { text: info.quantity,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
        { text: info.propertynumber,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
        { text: info.condition,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
        { text: info.remarks,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },

        ]);
        rowcount = rowcount + 1;
        });


        const totalHeight = 340;
        const charsPerLine = 28;  //change based on column width of description
        const heightMultiplier = 11;
        let tablebodyHeight = 0;
        let totalLines = 0;


        const estimateLines = (text) => {
            return text.split('\n').reduce((lines, paragraph) => {
                return lines + Math.ceil(paragraph.length / charsPerLine);
            }, 0);
            };


        tablebodyHeight = 0;
        totalLines = tableBody.reduce((sum, row) => sum + estimateLines(row[0].text),0) + (rowcount);    
        
        if (totalLines*heightMultiplier <= totalHeight) {
            tablebodyHeight = totalHeight/rowcount;
        }else{
            tablebodyHeight = 0;
        }


    var dd = {
        pageSize: {
            width: 8.5 * 72,
            height: 11 * 72
        },
        pageMargins: [50, 50, 50, 50], // left, top, right, bottom
        // defaultStyle: {
        //     font: 'Cambria'  // Use the font included in VFS
        // },


    content: [
        {
            image: pccdalogo,
            width: 50,
            height: 50,
            absolutePosition: { x: 160, y: 55 }
        },
    {
    table: {
        widths: ['*'],
        heights: [50],
        body: [
            [
                // { image: pccdalogo.value, width: 50, height: 50, alignment: 'right',border: [true,true,true,true], },
                {
                    text: [
                        {text: 'PHILIPPINE CARABAO CENTER\n',alignment : "center",fontSize: 11,bold:true},
                        {text: 'RETURN RECEIPT',alignment : "center",fontSize: 11},
                    ],
                    margin: [0, 15, 0, 0],
                }
            
            ],
            ]
        },
    },


    {
    table: {
        widths: [40,146,5,198,'*',],
    body: [
    [
    {
    text: 'Division: ',fontSize: 9.5,border: [true, false, false, false],bold: true
    }, 
    {
    text: division,fontSize: 9.5,border: [false, false, false, true],bold: true
    },
    {
    text: ' ',fontSize: 9.5,border: [false, false, true, false],
    },
    {
    text: 'Responsibility Center Code',fontSize: 9.5,border: [false, false, true, false],alignment: 'center',bold: true
    },
    {
    text: ' ',fontSize: 9.5,border: [false, false, true, false],
    },
    
    ],
    

    ]
    },
    },

    {
    table: {
        widths: [40,146,5,198,'*',],
    body: [
    [
    {
    text: 'Office: ',fontSize: 9.5,border: [true, false, false, false],bold: true
    }, 
    {
    text: section,fontSize: 9.5,border: [false, false, false, true],bold: true
    },
    {
    text: ' ',fontSize: 9.5,border: [false, false, true, false],
    },
    {
    text: responsibilitycode,fontSize: 9.5,border: [false, false, true, true],bold: true,alignment: 'center'
    },
    {
    text: ' ',fontSize: 9.5,border: [false, false, true, false],
    },
    
    ],
    ]
    },
    },

    {
    table: {
        widths: [40,146,5,198,'*',],
    body: [
    [
    {
    text: ' ',fontSize: 6,border: [true, false, false, false]
    }, 
    {
    text: ' ',fontSize: 6,border: [false, false, false, false],
    },
    {
    text: ' ',fontSize: 6,border: [false, false, true, false],
    },
    {
    text: '',fontSize: 6,border: [false, false, true, false],
    },
    {
    text: ' ',fontSize: 6,border: [false, false, true, false],
    },
    
    ],
    

    ]
    },
    },

    {
        table: {
            widths: [150,50,50,90,40,'*'],
        heights: [20,30,20,20,20,20],
        body: [
            [
            {
                text: 'DESCRIPTION',border: [true, true, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'UNIT OF MEASURE',border: [true, true, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'QUANTITY',border: [true, true, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'PROPERTY/STOCK NO.',border: [true, true, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'STATUS*',border: [true, true, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'REMARKS',	border: [true, true, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
        ] 
        ]
    },

    },

    {
        table: {
        widths:  [150,50,50,90,40,'*'],
            heights: tablebodyHeight,
        body: tableBody,
        margins: [0,0,0,'auto'],
        
    
    },

    },	

    {
        table: {
            widths: ['*'],
            
        body: [
            [
            {
            text: [
                {text: '*Legend: Property Status: S - ', alignment: 'left',bold: true},
                {text: 'Servicable', alignment: 'left',italics: true},
                {text: ' US - ', alignment: 'left',bold: true},
                {text: 'Unservicable\n', alignment: 'left',italics: true},
                    ],
                    fontSize: 9.5,
                    border: [true,false,true,true],
            },
        ] 
        ]
    },

    },

    {
        table: {
            widths: [30,'*'],

        body: [
            [
            {text: '',fontSize: 9.5, alignment: 'left',bold: true,border: [true, false, false, true]}
            ,
            {
            text: [
                {text: '     Supplies Status: U - ', alignment: 'left',bold: true},
                {text: 'Used Supplies', alignment: 'left',italics: true},
                {text: ' E - ', alignment: 'left',bold: true},
                {text: 'Excess/Unused Supplies', alignment: 'left',italics: true},
                {text: ' WM - ',alignment: 'left',bold: true},
                {text: 'Waste Materials', alignment: 'left',italics: true},
                    ],
                    fontSize: 9.5,
                    border: [false, false, true, true]
            }
        ] 
        ]
    },

    },

    {
        unbreakable: true, // Prevent the content from breaking across pages

    stack: [
        {
        table: {
            widths: [267, '*'],
            body: [
            [
                {
                text: [
                    { text: 'Returned by: \n\n\n', bold: true, fontSize: 9.5, alignment: 'left' },
                    { text: returnedby + '\n', bold: true, fontSize: 9.5, alignment: 'center' },
                    { text: 'CMT II' + '\n', fontSize: 9.5, alignment: 'center', italics: true },
                    { text: returndate + '\n', fontSize: 9.5, alignment: 'center', decoration: 'underline' },
                    { text: 'Date' + '\n', fontSize: 9.5, alignment: 'center' },
                ],
                border: [true, false, true, true], // Add border for the entire text block      
                },
                {
                text: [
                    { text: 'Received by: \n\n\n', bold: true, fontSize: 9.5, alignment: 'left' },
                    { text: receivedby + '\n', bold: true, fontSize: 9.5, alignment: 'center' },
                    { text: 'Property and Supply Officer' + '\n', fontSize: 9.5, alignment: 'center', italics: true },
                    { text: returndate + '\n', fontSize: 9.5, alignment: 'center', decoration: 'underline' },
                    { text: 'Date', fontSize: 9.5, alignment: 'center' },
                ],
                border: [true, false, true, true], // Add border for the entire text block
                },
            ],
            ],
        },



        
        },

        {
        table: {
            widths: ['*'],
            
        body: [
            [
            
                {text: ' ',fontSize: 3, border: [false,false, false, false], },    
        ] 
        ]
    },

    },

    {
        table: {
            widths: ['*','*','*'],
            
        body: [
            [
            {
                text: [
                    {text: 'Form No:', alignment: 'left',fontSize: 8},
                    {text: '  PCC-PPIF-35', alignment: 'left',fontSize: 8,bold: true,},
                ],
                border: [true, true, true, true],
            },
                


                {text: 'Rev. No: 01', alignment: 'left',fontSize: 8, border: [true, true, true, true],},
                {text: 'Effectivity Date: June 16, 2022',fontSize: 8, alignment: 'left', border: [true, true, true, true],},
        
        ] 
        ]
    },

    },

        
    ],
    },
    ],   //END content
    }


    //Printing of PDF
    pdfMake.createPdf(dd).getBlob((blob) => {
        const url = URL.createObjectURL(blob);
        printJS(url); // Ensure printJS is correctly implemented
    });
};