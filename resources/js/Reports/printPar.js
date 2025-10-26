import axios from 'axios';
import pdfMake from 'pdfmake/build/pdfmake';

const formatToDecimal = (value) => {
    if (value == null) {
      return '';
    }
    return value.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  };

export const printPar = async (transactionid) => {
    
    let parinfo  = await axios.get('api/getParInfo/' + transactionid)

    const tableBody = [];

    let ponumber  = parinfo.data[0].ponumber === null ? '' : parinfo.data[0].ponumber 
    let podate = parinfo.data[0].podate === null ? '' : ' dated ' + parinfo.data[0].podate
    let poinfo = 'PO No.:' + ponumber + '' + podate + '\n' 

    let sinumber  = parinfo.data[0].sinumber === null ? '' : parinfo.data[0].sinumber 
    let sidate = parinfo.data[0].sidate === null ? '' : ' dated ' + parinfo.data[0].sidate
    let siinfo = 'Sales Invoice No.:' + sinumber + '' + sidate + '\n' 

    let position  = parinfo.data[0].position === null ? '' : parinfo.data[0].position + '/'  
    let office =parinfo.data[0].office === null ? '' : parinfo.data[0].office 

    let supplierinfo  = parinfo.data[0].supplier === null ? 'Supplier: \n' :  'Supplier: ' +  parinfo.data[0].supplier + '\n' 
   let tablebodyHeight = 0;
    let rowcount = 0;
  // Loop through the fetched data and add them to the table body
  parinfo.data.forEach((info) => {
    const formattedDate = new Date(info.dateacquired).toLocaleDateString('en-GB', {
    day: '2-digit',
    month: 'short',
    year: 'numeric'
    }).replace(/ /g, ' ');

    tableBody.push([
      { text: info.quantity, alignment: "center",fontSize: 9.5,border: [true,false,true,true]},
      { text: info.unit,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
      { text: info.description,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
      { text: info.propertynumber,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
      { text: formattedDate,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
      { text: formatToDecimal(info.amount),alignment: "center",fontSize: 9.5,border: [true,false,true,true] },

    ]);
    rowcount = rowcount + 1;
  });

    let totalLines = 0;
    const totalHeight = 300;
    const charsPerLine = 25;
    const heightMultiplier = 11;

    const estimateLines = (text) => {
    return text.split('\n').reduce((lines, paragraph) => {
        return lines + Math.ceil(paragraph.length / charsPerLine);
    }, 0);
    };


    tablebodyHeight = 0;
    totalLines = tableBody.reduce((sum, row) => sum + estimateLines(row[2].text),0) + (rowcount);    
  
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
        


    content: [

    {
    text: 'PROPERTY ACKNOWLEDGMENT RECEIPT',
    alignment : "center",
    fontSize: 11,
    bold:true
    },
    {
    text: '   ',
    alignment : "center",
    fontSize: 9.5,
    bold:true
    },
    {
    table: {
        widths: [60, 200],
        body: [
                [
                {
                text: 'Entity name: ',	border: [false, false, false, false],fontSize: 9.5
                }, 

                {
                border: [false, false, false, true],
                 text: 'Philippine Carabao Center',fontSize: 9.5   
                }
                
                ],
                

            ]
        },
    },
    {
    table: {
        widths: [60, 200,65,'auto',80],
        body: [
                [
                {
                text: 'Fund cluster: ',	border: [false, false, false, false],fontSize: 9.5   
                }, 

                {
                border: [false, false, false, true],
                 text: parinfo.data[0].fundcluster,fontSize: 9.5,                      
                },

                {
                border: [false, false, false, false],
                 text: ' ',fontSize: 9.5   
                },
                
                {
                border: [false, false, false, false],
                 text: 'PAR No.',fontSize: 9.5
                 
                },
                
                {
                border: [false, false, false, true],
                 text: parinfo.data[0].parnumber,fontSize: 9.5      
                },
                
                ],
                

            ]
        },
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
            widths: [40,40,136,70,70,76],
        heights: [20,30,20,20,20,20],
        body: [
            [
            {
                text: 'Quantity',border: [true, true, true, true],fontSize: 9.5, alignment: 'center'
            },
            {
                text: 'Unit',border: [true, true, true, true],fontSize: 9.5, alignment: 'center'
            },
            {
                text: 'Description',border: [true, true, true, true],fontSize: 9.5, alignment: 'center'
            },
            {
                text: 'Property Number',border: [true, true, true, true],fontSize: 9.5, alignment: 'center'
            },
            {
                text: 'Date Acquired',border: [true, true, true, true],fontSize: 9.5, alignment: 'center'
            },
            {
                text: 'Amount',	border: [true, true, true, true],fontSize: 9.5, alignment: 'center'
            },
        ] 
        ]
        },

    },

    {
        table: {
        widths:  [40,40,136,70,70,76],
            heights: tablebodyHeight,//[200,200,200,200,200,200], //['*','*','*','*','*','*'],         
        body: tableBody,
        margins: [0,0,0,'auto']
       
        },

    },	
    
    {
        table: {
        widths:  [40,40,136,70,70,76],
        heights: [60,60,60,60,60,60],
        body: [
            [
            {
                text: ' ',border: [true, false, true, true],fontSize: 8.5, alignment: 'center'
            },
            {
                text: ' ',border: [true, false, true, true],fontSize: 8.5, alignment: 'center'
            },
            {   
            text: [
                {text: '***nothing follows***\n ',bold: true,italics: true, border: [false, false, false, false],fontSize: 8.5, alignment: 'center'},
                {text: '\n', border: [false, true, false, false],fontSize: 8.5, alignment: 'left'},
                {text: '\n', border: [false, true, false, false],fontSize: 8.5, alignment: 'left'},
                {text: '\n', border: [false, true, false, false],fontSize: 8.5, alignment: 'left'},
                {text: supplierinfo,italics: true, border: [false, false, false, false],fontSize: 8.5, alignment: 'left'},
                {text: poinfo,italics: true, border: [false, false, false, false],fontSize: 8.5, alignment: 'left'},
                {text: siinfo,italics: true, border: [false, false, false, false],fontSize: 8.5, alignment: 'left'},
                {text: '\n', border: [false, true, false, false],fontSize: 8.5, alignment: 'left'},
                {text: '\n', border: [false, true, false, false],fontSize: 8.5, alignment: 'left'},
                {text: parinfo.data[0].purpose,italics: true,bold: true, border: [false, false, false, false],fontSize: 8.5, alignment: 'left'},
                {text: '\n', border: [false, true, false, false],fontSize: 8.5, alignment: 'left'},
               
                ], 
                border: [false, false, false, true],             
            },
            {
                text: ' ',border: [true, false, true, true],fontSize: 8.5, alignment: 'center'
            },
            {
                text: ' ',border: [true, false, true, true],fontSize: 8.5, alignment: 'center'
            },
            {
                text: ' ',border: [true, false, true, true],fontSize: 8.5, alignment: 'center'
            },
            
        ] 
        ]
        },

    },

    {
        unbreakable: true, // Prevent the content from breaking across pages
        
        stack: [
            {
        table: {
        widths:  [234,234],
        body: [
            [   
                {
                    text: [
                        {text: 'Received by: \n\n\n',bold: true, fontSize: 9.5, alignment: 'left'},
                        {text: parinfo.data[0].assignedto + '\n',bold: true,fontSize: 9.5, alignment: 'center'},
                        {text: '(Signature over Printed Name of End User)\n',fontSize: 9.5, alignment: 'center'},
                        {text: '   \n',fontSize: 8.5, alignment: 'left'},
                        {text: position + office + '\n', fontSize: 9.5, alignment: 'center',decoration: 'underline'},
                        {text: 'Position/Office' + '\n',fontSize: 9.5, alignment: 'center'},
                        {text: parinfo.data[0].datereceived + '\n',fontSize: 9.5, alignment: 'center',decoration: 'underline'},
                        {text: 'Date' + '\n',fontSize: 9.5, alignment: 'center'},

                    ],
                    border: [true, false, true, true], // Add border for the entire text block      
                },

                {
                    text: [
                        {text: 'Issued by: \n\n\n',bold: true, fontSize: 9.5, alignment: 'left'},
                        {text: parinfo.data[0].issuedby + '\n',bold: true,fontSize: 9.5, alignment: 'center'},
                        {text: '(Signature over Printed Name of Supply and/or Property Custodian)\n',fontSize: 9.5, alignment: 'center'},
                        {text: 'Designated Property & Supply Officer' + '\n', fontSize: 9.5, alignment: 'center',decoration: 'underline'},
                        {text: 'Position/Office' + '\n',fontSize: 9.5, alignment: 'center'},
                        {text: parinfo.data[0].dateissued + '\n',fontSize: 9.5, alignment: 'center',decoration: 'underline'},
                        {text: 'Date' + '\n',fontSize: 9.5, alignment: 'center'},

                    ],
                    border: [true, false, true, true], 
                },
                   
                    
        ]
        ]
        },

    },	
        ],
        
    },


    
    
    
],   //END dd

}

  //Printing of PDF
  pdfMake.createPdf(dd).getBlob((blob) => {
    const url = URL.createObjectURL(blob);
    printJS(url); // Ensure printJS is correctly implemented
});
};