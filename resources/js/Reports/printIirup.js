import axios from 'axios';
import numeral from 'numeral';
import pdfMake from 'pdfmake/build/pdfmake';

const formatToDecimal = (value) => {
    if (value == null) {
      return '';
    }
    return numeral(value).format('0,0.00');
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


export const printIirup = async (id) => {

        let content = [];

        const tableBody = [];
        let rowcount = 0;

    const formatNumber = (value) => {
      return numeral(value).format('0,0.00');
    };

        let iirupinfo =  await axios.get(`api/getIirupInfoForReport/` + id);    

        let entityname  = iirupinfo.data[0]['entityname'] === null ? '' : iirupinfo.data[0]['entityname'];
        let fundcluster  = iirupinfo.data[0]['fundcluster'] === null ? '' : iirupinfo.data[0]['fundcluster'];
        let accountableofficer  = iirupinfo.data[0]['accountableofficer'] === null ? '' : iirupinfo.data[0]['accountableofficer'];  
        let designation  = iirupinfo.data[0]['designation'] === null ? '' : iirupinfo.data[0]['designation'];  
        let section  = iirupinfo.data[0]['section'] === null ? '' : iirupinfo.data[0]['section'];  
        let approvedby  = iirupinfo.data[0]['aprrovedby'] === null ? '' : iirupinfo.data[0]['aprrovedby'];  
        let approverdesignation  = iirupinfo.data[0]['approverdesignation'] === null ? '' : iirupinfo.data[0]['approverdesignation'];  
        let witness  = iirupinfo.data[0]['witness'] === null ? '' : iirupinfo.data[0]['witness'];  
        let inspectionofficer  = iirupinfo.data[0]['inspectionofficer'] === null ? '' : iirupinfo.data[0]['inspectionofficer'];          




        let totalunitcost = 0;
        let totaltotalcost= 0;
        let totaldepreciation= 0;
        let totalimpairmentlosses= 0;
        let totalcarryingamount= 0;
        let totalappraisedvalue= 0;
        let totalamount= 0;

        iirupinfo.data.forEach((info) => {

            totalunitcost = totalunitcost + ((info.unitcost === null) ? 0 : info.unitcost);
            totaltotalcost = totaltotalcost + ((info.totalcost === null) ? 0 : info.totalcost);
            totaldepreciation = totaldepreciation + ((info.depreciation === null) ? 0 : info.depreciation);
            totalimpairmentlosses = totalimpairmentlosses + ((info.impairmentlosses === null) ? 0 : info.impairmentlosses);
            totalcarryingamount = totalcarryingamount + ((info.carryingamount === null) ? 0 : info.carryingamount);
            totalappraisedvalue = totalappraisedvalue + ((info.appraisedvalue === null) ? 0 : info.appraisedvalue);
            totalamount = totalamount + ((info.amount === null) ? 0 : info.amount);
    
            tableBody.push([
            { text:  moment(info.dateacquired).format('DD-MMM-YY '),alignment: "left",fontSize: 7.5,border: [true,false,true,true] },
            { text: info.description,alignment: "left",fontSize: 7.5,border: [true,false,true,true] },
             { text: info.propertynumber,alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: info.quantity,alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.unitcost === null) ? '-' : formatNumber(info.unitcost),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.totalcost === null) ? '-' :  formatNumber(info.totalcost),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.depreciation === null) ? '-' : formatNumber(info.depreciation),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.impairmentlosses === null) ? '-' : formatNumber(info.impairmentlosses),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.carryingamount === null) ? '-' : formatNumber(info.carryingamount),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
             { text: 'Unserviceable',alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.sale === 0) ? '' : '√',alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.transfer === 0) ? '' : '√',alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.destruction === 0) ? '' : '√',alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: info.otherdisposaltype,alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.total === null || info.total === 0 ) ? '-' : formatNumber(info.total),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.appraisedvalue === null || info.appraisedvalue === 0 ) ? '-' : formatNumber(info.appraisedvalue),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
             { text: info.ornumber,alignment: "center",fontSize: 7.5,border: [true,false,true,true] },
             { text: (info.amount === null || info.amount === 0 ) ? '-' : formatNumber(info.amount),alignment: "right",fontSize: 7.5,border: [true,false,true,true] },
            ]);
            rowcount = rowcount + 1;

           

        });
        // iirupinfo.data[0]['entityname'],
          
        content.push(

            {
                text: 'Appendix  74',
                alignment : "right",
                fontSize: 14,
                italics:true
                },

            {
            text: 'INVENTORY AND INSPECTION REPORT OF UNSERVICEABLE PROPERTY',
            alignment : "center",
            fontSize: 11,
            bold:true
            },
            {
            text: "As of December 31, " + moment( iirupinfo.data[0]['dateofiirup']).format('YYYY'),
            alignment : "center",
            fontSize: 9.5,
            },
            {
           //  filler table
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
                    widths: ['*', 250],
                    body: [
                            [
                                {
                                    text: "Entity Name: " + entityname,
                                    border: [false, false, false, false],
                                    fontSize: 9.5,
                                    bold: true
                                },
                            {
                            text: "Fund cluster: " + fundcluster,	border: [false, false, false, false],fontSize: 9.5,alignment: "left",bold: true
                            },   
                            ],
                        ]
                },
                },

                {
                    //  filler table
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
                widths: [200, 200,'*'],
                body: [
                        [
                        {
                        text: accountableofficer,	border: [false, false, false, false],fontSize: 9.5,alignment: "center",decoration: 'underline'
                        }, 

                        {
                        text: designation,	border: [false, false, false, false],fontSize: 9.5,alignment: "center",decoration: 'underline'
                        }, 
                            
                        {
                        text: section,	border: [false, false, false, false],fontSize: 9.5,alignment: "center",decoration: 'underline'
                        }, 
    
                        ],
                        
            
                    ]
            },
            },

            {
                table: {
                widths: [200, 200,'*'],
                body: [
                        [
                        {
                        text: '(Name of Accountable Officer)',	border: [false, false, false, false],fontSize: 9.5,alignment: "center",italics: true
                        }, 

                        {
                        text: '(Designation)',	border: [false, false, false, false],fontSize: 9.5,alignment: "center",italics: true
                        }, 
                            
                        {
                        text: '(Station)',	border: [false, false, false, false],fontSize: 9.5,alignment: "center",italics: true
                        }, 
    
                        ],
                        
            
                    ]
            },
            },

            {
                //  filler table
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
                        widths: [541,'*'],
                        body: [
                                [
                                {
                                text: 'INVENTORY',	border: [true, true, true, true],fontSize: 9.5,alignment: "center",bold: true
                                }, 
        
                                {
                                text: 'DISPOSAL',	border: [true, true, true, true],fontSize: 9.5,alignment: "center",bold: true
                                }, 

                                ],
                                
                    
                            ]
                    },
                    },

          
            {
                table: {
                widths: [30,80,40,20,50,50,50,40,50,50,20,30,50,35,30,40,30,'*'],
                body: [
                    [
                        {text: 'Date acquired',border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Particulars/ Articles',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Property No.',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Qty',	border:[true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Unit Cost',	border:[true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Total Cost',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Accumulated Depreciation',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Accumulated Impairment Losses',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Carrying amount',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'Remarks',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'DISPOSAL',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",colSpan: 5,}, 
                        {text: 'DISPOSAL',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: 'DISPOSAL',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: 'DISPOSAL',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: 'DISPOSAL',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: 'Appraised Value',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",rowSpan: 2,margin: [0, 5,0,0],}, 
                        {text: 'RECORD OF SALES',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",colSpan: 2}, 
                        {text: 'RECORD OF SALES',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        ],

                        [
                            {text: '',border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border: [false, false, false, false],fontSize: 8,alignment: "center",}, 
                            {text: '',	border:[true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border:[true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: '',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: 'Sale',	border: [true, true, true, true],fontSize: 8,alignment: "center",margin: [0, 5,0,0],}, 
                            {text: 'Transfer',	border: [true, true, true, true],fontSize: 8,alignment: "center",margin: [0, 5,0,0],}, 
                            {text: 'Descruction',	border: [true, true, true, true],fontSize: 8,alignment: "center",margin: [0, 5,0,0],}, 
                            {text: 'Others\n(Specify)',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: 'Total',	border: [true, true, true, true],fontSize: 8,alignment: "center",margin: [0, 5,0,0],}, 
                            {text: '',	border: [true, true, true, true],fontSize: 8,alignment: "center",}, 
                            {text: 'OR No.',	border: [true, true, true, true],fontSize: 8,alignment: "center",margin: [0, 5,0,0],}, 
                            {text: 'Amount',	border: [true, true, true, true],fontSize: 8,alignment: "center",margin: [0, 5,0,0],}, 
                            ],
                        
            
                    ]
            },
            },

            {
                table: {
                widths: [30,80,40,20,50,50,50,40,50,50,20,30,50,35,30,40,30,'*'],
                body: [
                    [
                        {text: '(1)',border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(2)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(3)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(4)',	border:[true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(5)',	border:[true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(6)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(7)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(8)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(9)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(10)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(11)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(12)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(13)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(14)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(15)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(16)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(17)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '(18)',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        ],
                    ]
            },
            },


            {
                table: {
                    widths: [30,80,40,20,50,50,50,40,50,50,20,30,50,35,30,40,30,'*'],
                body: tableBody,

            },
            },


            {
                table: {
                widths: [30,80,40,20,50,50,50,40,50,50,20,30,50,35,30,40,30,'*'],
                body: [
                    [
                        {text: '',border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border:[true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: (totalunitcost === 0 ? '-' : formatNumber(totalunitcost)) ,	border:[true, true, true, true],fontSize: 7.5,alignment: "right",bold: true,}, 
                        {text: (totaltotalcost === 0 ? '-' : formatNumber(totaltotalcost)),	border: [true, true, true, true],fontSize: 7.5,alignment: "right",bold: true,}, 
                        {text: (totaldepreciation === 0 ? '-' : formatNumber(totaldepreciation)),	border: [true, true, true, true],fontSize: 7.5,alignment: "right",bold: true,}, 
                        {text: (totalimpairmentlosses === 0 ? '-' : formatNumber(totalimpairmentlosses)),	border: [true, true, true, true],fontSize: 7.5,alignment: "right",bold: true,}, 
                        {text: (totalcarryingamount === 0 ? '-' : formatNumber(totalcarryingamount)),	border: [true, true, true, true],fontSize: 7.5,alignment: "right",bold: true,}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: (totalappraisedvalue === 0 ? '-' : formatNumber(totalappraisedvalue)),	border: [true, true, true, true],fontSize: 7.5,alignment: "right",bold: true,}, 
                        {text: '',	border: [true, true, true, true],fontSize: 7.5,alignment: "center",}, 
                        {text: (totalamount === 0 ? '-' : formatNumber(totalamount)),	border: [true, true, true, true],fontSize: 7.5,alignment: "right",bold: true,}, 
                        ],
                    ]
            },
            },

            
            {
                unbreakable: true, // Prevent the content from breaking across pages
                
                stack: [
                    {
                table: {
                widths:  [20,512,170,10,'*'],
                body: [
                    [   
                        {text: ' ', fontSize: 9.5, alignment: 'left',border: [true, false, false, false]},
                        {text: 'I HEREBY request inspection and disposition, pursuant to Section  79 of PD 1445, of the property enumerated above.', fontSize: 9.5, alignment: 'left',border: [false, false, false, false]},
                        {text: '     I CERTIFY that I have inspected each and every article enumerated in this report, and that the disposition made thereof was, in my judgment, the best for the public interest.  ', fontSize: 9.5, alignment: 'left',border: [true, false, false, false]},
                        {text: ' ', fontSize: 9.5, alignment: 'left',border: [false, false, false, false]},
                        {text: '    I CERTIFY that I have witnessed the disposition of the articles enumerated on this report this ____day of _____________, _____.', fontSize: 9.5, alignment: 'left',border: [false, false, true, false]},           
                ]
                ]
                },
        
            },	

            {
                table: {
                widths:  [250,282,'*'],
                body: [
                    [   
                        {text: 'Requested by:', fontSize: 9.5, alignment: 'left',border: [true, false, false, false]},
                        {text: 'Approved by:', fontSize: 9.5, alignment: 'left',border: [false, false, true, false]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, true, false]},                  
                ]
                ]
                },
            },
            

            {
                //  filler table
                    table: {
                    widths: [541,'*'],
                    heights: [5],
                    body: [
                                 [
                                 {
                                 text: '  ',	border: [true, false, true, false],fontSize: 5,
                                 }, 		
                                 {text: '  ',	border: [true, false, true, false],fontSize: 5},			
                                 ],
                                 
                     
                             ]
                         },
            },


            {
                table: {
                widths:  [55,170,80,170,30,160,20,'*'],
                body: [
                    [   
                        {text: '', fontSize: 9.5, alignment: 'left',border: [true, false, false, false]},
                        {text: accountableofficer, fontSize: 9.5, alignment: 'center',border: [false, false, false,false]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, false, false]},      
                        {text: approvedby, fontSize: 9.5, alignment: 'center',border: [false, false, false,false]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, true, false]},
                        {text: inspectionofficer, fontSize: 9.5, alignment: 'center',border: [false, false, false,false]},        
                        {text: '', fontSize: 9.5, alignment: 'center',border: [false, false, false, false]},
                        {text: witness, fontSize: 9.5, alignment: 'center',border: [false, false, true,false]},
                ]
                ]
                },
            },

            {
                table: {
                widths:  [55,170,80,170,30,160,20,'*'],
                body: [
                    [   
                        {text: '', fontSize: 9.5, alignment: 'left',border: [true, false, false, false]},
                        {text: '(Signature over Printed Name of Accountable Officer)', fontSize: 9.5, alignment: 'center',border: [false, true, false,false]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, false, false]},      
                        {text: '(Signature over Printed Name of Authorized Official)', fontSize: 9.5, alignment: 'center',border: [false, true, false,false]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, true, false]},
                        {text: '(Signature over Printed Name of Inspection Officer)', fontSize: 9.5, alignment: 'center',border: [false, true, false,false]},        
                        {text: '', fontSize: 9.5, alignment: 'center',border: [false, false, false, false]},
                        {text: '(Signature over Printed Name of Witness)', fontSize: 9.5, alignment: 'center',border: [false, true, true,false]},
          
                ]
                ]
                },
            },


            {
                table: {
                widths:  [55,170,80,170,30,'*'],
                body: [
                    [   
                        {text: '', fontSize: 9.5, alignment: 'left',border: [true, false, false, false]},
                        {text: designation, fontSize: 9.5, alignment: 'center',border: [false, false, false,false]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, false, false]},      
                        {text: approverdesignation, fontSize: 9.5, alignment: 'center',border: [false, false, false,false]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, true, false]},
                        {text: ' ', fontSize: 9.5, alignment: 'center',border: [false, false, true,false]},        
                    
                ]
                ]
                },
            },


            {
                table: {
                widths:  [55,170,80,170,30,'*'],
                body: [
                    [   
                        {text: '', fontSize: 9.5, alignment: 'left',border: [true, false, false, true]},
                        {text: '(Designation of Accountable Officer)', fontSize: 9.5, alignment: 'center',border: [false, true, false,true]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, false, true]},      
                        {text: '(Designation of Authorized Official)', fontSize: 9.5, alignment: 'center',border: [false, true, false,true]},
                        {text: '', fontSize: 9.5, alignment: 'left',border: [false, false, true, true]},
                        {text: ' ', fontSize: 9.5, alignment: 'center',border: [false, false, true,true]},        
                    
                ]
                ]
                },
            },


                ],
                
            },
            
              
           
        
    


        );
           
     


      var dd = {
        pageSize: {
            width: 13 * 72,
            height: 8.5 * 72
        },
        pageMargins: [25, 50, 25, 50], // left, top, right, bottom
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
    
