var router = require('express').Router();


var employee = {
    //all methods for Employee Controller

    //Sample Method of Employee Controller
    'sample' : (req,res) => {
        res.send("Welcome to HRMS");
    }
        
}
    

module.exports = employee
    
    