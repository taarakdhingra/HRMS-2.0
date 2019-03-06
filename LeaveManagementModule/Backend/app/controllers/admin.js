var router = require('express').Router();
var sGrid = require('../../sendgrid');
const sql = require('mssql');
var mssqlConfig = require('../../config/mssql');

var admin = {


    'createLeaveType' : (req,res) => {
        
         sql.connect(mssqlConfig).then(() => {
             const request = new sql.Request();
             console.log(req.body.leaveType)
             console.log(req.body.maxConsecutiveLeaves)
             console.log(req.body.totalLeaves)
             console.log(req.body.description)

             request.input('LeaveType',sql.VarChar(100),req.body.leaveType);
             request.input('MaxConsecutiveLeaves',sql.Int,req.body.maxConsecutiveLeaves);
             request.input('TotalLeaves',sql.Int,req.body.totalLeaves);
             request.input('Description',sql.VarChar(1000),req.body.description);
             request.output('Status',sql.Int);
             request.output('Message',sql.VarChar(200))
             return request.execute('pAdminInsertNewLeave');

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

        'updateLeaveType' : (req,res) => {
        
            sql.connect(mssqlConfig).then(() => {
                const request = new sql.Request();
                console.log(req.body.leaveId)
                console.log(req.body.leaveType)
                console.log(req.body.maxConsecutiveLeaves)
                console.log(req.body.totalLeaves)
                console.log(req.body.description)
   
                request.input('LeaveId',sql.Int,req.body.leaveId);
                request.input('LeaveType',sql.VarChar(100),req.body.leaveType);
                request.input('MaxConsecutiveLeaves',sql.Int,req.body.maxConsecutiveLeaves);
                request.input('TotalLeaves',sql.Int,req.body.totalLeaves);
                request.input('Description',sql.VarChar(1000),req.body.description);
                request.output('Status',sql.Int);
                request.output('Message',sql.VarChar(200))
                return request.execute('pAdminLeaveUpdate');
   
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
           'deleteLeaveType' : (req,res) => {
        
            sql.connect(mssqlConfig).then(() => {
                const request = new sql.Request();
                console.log(req.params.id)
                request.input('LeaveId',sql.Int,req.params.id);
                request.output('Status',sql.Int);
                request.output('Message',sql.VarChar(200))
                return request.execute('pAdminDeleteLeave');
   
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

module.exports = admin