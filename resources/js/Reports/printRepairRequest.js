import axios from 'axios';
import pdfMake from 'pdfmake/build/pdfmake';
// import pdfFonts from 'pdfmake/build/vfs_fonts';


// pdfMake.vfs = pdfFonts.pdfMake.vfs;

const formatToDecimal = (value) => {
    if (value == null) {
      return '';
    }
    return value.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
  };

export const printRepairRequest = async (transactionid) => {
    
    
    let repairinfo  = await axios.get('api/getRepairInfo/' + transactionid)

    const tableBody = [];
    let itemtype  = repairinfo.data[0].itemtype === null ? '' : repairinfo.data[0].itemtype;
    let serialnumber  = repairinfo.data[0].serialnumber === null ? '' : repairinfo.data[0].serialnumber;
    let acquisitiondate  = repairinfo.data[0].acquisitiondate === null ? '' : moment(repairinfo.data[0].acquisitiondate, 'YYYY-MM-DD').format('DD-MMM-YYYY'); 
    let dateoflastrepair  = repairinfo.data[0].dateoflastrepair === null || repairinfo.data[0].dateoflastrepair === 'false'  ? '' : moment(repairinfo.data[0].dateoflastrepair, 'YYYY-MM-DD').format('DD-MMM-YYYY'); 
    let brandmodel = repairinfo.data[0].brandmodel === null ? '' : repairinfo.data[0].brandmodel;
    let propertynumber = repairinfo.data[0].propertynumber === null ? '' : repairinfo.data[0].propertynumber;
    let acquisitionamount = repairinfo.data[0].acquisitionamount === null ? '' : formatToDecimal(repairinfo.data[0].acquisitionamount);
    let natureoflastrepair = repairinfo.data[0].natureoflastrepair === null ? '' : repairinfo.data[0].natureoflastrepair;
   
    let natureofwork = repairinfo.data[0].natureofwork === null ? '' : repairinfo.data[0].natureofwork;
    let natureandscope = repairinfo.data[0].natureandscope === null ? '' : repairinfo.data[0].natureandscope;
    let partstoreplace= repairinfo.data[0].partstoreplace === null ? '' : repairinfo.data[0].partstoreplace;
    let requisitioningofficer= repairinfo.data[0].requisitioningofficer === null ? '' : repairinfo.data[0].requisitioningofficer; 
    let designation= repairinfo.data[0].designation === null ? '' : repairinfo.data[0].designation;  
    let requestdate= repairinfo.data[0].requestdate === null ? '' : moment(repairinfo.data[0].requestdate, 'YYYY-MM-DD').format('DD-MMM-YYYY'); 
    let approvedby= repairinfo.data[0].approvedby === null ? '' : repairinfo.data[0].approvedby; 


var dd = {
    pageSize: {
        width: 8.5 * 72,
        height: 11 * 72
    },
    pageMargins: [50, 40, 50, 40], // left, top, right, bottom
    


content: [

{
    table: {
        widths: ['*'],
        heights: [20],
        body: [[
            { text: "REQUEST FOR PRE-REPAIR INSPECTION",alignment : "center",fontSize: 14,bold:true,border: [false,false,false,false], },
        ]]
    }
   
},

{
table: {
    widths: ['*'],
    body: [
          [
          {
            text: 'DESCRIPTION OF PROPERTY',alignment : "left",fontSize: 9.5,bold:true, border: [false,false,false,false],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [100,200,'*','*'],
    body: [
          [
          {
            text: 'Type:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: itemtype,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          {
            text: 'Brand/Model:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: brandmodel,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [100,200,'*','*'],
    body: [
          [
          {
            text: 'Serial/Engine No.:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: serialnumber,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          {
            text: 'Property number:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: propertynumber,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [100,200,'*','*'],
    body: [
          [
          {
            text: 'Acquisition Date:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: acquisitiondate,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          {
            text: 'Acquisition Cost:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: acquisitionamount,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [100,200,],
    body: [
          [
          {
            text: 'Date of last repair:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: dateoflastrepair,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },     
          ],
          ]
      },
},

{
table: {
    widths: [100,'*',],
    body: [
          [
          {
            text: 'Nature of last repair:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: natureoflastrepair,alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },     
          ],
          ]
      },
},

{
table: {
    widths: ['*',],
    body: [
          [
          {
            text: '(Attach copy of latest Job Order)',alignment : "left",italics:true,fontSize: 9.5, border: [false,false,false,false],
          },     
          ],
          ]
      },
},

{
table: {
    widths: ['*',],
    body: [
          [
          {
            text: 'Nature and scope of work to be done:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          ],
          ]
      },
},

{
table: {
    widths: ['*',],
    heights: [30],
    body: [
          [
          {
            text: natureofwork + ' - '+ natureandscope ,alignment : "left",fontSize: 9.5, border: [true,true,true,true],
          },
          ],
          ]
      },
},

{
table: {
    widths: ['*',],
    body: [
          [
          {
            text: 'Parts to be replaced/supplied:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          ],
          ]
      },
},

{
table: {
    widths: ['*',],
    heights: [30],
    body: [
          [
          {
            text: partstoreplace,alignment : "left",fontSize: 9.5, border: [true,true,true,true],
          },
          ],
          ]
      },
},



{

          table:{
            widths: ['*', '*'],
            body: [
                  [
                    { 
                    text: 'Requested by: \n\n', fontSize: 9.5, alignment: 'left',border: [false,false,false,false]
                    },
                    { 
                    text: 'Recommending Approval: \n\n', fontSize: 9.5, alignment: 'left',border: [false,false,false,false]
                    },
                  ]
                  ]
          },
},
          
        {
          table:{
            widths: [20, '*',20, 20,'*', 20],
            body: [
                  [
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: requisitioningofficer, bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,true]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: approvedby, bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,true]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                  ]
                  ]
          }
        },

        {
          table:{
            widths: [20, '*',20, 20,'*', 20],
            body: [
                  [
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: 'Requisitioning Officer', fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: 'Designated Property & Supply Officer', fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                  ]
                  ]
          }
        },

        {
          table:{
            widths: [20, '*',20, 20,'*', 20],
            body: [
                  [
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: designation, bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,true]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: ' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,true]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                  ]
                  ]
          }
        },

        {
          table:{
            widths: [20, '*',20, 20,'*', 20],
            body: [
                  [
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: 'Designation', fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: 'Date', fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                  ]
                  ]
          }
        },

        {
          table:{
            widths: [20, '*',20, 20,'*', 20],
            body: [
                  [
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: requestdate, bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,true]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: '', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                  ]
                  ]
          }
        },

        {
          table:{
            widths: [20, '*',20, 20,'*', 20],
            heights: [25],
            body: [
                  [
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: 'Date', fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text: '', fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                    { 
                    text:' ', bold: true, fontSize: 9.5, alignment: 'center',border: [false,false,false,false]
                    },
                  ]
                  ]
          }
        },

        {
            canvas: [
                {
                    type: 'line',
                    x1: 0, y1: 0,
                    x2: 512, y2: 0,  // Adjust x2 to control the length of the line (515 is full width with margins)
                    lineWidth: 1.5,
                    dash: { length: 5, space: 5 }  // This creates a dashed line with 5 units of length and 5 units of space
                }
            ],
            margin: [0, 0, 0, 0] // Left, Top, Right, Bottom margins to center the line horizontally
        },

        {
    table: {
        widths: ['*'],
        heights: [5],
        body: [[
            { text: " ",alignment : "center",fontSize: 3,bold:true,border: [false,false,false,false], },
        ]]
    }
   
},

{
    table: {
        widths: ['*'],

        body: [[
            { text: "POST REPAIR INSPECTION",alignment : "center",fontSize: 14,bold:true,border: [false,false,false,false], },
        ]]
    }
   
},

{
table: {
    widths: ['*'],
    body: [
          [
          {
            text: 'POST REPAIR:',alignment : "left",fontSize: 9.5,bold:true, border: [false,false,false,false],
          },
          
         
          ],
          ]
      },
},


{
table: {
    widths: [30,80,'*',30,80,'*'],
    body: [
          [
          {
            text: ' ' ,alignment : "left",fontSize: 9.5, border: [false,false,false,false  ],
          },
          {
            text: 'Job Order No.:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,true],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: 'Date:',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,true],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [30,80,'*',30,80,'*'],
    body: [
          [
          {
            text: ' ' ,alignment : "left",fontSize: 9.5, border: [false,false,false,false  ],
          },
          {
            text: 'Invoice No.:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,true],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: 'Date:',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,true],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [30,80,'*',30,80,'*'],
    body: [
          [
          {
            text: ' ' ,alignment : "left",fontSize: 9.5, border: [false,false,false,false  ],
          },
          {
            text: 'Amount/Job Order:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,true],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: 'Payable amount:',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,true],
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
          {
            text: 'Findings:',alignment : "left",fontSize: 9.5,bold:true, border: [false,false,false,false],
          },
          
          ],
          ]
      },
},

{
table: {
    widths: ['*',],
    heights: [50],
    body: [
          [
          {
            text: '',alignment : "left",fontSize: 9.5, border: [true,true,true,true],
          },
          ],
          ]
      },
},


{
table: {
    widths: ['*','*'],
    heights: [30],
    body: [
          [
          {
            text: 'Inspected by:',alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          
          ],
          ]
      },
},


{
table: {
    widths: [30,200,10,30,80,'*'],
    body: [
          [
          {
            text: ' ' ,alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: '',alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: 'Noted:',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [30,200,10,30,80,'*'],
    body: [
          [
          {
            text: ' ' ,alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: 'Property Inspector',alignment : "center",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          
         
          ],
          ]
      },
},

{
table: {
    widths: [30,200,10,30,200,'*'],
    body: [
          [
          {
            text: ' ' ,alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: '',alignment : "left",fontSize: 9.5, border: [false,false,false,true],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: '',alignment : "left",fontSize: 9.5,border: [false,false,false,true],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          
         
          ],
          ]
      },
},


{
table: {
    widths: [30,200,10,30,200,'*'],
    body: [
          [
          {
            text: ' ' ,alignment : "left",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: 'Date',alignment : "center",fontSize: 9.5, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: 'Resident Auditor',alignment : "center",fontSize: 9.5,border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 9.5,border: [false,false,false,false],
          },
          
         
          ],
          ]
      },
},


],   //END content
}

  //Printing of PDF
  pdfMake.createPdf(dd).getBlob((blob) => {
    const url = URL.createObjectURL(blob);
    printJS(url); // Ensure printJS is correctly implemented
});
};