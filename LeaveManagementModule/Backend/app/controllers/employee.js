var router = require('express').Router();
var sGrid = require('../../sendgrid');
const sql = require('mssql');
var mssqlConfig = require('../../config/mssql');

var employee = {
    //all methods for Employee Controller

    //Sample Method of Employee Controller
    'sample' : (req,res) => {
        res.send("Welcome to HRMS");
    },
    'sendEmail' : (req,res) => {
        console.log(sGrid);
        res.send(sGrid.send());
    },
    'createLeave' : (req,res) => {
        console.log("here");
        if(!req.params.id)
        { res.status(400).json({
             message : "Employee Id Required",
         }); 
         } 
         sql.connect(mssqlConfig).then(() => {
             const request = new sql.Request();
             console.log(req.body.employeeId)
             console.log(req.body.leaveId)
             console.log(req.body.startDate)
             console.log(req.body.endDate)
             console.log(req.body.reason)
             request.input('EmployeeId',sql.Int,req.body.employeeId);
             request.input('LeaveId',sql.Int,req.body.leaveId);
             request.input('StartDate',sql.Date,req.body.startDate);
             request.input('EndDate',sql.Date,req.body.endDate);
             request.input('Reason',sql.VarChar(200),req.body.reason);
             request.output('Status',sql.Int);
             request.output('Message',sql.VarChar(200))
             return request.execute('pConditionForLeave');

         }).then(result => {
             res.status(result.output.Status == 1?201:400).json({'status' : result.output.Status , 'message' : result.output.Message});
             console.dir(result.output)
             sql.close();
         }).catch(err => {
             // ... error checks
             sql.close();
             res.send(err);

         })
         
    },
    'getLeaves' : (req,res) => {
      
            if(!req.params.id)
           { res.status(400).json({
                message : "Employee Id Required",
            }); 
            } 
            
            var data = [{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'}
            ,{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'}
           ];
            res.json({"leaves":data});
            
        },
        'getLeavesByStatus' : (req,res) => {
      
            if(!req.params.id || !req.params.status)
           { res.status(400).json({
                message : "Employee Id Required",
            }); 
            } 
            
            console.log(req.params.status);

            var data = [{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Open',"by":'25/01/2019',"request":'Manager'}
            ,{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Open',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Closed',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Closed',"by":'25/01/2019',"request":'Manager'}
           ];
           let filteredData =  data.filter(leave => leave.status == req.params.status)
            res.json({"leaves":filteredData});
            
        },

    'getBalanceLeaves' : (req,res) => {

        if(!req.params.id)
        { res.status(400).json({
             message : "Employee Id Required",
         }); 
         } 
         sql.connect(mssqlConfig).then(() => {
            return sql.query('select * from fUserLeaveBalance('+ req.params.id +')');
        }).then(result => {
            res.status(201).json({"status": 1,"message" : "balance leaves","employeeBalanceLeaves":result.recordsets[0]});
            sql.close();
            console.dir(result.recordsets[0])
        }).catch(err => {
            // ... error checks
            sql.close();
            res.send(err);
        })
         
        //  var data = [
        //  { "type":'Casual Leave',"total" : 10 , "balance" : 10 , "pending":0,"approved":0,"rejected":0},
        //  { "type":'Sick Leave',"total" : 15 , "balance" : 15 , "pending":0,"approved":0,"rejected":0},
        //  { "type":'Earned Leave',"total" : 15 , "balance" : 15 , "pending":0,"approved":0,"rejected":0},
        //  { "type":'Leave Without Pay',"total" : 0 , "balance" : 0 , "pending":0,"approved":0,"rejected":0},
        //  { "type":'Marital Leave',"total" : 5 , "balance" : 5 , "pending":0,"approved":0,"rejected":0},
        //  { "type":'Breavement Leave',"total" : 3 , "balance" : 3 , "pending":0,"approved":0,"rejected":0},  
        //  { "type":'Work From Leave',"total" : 0 , "balance" : 0 , "pending":0,"approved":0,"rejected":0}
        // ];

        
        //  res.json({"leaves":data});

    },    
    'getHolidaysList' : (req,res)=>{

        var data = [
            {'name':"New Years Day","date":"Jan 01, 2019","location" : "India"},
            {'name':"Holi","date":"Mar 21, 2019","location" : "India"},
            {'name':"Good Friday","date":"April 19,2019","location" : "India"}
        ];

        res.json({"holidays":data});
    } 
} 

module.exports = employee
    
    