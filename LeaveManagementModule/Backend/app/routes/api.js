var express = require('express')
var controllers = require('../controllers');
const apiRoutes = () => {

    var router = express.Router();
    //define routes here
    router.get('/', controllers.employee.sample);
    router.get('/email', controllers.employee.sendEmail);
    router.get('/employees/:id/leaves/requests',controllers.employee.getLeaves)
    router.get('/employees/:id/leaves/requests/status/:status',controllers.employee.getLeavesByStatus)
    router.post('/employees/:id/leaves',controllers.employee.createLeave)
    router.get('/employees/:id/leaves',controllers.employee.getBalanceLeaves)
    router.get('/holidays',controllers.employee.getHolidaysList);


    return router;

};


module.exports = apiRoutes;