import axios from 'axios';
import pdfMake from 'pdfmake/build/pdfmake';
import QRCode from 'qrcode';


export const printPPeTag = async (ppeid) => {
    
    let ppeinfo  = await axios.get('api/getAllPpeInformation/' + ppeid)


    let propertynumber  = ppeinfo.data.propertynumber === null ? '' : ppeinfo.data.propertynumber
    let serialnumber  = ppeinfo.data.serialnumber === null ? '' : ppeinfo.data.serialnumber
    let accountableofficer  = ppeinfo.data.accountableofficer === null ? '' : ppeinfo.data.accountableofficer
    let description  = ppeinfo.data.description === null ? '' : ppeinfo.data.description
    let section  = ppeinfo.data.section === null ? '' : ppeinfo.data.section 
    let dateacquired  = ppeinfo.data.dateacquired === null ? '' : moment(ppeinfo.data.dateacquired).format('MMM DD, YYYY'); 
    
    // Generate the QR code as a base64 image
    const qrCodeDataUrl = await QRCode.toDataURL(ppeid.toString(), {
    width: 28, // You can adjust the size
    margin: 0,
    });

    var dd = {
        pageSize: {
            width: 2 * 72,
            height: 1 * 72
        },
        pageMargins: [10, 0, 10, 0],



//     content: [
//     {
//         table: {
//             widths:  [25, 90],
//             heights: [30, 30],
//             border: [false,false,false,false],
            
//             body: [
//                     [
//                     {
//                             image: qrCodeDataUrl,
//                             width: 23, // Adjust QR code size
//                             height: 23,
//                             alignment: 'center',
//                             margin: [0, 5, 0, 0], // Adjust this to center vertically (optional)
//                             border: [false,false,false,false],
                            
//                     },

            
//                     {
//                     text: [
//                         {text: 'PN: ' + propertynumber + '\n',fontSize: 6,},
//                         {text: 'SN: ' + serialnumber + '\n',fontSize: 6,},
//                         {text: 'Date acquired: ' + dateacquired + '\n',fontSize: 6,},
//                         {text: 'Accounted to: \n',fontSize: 6,},
//                         {text: accountableofficer + '\n',fontSize: 6},
                    
//                     ],
//                     border: [false,false,false,false],
//                     },

                  
              
//                    ]
//                  ]
//             },
//     },

//     {

//     },
//   {text: 'Section: ' +  section,fontSize: 6,},
   
//   {text: description.substring(0, 75) + '...',fontSize: 6,},

 
// ],
content: [
    {
      table: {
        widths: [2 * 72], // Full width for the QR code (adjust accordingly)
        heights: [72], // Height for QR code
        body: [
          [
            {
              image: qrCodeDataUrl,
              width: 50, // Adjust QR code size
              height: 50,
            //   alignment: 'center',
              margin: [30, 5, 0, 0], // Adjust for vertical alignment
              border: [false, false, false, false]
            }
          ]
        ]
      },
      pageBreak: 'after' // This will ensure the second page starts after the QR code
    },
    {
      table: {
        widths: ['*'],
        heights: ['*'],
        body: [
          [
            // {
            //   image: qrCodeDataUrl,
            //   width: 23, 
            //   height: 23,
            //   alignment: 'center',
            //   margin: [0, 5, 0, 0],
            //   border: [false, false, false, false]
            // },
           
          ]


          
        ]
      }
    },

    {
        text: [
          { text: 'Property No.: ' + propertynumber + '\n', fontSize: 6 },
          { text: 'Serial No.: ' + serialnumber + '\n', fontSize: 6 },
          { text: 'Date acquired: ' + dateacquired + '\n', fontSize: 6 },
          { text: 'Accounted to: ' + accountableofficer, fontSize: 6 },
        //   { text: accountableofficer, fontSize: 6 }
        ],
        border: [false, false, false, false]
      },
    { text: 'Section: ' + section, fontSize: 6 },
    { text: description.length > 120 ? description.replace(/\n/g, ' ').substring(0, 120) + '...' : description.replace(/\n/g, ' '), fontSize: 6 }
  ]

//END dd
}
  //Printing of PDF
  pdfMake.createPdf(dd).getBlob((blob) => {
    const url = URL.createObjectURL(blob);
    printJS(url); // Ensure printJS is correctly implemented
});
};