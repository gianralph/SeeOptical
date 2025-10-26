import axios from 'axios';
import pdfMake from 'pdfmake/build/pdfmake';

const formatToDecimal = (value) => {
    if (value == null) {
      return '';
    }
    return value.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  };



  

export const printRpc = async (id,ppetypes) => {


    let content = [];

    let rpcheaders =  await axios.get(`api/loadphysicalcountReportHeaders/` + id);    
    
    let yearofcount = rpcheaders.data['yearofcount'] ?? '';
    let propertyandsupplyofficer = rpcheaders.data['propertyandsupplyofficer'] ?? '';
    let dateofassumption = rpcheaders.data['dateofassumption'] ? moment(rpcheaders.data['dateofassumption']).format('DD MMMM yyyy') : '';

    let entityname = rpcheaders.data['entityname'] ?? '';
    
    
    for (let i = 0; i < ppetypes.length; i++) {
        const tableBody = [];
        let tablebodyHeight;
        let rowcount = 0;
        const totalHeight = 340;
        const charsPerLine = 30;  //change based on column width of description
        const heightMultiplier = 11;
        let totalLines = 0;


        let ptrinfo =  await axios.get(`api/loadphysicalcountReport/` + id, {params: {
            ppetypeid: ppetypes[i].ppetypeid,
        }});    

        ptrinfo.data.forEach((info) => {
    
        tableBody.push([
                { text: info.article,alignment: "center",fontSize: 8.5,border: [true,false,true,true] },
                { text: info.description,alignment: "left",fontSize: 8.5,border: [true,false,true,true] },
                { text: info.propertynumber,alignment: "center",fontSize: 8.5,border: [true,false,true,true] },
                { text: info.unit,alignment: "center",fontSize: 8.5,border: [true,false,true,true] },
                { text: formatToDecimal(info.acquisitionamount),alignment: "center",fontSize: 8.5,border: [true,false,true,true]},
                { text: info.qtypercard,alignment: "center",fontSize: 8.5,border: [true,false,true,true]},
                { text: info.qtypercount,alignment: "center",fontSize: 8.5,border: [true,false,true,true]},
                { text: info.qtyshortage,alignment: "center",fontSize: 8.5,border: [true,false,true,true]},
                { text: info.valueshortage,alignment: "center",fontSize: 8.5,border: [true,false,true,true]},
                { text: info.remarks,alignment: "center",fontSize: 8.5,border: [true,false,true,true]},
        ]);
        rowcount = rowcount + 1;
        });

            // Add page break after each PPE type except the last one
            // if (i < ppetypes.length - 1) {
            //     tableBody.push({ text: '', pageBreak: 'after' });
            // }
    
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

        content.push(

            {
            text: 'REPORT ON THE PHYSICAL COUNT OF PROPERTY, PLANT AND EQUIPMENT',
            alignment : "center",
            fontSize: 11,
            bold:true
            },
            {
                text: ptrinfo.data[0]['ppetype'],
                alignment : "center",
                fontSize: 9.5,
                },
                {
                    text: '(Type of Property, Plant and Equipment)',
                    alignment : "center",
                    fontSize: 9.5,
                },
                {
                        text: 'As at December 31, ' + ptrinfo.data[0]['yearofcount'],
                        alignment : "center",
                        fontSize: 9.5,
                        
                },
                {
                    //filler table
                    table: {
                    widths: ['*'],
                    heights: [5],
                    body: [
                            [
                            {
                            text: '  ',	border: [false, false, false, false],fontSize: 5
                            }, 					
                            ],
                            
                
                        ]
                    },
                
                },
    
    
    
    
            {
            table: {
                widths: [60, 200],
                body: [
                        [
                        {
                        text: 'Fund cluster:',	border: [false, false, false, false],fontSize: 9.5   
                        }, 
            
                        {
                        border: [false, false, false, true],
                        text: '',fontSize: 9.5,                      
                        },
            
                
                        ],
                        
            
                    ]
            },
            },

            {
                table: {
                    widths: ['*'],
                    body: [
                            [
    
                            {text: [
                                {text: 'For which ',fontSize: 9.5 },
                                {text: propertyandsupplyofficer + ' , ',bold: true,italics: true, border: [false, false, false, false],fontSize: 9.5,decoration: 'underline' },
                                {text: ' Designated Property and Supply Officer, ',bold: true,italics: true,border: [false, false, false, false],fontSize: 9.5,decoration: 'underline' },
                                {text: 'of ' + entityname,bold: true,italics: true,border: [false, false, false, false],fontSize: 9.5,decoration: 'underline' },
                                {text: ' is accountable, having assumed such accountability on ',border: [false, false, false, false],fontSize: 9.5 },
                                {text: dateofassumption,bold: true,italics: true,border: [false, false, false, false],fontSize: 9.5,decoration: 'underline' },
                            ],
                            border: [false, false, false, false]
                            },
    
                            ],
                            
                
                        ]
                },
                },

                
                {
                    //filler table
                    table: {
                    widths: ['*'],
                    heights: [3],
                    body: [
                            [
                            {
                            text: '  ',	border: [false, false, false, false],fontSize: 3
                            }, 					
                            ],
                            
                
                        ]
                    },
                
                },

                {
                    table:{
                        widths:  [50,'*',90,50,70,50,50,50,50,80],
                        body: [
                            [
                                {
                                    text: 'ARTICLE',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'DESCRIPTION',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'PROPERTY NUMBER',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'UNIT OF MEASURE',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'UNIT VALUE',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'QUANTITY per PROPERTY CARD',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'QUANTITY per PHYSICAL COUNT',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'SHORTAGE/OVERAGE',colSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'SHORTAGE/OVERAGE',border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'REMARKS',rowSpan: 2,border: [true, true, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                            
                            ],
        
                            [
                                {
                                    text: 'ARTICLE',rowSpan: 2,border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'DESCRIPTION',border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'PROPERTY NUMBER',border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'UNIT OF MEASURE',border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'UNIT VALUE',border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'QUANTITY per PROPERTY CARD ',border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'QUANTITY per PHYSICAL COUNT',border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'Quantity',border: [true, false, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'Value',border: [true, false, true, true],fontSize: 8.5, alignment: 'center', bold: true
                                },
                                {
                                    text: 'REMARKS',border: [true, false, true, false],fontSize: 8.5, alignment: 'center', bold: true
                                },
                            
                            ]
        
                        ]
                    },
                },
                
                {
                    table: {
                    widths:  [50,'*',90,50,70,50,50,50,50,80],
                        // heights: tablebodyHeight,     
                    body: tableBody,
                    margins: [0,0,0,'auto']
                
                    },
                
                },

                
                {
                    unbreakable: true,
                
                    stack: [
                    {
                    table:{
                        widths: ['*','*','*'],
                        body: [
                            [
                                {
                                    text: 'Certified Correct by:',border: [true, false, false, false],fontSize: 9.5, alignment: 'left'
                                },
                                {
                                    text: 'Approved by:',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                },
                                {
                                    text: 'Verified by:',border: [false, false, true, false],fontSize: 9.5, alignment: 'left'
                                },
                            
                            ]            
                        ]
                    },
                    },
        
                    {
                        table:{
                            widths: ['*'],
                            body: [
                                [
                                    {
                                        text: ' ',border: [true, false, true, false],fontSize: 9.5, alignment: 'left'
                                    },
                                
                                ]            
                            ]
                        },
                        },
        
                    {
                        table:{
                            widths: [20,205,20,20,205,20,20,205,'*'],
                            body: [
                                [
                                    {
                                        text: ' ',border: [true, false, false, false],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, false, true],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, false, true],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, false, true],fontSize: 9.5, alignment: 'left'
                                    },
                                    {
                                        text: ' ',border: [false, false, true, false],fontSize: 9.5, alignment: 'left'
                                    },
                                
                                ]            
                            ]
                        },
                        },
        
        
                        {
                            table:{
                                widths: [20,205,20,20,205,20,20,205,'*'],
                                body: [
                                    [
                                        {
                                            text: ' ',border: [true, false, false, false],fontSize: 9.5, alignment: 'left'
                                        },
                                        {
                                            text: 'Signature over Printed Name of Inventory Committee Chair and Members',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                                        },
                                        {
                                            text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                        },
                                        {
                                            text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                        },
                                        {
                                            text: 'Signature over Printed Name of Head of  Agency/Entity or Authorized Representative',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                                        },
                                        {
                                            text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                        },
                                        {
                                            text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'left'
                                        },
                                        {
                                            text: 'Signature over Printed Name of COA Representative',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                                        },
                                        {
                                            text: ' ',border: [false, false, true, false],fontSize: 9.5, alignment: 'left'
                                        },
                                    
                                    ]            
                                ]
                            },
                            },
                    
                
            
                
                
            
                {
                    table:{
                        widths: ['*'],
                        heights: [5],
                        body: [
                            [
                                {
                                    text: ' ',border: [true, false, true, true],fontSize: 2, alignment: 'left'
                                },
                            
                            
                            ]
                        ]
                    },
                },
        
                
                
                
                
                    ]
                },
        
           
                // This will create a page break
                // { text: '', pageBreak: 'after' },
        
   // Add this only if not the last PPE type
   ...(i < ppetypes.length - 1 ? [{ text: '', pageBreak: 'after' }] : [])
            



        );
           
      }


      var dd = {
        pageSize: {
            width: 13 * 72,
            height: 8.5 * 72
        },
        pageMargins: [50, 50, 50, 50], // left, top, right, bottom
        content: content,   // Add content array
        styles: {
            fontawesome: {
                'font': 'FontAwesome',
                'color': "#000000",
                fontSize: 10
            }
        },
    };
    
    // Printing of PDF
    pdfMake.createPdf(dd).getBlob((blob) => {
        const url = URL.createObjectURL(blob);
        printJS(url); // Ensure printJS is correctly implemented
    });



    };
