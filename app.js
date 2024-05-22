const express = require('express');
const mysql = require('mysql');
const path = require('path');

const app = express();


const db = mysql.createConnection({
    host: 'LAPTOP-1V0FJVA1',
    user: 'root',
    password: 'mysql',
    database: 'FarmaQuik'
});

db.connect((err) => {
    if (err) {
        throw err;
    }
    console.log('MySQL connected');
});

app.use(express.static(path.join(__dirname, 'public')));

app.use((req, res) => {
    res.status(404);
    res.send('<h1>Resource not found</h1>')
})

app.listen(3000, () => {
    console.log(`app running on port 3000`);
});
