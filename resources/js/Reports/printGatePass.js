import axios from 'axios';
import pdfMake from 'pdfmake/build/pdfmake';
// import pdfFonts from 'pdfmake/build/vfs_fonts';
import {ref} from 'vue';

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



export const printGatePass = async (transactionid) => {
    
    const gatepassheader = ref();
    const gatepassfooter = ref();

    let gatepassinfo  = await axios.get('api/getGatePass/' + transactionid)

    const tableBody = [];
    gatepassheader.value = await loadImageAsBase64('/assets/images/gatepassheader.png');
    gatepassfooter.value = await loadImageAsBase64('/assets/images/gatepassfooter.png');

    let dateofgatepass  = gatepassinfo.data[0].dateofgatepass === null ? '' : moment(gatepassinfo.data[0].dateofgatepass, 'YYYY-MM-DD').format('DD-MMM-YYYY'); 
    let itemname  = gatepassinfo.data[0].itemname === null ? '' : gatepassinfo.data[0].itemname;
    let currentlyassignedto  = gatepassinfo.data[0].currentlyassignedto === null ? '' : gatepassinfo.data[0].currentlyassignedto;
    let requestedby  = gatepassinfo.data[0].requestedby === null ? '' : gatepassinfo.data[0].requestedby;
    let dateofexpectedreturn  = gatepassinfo.data[0].dateofexpectedreturn === null ? '' : moment(gatepassinfo.data[0].dateofexpectedreturn).format('DD-MMM-YYYY'); 
    let notedby  = gatepassinfo.data[0].notedby === null ? '' : gatepassinfo.data[0].notedby;

var dd = {
    pageSize: {
        width: 8.5 * 72,
        height: 11 * 72
    },
    pageMargins: [50, 100, 50, 50], // left, top, right, bottom
    


content: [
    {
          image: gatepassheader.value,
           width: 550,  // Adjust the size as needed
           height: 110,
          absolutePosition: { x: 0, y: 0 }  // Adjust x and y coordinates for positioning
        },
        {
          image: gatepassfooter.value,
           width: 600,  // Adjust the size as needed
           height: 100,
           absolutePosition: {
            x: 612 - 600, // Page width (612) minus image width (250)
            y: 792 - 100  // Page height (792) minus image height (100)
  }  // Adjust x and y coordinates for positioning
        },

{
    table: {
        widths: ['*'],
        heights: [30],
        body: [[
            { text: "GATE PASS",alignment : "center",fontSize: 14,bold:true,border: [false,false,false,false], },
        ]]
    }
   
},


{
table: {
    widths: [30,150,'*',30],
    body: [
          [
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'DATE:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: dateofgatepass,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'ITEM:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: itemname,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: ['*'],
    height: [50],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },     
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'ACCOUNTABLE PERSON:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: currentlyassignedto,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},


{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'REQUESTED BY:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: requestedby,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'EXPECTED DATE OF RETURN:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: dateofexpectedreturn,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: ['*'],
    height: [50],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },     
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'NOTED BY:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: notedby,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'Designated Property & Supply Officer',alignment : "left",fontSize: 11, border: [false,false,false,false],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: ['*'],
    height: [30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 5,bold:true, border: [false,false,false,false],
          },     
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'CHECKED BY:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: '',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'PCC GUARD ON DUTY',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11, border: [false,false,false,false],
          },       
          ],
          ]
      },
},


{
table: {
    widths: [30,'*'],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,italics:true, border: [false,false,false,false],
          },    
          {
            text: 'Not valid without accountable person’s signature',alignment : "left",fontSize: 11,italics:true, border: [false,false,false,false],
          },    
          ],
          ]
      },
},


{
            canvas: [
                {
                    type: 'line',
                    x1: 0, y1: 0,
                    x2: 512, y2: 0,  // Adjust x2 to control the length of the line (515 is full width with margins)
                    lineWidth: 1.5,
                    
                }
            ],
            margin: [0, 0, 0, 0] // Left, Top, Right, Bottom margins to center the line horizontally
        },

// {
// table: {
//     widths: ['*'],
//     body: [
//           [
//             {
//             text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,true,false,false],
//           },   
//           ],
//           ]
//       },
// },

{
    table: {
        widths: ['*'],
        heights: [30],
        body: [[
            { text: " ",alignment : "center",fontSize: 14,bold:true,border: [false,false,false,false], },
        ]]
    }
   
},

{
    table: {
        widths: ['*'],
        heights: [30],
        body: [[
            { text: "GATE PASS",alignment : "center",fontSize: 14,bold:true,border: [false,false,false,false], },
        ]]
    }
   
},


{
table: {
    widths: [30,150,'*',30],
    body: [
          [
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'DATE:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: dateofgatepass,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'ITEM:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: itemname,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: ['*'],
    height: [50],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },     
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'ACCOUNTABLE PERSON:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: currentlyassignedto,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},


{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'REQUESTED BY:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: requestedby,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'EXPECTED DATE OF RETURN:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: dateofexpectedreturn,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: ['*'],
    height: [50],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },     
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'NOTED BY:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: notedby,alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'Designated Property & Supply Officer',alignment : "left",fontSize: 11, border: [false,false,false,false],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: ['*'],
    height: [30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 5,bold:true, border: [false,false,false,false],
          },     
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'CHECKED BY:',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: '',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,true],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },       
          ],
          ]
      },
},

{
table: {
    widths: [30,150,'*',30],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: ' ',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          },
          {
            text: 'PCC GUARD ON DUTY',alignment : "left",fontSize: 11,bold:true, border: [false,false,false,false],
          }, 
          {
            text: ' ',alignment : "left",fontSize: 11, border: [false,false,false,false],
          },       
          ],
          ]
      },
},


{
table: {
    widths: [30,'*'],
    body: [
          [
            {
            text: ' ',alignment : "left",fontSize: 11,italics:true, border: [false,false,false,false],
          },    
          {
            text: 'Not valid without accountable person’s signature',alignment : "left",fontSize: 11,italics:true, border: [false,false,false,false],
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
