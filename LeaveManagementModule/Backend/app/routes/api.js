var express = require('express')
var controllers = require('../controllers');

const apiRoutes = () => {

    var router = express.Router();
    //define routes here
    router.get('/', controllers.employee.sample);

    
    return router;

};


module.exports = apiRoutes;