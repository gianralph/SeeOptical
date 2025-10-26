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

  const check = (result) => {
    return result ? {
        text: "☑",
        style: 'fontawesome'
    } : {
        text: "◻",
        style: 'fontawesome'
    };
};


export const printPtr = async (transactionid) => {

    let ptrinfo  = await axios.get('api/getPtrInfo/' + transactionid)
    
    let fundcluster  = ptrinfo.data[0].fundcluster === null ? '' : ptrinfo.data[0].fundcluster 
    let oldaccountableofficer  = ptrinfo.data[0].oldaccountableofficer === null ? '' : ptrinfo.data[0].oldaccountableofficer 
    let newaccountableofficer  = ptrinfo.data[0].newaccountableofficer === null ? '' : ptrinfo.data[0].newaccountableofficer 
    var receivedbydesignation= ptrinfo.data[0].receivedbydesignation === null ? '' : ptrinfo.data[0].receivedbydesignation 
    let datereceived= ptrinfo.data[0].datereceived === null ? '' : ptrinfo.data[0].datereceived 
    let ptrnumber= ptrinfo.data[0].ptrnumber === null ? '' : ptrinfo.data[0].ptrnumber 
    let dateissued  = ptrinfo.data[0].dateissued === null ? '' : moment(ptrinfo.data[0].dateissued).format('DD-MMM-YYYY')
    let reasonfortransfer  = ptrinfo.data[0].reasonfortransfer === null ? '' : ptrinfo.data[0].reasonfortransfer 
    let approvedby  = ptrinfo.data[0].approvedby === null ? '' : ptrinfo.data[0].approvedby
    let issuedby= ptrinfo.data[0].issuedby === null ? '' : ptrinfo.data[0].issuedby 
    let approvedbydesignation= ptrinfo.data[0].approvedbydesignation === null ? '' : ptrinfo.data[0].approvedbydesignation 
    let issuedbydesignation= ptrinfo.data[0].issuedbydesignation === null ? '' : ptrinfo.data[0].issuedbydesignation 
    let dateapproved= ptrinfo.data[0].dateapproved === null ? '' : ptrinfo.data[0].dateapproved 
    
    
    let rowcount = 0;
    //let tablebodyHeight = 0;
    
    
    const tableBody = [];
    
    
    ptrinfo.data.forEach((info) => {
        const dateacquired = new Date(info.dateacquired).toLocaleDateString('en-GB', {
        day: '2-digit',
        month: 'short',
        year: 'numeric'
        }).replace(/ /g, ' ');
    
        tableBody.push([
        { text: dateacquired,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
        { text: info.propertynumber, alignment: "center",fontSize: 9.5,border: [true,false,true,true]},
        { text: info.description,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
        { text: formatToDecimal(info.amount),alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
        { text: info.condition,alignment: "center",fontSize: 9.5,border: [true,false,true,true] },
      
        ]);
        rowcount = rowcount + 1;
    });
    
    
    const totalHeight = 340;
        const charsPerLine = 30;  //change based on column width of description
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
        
    
    
    content: [
    
    {
    text: 'PROPERTY TRANSFER REPORT',
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
        widths: [60, 200,65,'auto',80],
        body: [
                [
                {
                text: 'Entity name: ',	border: [false, false, false, false],fontSize: 9.5   
                }, 
    
                {
                border: [false, false, false, true],
                 text: 'Philippine Carabao Center',fontSize: 9.5,                      
                },
    
                {
                border: [false, false, false, false],
                 text: ' ',fontSize: 9.5   
                },
                
                {
                border: [false, false, false, false],
                 text: 'Fund cluster:',fontSize: 9.5
                 
                },
                
                {
                border: [false, false, false, true],
                 text: fundcluster,fontSize: 9.5      
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
        table:{
            widths: [380,'*'],
            heights: ['*','*'],
            body: [
                [
                    {
                        text:[
                            {text: 'From Accountable Officer/Agency/Fund Cluster: ',fontSize: 9.5, alignment: 'left'},
                            {text: oldaccountableofficer,fontSize: 9.5, alignment: 'left',decoration: 'underline'}
                        ],
                        border: [true, true, false, false]
                    },
                    {
                        text: [
                            {text: 'PTR No.: ',fontSize: 9.5, alignment: 'left'},
                            {text: ptrnumber,fontSize: 9.5, alignment: 'left',decoration: 'underline'}
                        ],
                        border: [true, true, true, false]
    
                    },
                ]
            ]
        },
    },
    
    {
        table:{
            widths: [380,'*'],
            heights: ['*','*'],
            body: [
                [
                    {
                        text: [
                            {text: 'To Accountable Officer/Agency/Fund Cluster: ',border: [true, false, false, false],fontSize: 9.5, alignment: 'left'},
                            {text: newaccountableofficer,border: [false, false, true, false],fontSize: 9.5, alignment: 'left',decoration: 'underline'}
                        ],
                        border: [true, false, false, false]                    
                    },
                    
                    {
                        text: [
                            {text: 'Date: ',border: [true, false, false, false],fontSize: 9.5, alignment: 'left'},
                            {text: dateissued,border: [false, false, true, false],fontSize: 9.5, alignment: 'left',decoration: 'underline'}
                        ],
                        border: [true, false, true, false]
                    },
                    
                ]
            ]
        },
    },
    
    {
        table:{
            widths: [380,'*'],
            heights: ['*','*'],
            body: [
                [
                    {
                        text: '',border: [true, false, true, true],fontSize: 2, alignment: 'left'
                    },
                    {
                        text: '',border: [false, false, true, true],fontSize: 2, alignment: 'left'
                    },
                  
                ]
            ]
        },
    },
    
    {
        table:{
            widths: ['*'],
            heights: ['*'],
            body: [
                [
                    {
                        text: 'Transfer Type: (check only one)',border: [true, false, true, false],fontSize: 9.5, alignment: 'left'
                    },
                   
                ]
            ]
        },
    },
    
    {
        table:{
            widths: [50,80,'*'],
            heights: ['*','*','*'],
            body: [
                [
                    {
                         text: '   ',border: [true, false, false, true],fontSize: 9.5, alignment: 'left' 
                    },
                    {
                        text : [
                        check(false),
                        {text: ' Donation\n',border: [true, false, true, true],fontSize: 9.5, alignment: 'left'},
                        check(true),
                        {text: ' Reassignment',border: [true, false, true, true],fontSize: 9.5, alignment: 'left'}
                        ],
                        border: [false, false, false, true],
                    },
                    {
                        text : [
                        check(false),
                        {text:  ' Relocate\n',border: [true, false, true, true],fontSize: 9.5, alignment: 'left'},
                        check(false),
                        {text: ' Others (Specify) _______________',border: [true, false, true, true],fontSize: 9.5, alignment: 'left'}
                        ],
                        border: [false, false, true, true],
                    },
                  
                   
                ]
            ]
        },
    },
    
    
    {
        table: {
            widths: [60,90,170,70,'*'],
        heights: [20,20,20,20,20],
        body: [
            [
            {
                text: 'Date Acquired',border: [true, false, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'Property No.',border: [true, false, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'Description',border: [true, false, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'Amount',border: [true, false, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
            {
                text: 'Condition of PPE',border: [true, false, true, true],fontSize: 9.5, alignment: 'center',bold: true
            },
        ] 
        ]
        },
    
    },
    
    {
        table: {
        widths:  [60,90,170,70,'*'],
            heights: tablebodyHeight,     
        body: tableBody,
        margins: [0,0,0,'auto']
       
        },
    
     },	
    
     {
        table:{
            widths: ['*'],
            body: [
                [
                    {
                        text: 'Reason for Transfer:',border: [true, false, true, true],fontSize: 9.5, alignment: 'left',bold: true
                    },
                   
                ]
            ]
        },
    },
    
    {
        table:{
            widths: ['*'],
            heights: [20],
            body: [
                [
                    {
                        text: reasonfortransfer,border: [true, false, true, true],fontSize: 9.5, alignment: 'left'
                    },
                   
                ]
            ]
        },
    },
    
    
    {
        unbreakable: true,
    
        stack: [
            {
        table:{
            widths: [65,'*','*','*'],
            body: [
                [
                    {
                        text: '',border: [true, false, false, false ],fontSize: 9.5, alignment: 'left'
                    },
                    {
                        text: 'Approved by:',border: [false, false, false, false],fontSize: 9.5, alignment: 'left',bold:true
                    },
                    {
                        text: 'Released/Issued by',border: [false, false, false, false],fontSize: 9.5, alignment: 'left',bold:true
                    },
                    {
                        text: 'Received by',border: [false, false, true, false],fontSize: 9.5, alignment: 'left',bold:true
                    },
                   
                ]
            ]
        },
        },
        {
        table:{
            widths: [65,'*',5,'*',5,'*'],
            body: [
                [
                    {
                        text: 'Signature:',border: [true, false, false, false],fontSize: 9.5, alignment: 'left',bold:true
                    },
                    {
                        text: ' ',border: [false, false, false, true],fontSize: 9.5, alignment: 'left'
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
                        text: ' ',border: [false, false, true, true],fontSize: 9.5, alignment: 'left'
                    },
                   
                ]
            ]
        },
        },
    
        {
        table:{
            widths: [65,127,5,127,5,'*'],
            body: [
                [
                    {
                        text: 'Printed Name:',border: [true, false, false, false],fontSize: 9.5, alignment: 'left',bold:true
                    },
                    {
                        text: approvedby,border: [false, false, false, true],fontSize: approvedby.length <= 24 ? 9.5 : 8, alignment: 'center'
                    },
                    {
                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: issuedby,border: [false, false, false, true],fontSize: issuedby.length <= 24 ? 9.5 : 8, alignment: 'center'
                    },
                    {
                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: newaccountableofficer,border: [false, false, true, true],fontSize: newaccountableofficer.length <= 24 ? 9.5 : 8, alignment: 'center'
                    },
                   
                ]
            ]
        },
    },
    
    
    {
        table:{
            widths: [65,'*',5,'*',5,'*'],
            body: [
                [
                    {
                        text: 'Designation:',border: [true, false, false, false],fontSize: 9.5, alignment: 'left',bold:true
                    },
                    {
                        text: approvedbydesignation,border: [false, false, false, true],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: issuedbydesignation,border: [false, false, false, true],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: receivedbydesignation,border: [false, false, true, true],fontSize: 9.5, alignment: 'center'
                    },
                   
                ]
            ]
        },
    },	
    
    
    {
        table:{
            widths: [65,'*',5,'*',5,'*'],
            body: [
                [
                    {
                        text: 'Date:',border: [true, false, false, false],fontSize: 9.5, alignment: 'left',bold:true
                    },
                    {
                        text: moment(dateapproved, 'YYYY-MM-DD').format('DD-MMM-YYYY'),border: [false, false, false, true],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: moment(dateapproved, 'YYYY-MM-DD').format('DD-MMM-YYYY'),border: [false, false, false, true],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: ' ',border: [false, false, false, false],fontSize: 9.5, alignment: 'center'
                    },
                    {
                        text: moment(dateapproved, 'YYYY-MM-DD').format('DD-MMM-YYYY'),border: [false, false, true, true],fontSize: 9.5, alignment: 'center'
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
        
    ],   //END dd
    
    styles: {
                        fontawesome: {
                            'font': 'FontAwesome',
                            'color': "#000000",
                            fontSize: 10
                        }
                    },
    }
    
   //Printing of PDF
   pdfMake.createPdf(dd).getBlob((blob) => {
    const url = URL.createObjectURL(blob);
    printJS(url); // Ensure printJS is correctly implemented
});
};