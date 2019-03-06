var sql = require('mssql');
var sqlConfig = require('../Backend/config/mssql');
const pool = new sql.ConnectionPool(sqlConfig);

module.exports = pool