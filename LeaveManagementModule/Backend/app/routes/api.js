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
<<<<<<< HEAD

    router.post('/admin/leaves',controllers.admin.createLeaveType);
    router.put('/admin/leaves',controllers.admin.updateLeaveType);
    router.delete('/admin/leaves/:id',controllers.admin.deleteLeaveType);

=======
    //manager routes
    router.get('/manager/:id/teams/requests',controllers.employee.getManagerTeamRequests);
    router.post('/manager/:id/teams/requests/:requestId',controllers.employee.managerAcceptRejectRequest);
    
    
    
>>>>>>> e190a8935cf7c6b603a86b4064515e1a2668bf38

    return router;

};


module.exports = apiRoutes;