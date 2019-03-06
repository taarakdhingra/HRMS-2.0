var router = require('express').Router();
var sGrid = require('../../sendgrid');
const sql = require('../../mssql');
var mssqlConfig = require('../../config/mssql');

/*let config =
    {
    host:'DESKTOP-OHFBEH1',
    user:'sa',
    password:'shivam',
    database:'PROJECTHRMS2'
}; 

//Database Connection
var connection = mssqlConfig.createConnection(config)


connection.connect (function (error){
    if(!!error){
        console.log('Error')
    }
    else {
        console.log('Connected')
        
}
});*/
  

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
         } //Create Leave Request
         sql.connect(mssqlConfig).then(() => {
             const request = new sql.Request();
             console.log(req.body.employeeId)
             console.log(req.body.leaveId)
             console.log(req.body.startDate)
             console.log(req.body.endDate)
             console.log(req.body.reason)
             request.input('employeeId',sql.Int,req.body.employeeId);
             request.input('leaveId',sql.Int,req.body.leaveId);
             request.input('startDate',sql.Date,req.body.startDate);
             request.input('endDate',sql.Date,req.body.endDate);
             request.input('reason',sql.VarChar(200),req.body.reason);
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
        
              // My Request  Table
            
            sql.connect(mssqlConfig).then(() => {
               
            return sql.query('select * from fUserRequests('+ req.params.id +')');
        }).then(result => {
            res.status(201).json({"status": 1,"message" : "User Requests","employeeRequests":result.recordsets[0]});
            sql.close();
            console.dir(result.recordsets[0])
        }).catch(err => {
            // ... error checks
            sql.close();
            res.send(err);
        })
            
           /* var data = [{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'}
            ,{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'}
           ];
            res.json({"leaves":data});*/     
            
        },
        'getLeavesByStatus' : (req,res) => {
            console.log(req.params.id);
            console.log(req.params.status);
      
            if(!req.params.id || !req.params.status)
           { res.status(400).json({
                message : "Employee Id Required",
            }); 
            } 
            // closed and open request
            sql.connect(mssqlConfig).then(() => {
//            const request = new sql.Request();
//            request.input('status', sql.Varchar(50), req.body.status);
            return sql.query("select * from fUserLeavesPerStatus(" + req.params.id +",'"+req.params.status+"')");
        }).then(result => {
                
            res.status(201).json({"status": 1,"message" : "User Requests","employeeRequests":result.recordsets[0]});
            sql.close();
            console.dir(result.recordsets[0])
        }).catch(err => {
            // ... error checks
            sql.close();
            res.send(err);
        })
      
            
       /*    console.log(req.params.status);

            var data = [{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Approved',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Open',"by":'25/01/2019',"request":'Manager'}
            ,{ "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Open',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Closed',"by":'25/01/2019',"request":'Manager'},
            { "type":'Medical',"startDate" : '21/01/2019', "endDate" : '22/01/2019', "nDays":'2',"status":'Closed',"by":'25/01/2019',"request":'Manager'}
           ];
           let filteredData =  data.filter(leave => leave.status == req.params.status)
            res.json({"leaves":filteredData});*/
            
        },

    'getBalanceLeaves' : (req,res) => {

        if(!req.params.id)
        { res.status(400).json({
             message : "Employee Id Required",
         }); 
         } // Remaining balance table
        
         sql.connect(mssqlConfig).then(() => {
            
            return sql.query('select * from fUserLeaveBalanceEdit('+ req.params.id +')');
        }).then(result => {
            res.status(201).json({"status": 1,"message" : "balance leaves","employeeBalanceLeaves":result.recordsets[0]});
            sql.close();
            console.dir(result.recordsets[0])
        }).catch(err => {
            // ... error checks
            sql.close();
            res.send(err);
        })
       /*  
          var data = [
          { "type":'Casual Leave',"total" : 10 , "balance" : 10 , "pending":0,"approved":0,"rejected":0},
          { "type":'Sick Leave',"total" : 15 , "balance" : 15 , "pending":0,"approved":0,"rejected":0},
          { "type":'Earned Leave',"total" : 15 , "balance" : 15 , "pending":0,"approved":0,"rejected":0},
          { "type":'Leave Without Pay',"total" : 0 , "balance" : 0 , "pending":0,"approved":0,"rejected":0},
          { "type":'Marital Leave',"total" : 5 , "balance" : 5 , "pending":0,"approved":0,"rejected":0},
          { "type":'Breavement Leave',"total" : 3 , "balance" : 3 , "pending":0,"approved":0,"rejected":0},  
          { "type":'Work From Leave',"total" : 0 , "balance" : 0 , "pending":0,"approved":0,"rejected":0}
         ];

        
          res.json({"leaves":data});*/

    },    
    'getHolidaysList' : (req,res)=>{

        var data = [
            {'name':"New Years Day","date":"Jan 01, 2019","location" : "India"},
            {'name':"Holi","date":"Mar 21, 2019","location" : "India"},
            {'name':"Good Friday","date":"April 19,2019","location" : "India"}
        ];

        res.json({"holidays":data});
    },
    
    
    'getManagerTeamRequests' : (req, res) => {
        
                if(!req.params.id)
        { res.status(400).json({
             message : "Employee Id Required",
         }); 
         } // Remaining balance table
        
         sql.connect(mssqlConfig).then(() => {
            
            return sql.query('select * from fCMLeaveAll('+ req.params.id +')');
        }).then(result => {
            res.status(201).json({"status": 1,"message" : "Team Requests","employeeBalanceLeaves":result.recordsets[0]});
            sql.close();
            console.dir(result.recordsets[0])
        }).catch(err => {
            // ... error checks
            sql.close();
            res.send(err);
        })
        
    },
    
        'managerAcceptRejectRequest' : (req, res) => {
        
                if(!req.params.id)
        { res.status(400).json({
             message : "Manger Id Required",
         }); 
         } // Remaining balance table
            
            console.log(req.params.requestId)
             console.log(req.body.action)
        
             sql.connect(mssqlConfig).then(() => {
             const request = new sql.Request();
             
             request.input('EmployeeLeavesId',sql.Int,req.params.requestId);
             request.input('Action',sql.VarChar(50),req.body.action);
             request.output('Status',sql.Int);
             request.output('Message',sql.VarChar(200))
             return request.execute('pManagerRequestLeave');

         }).then(result => {
             res.status(result.output.Status == 1?201:400).json({'status' : result.output.Status , 'message' : result.output.Message});
             console.dir(result.output)
             sql.close();
         }).catch(err => {
             // ... error checks
             sql.close();
             res.send(err);

         })
         
        
    }
    
} 

module.exports = employee
    
    