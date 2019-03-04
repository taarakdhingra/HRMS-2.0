const config = {
    user: 'sa',
    password: 'P',
    server: 'CYG', // You can use 'localhost\\instance' to connect to named instance
    database: 'db',
    options: {
        encrypt: true // Use this if you're on Windows Azure
    }
}

module.exports = config