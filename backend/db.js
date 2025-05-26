// db.js
const mysql = require('mysql2/promise');

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'STARKILLER1475369',
  database: 'keymaster_db',
});

module.exports = pool;
