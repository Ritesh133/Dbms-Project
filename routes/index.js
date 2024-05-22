// routes/index.js
const express = require('express');
const router = express.Router();
const db = require('../db');

router.post('/login', (req, res) => {
    const { email, password } = req.body;
    // Perform authentication here (query database, check credentials, etc.)
    // For demonstration purposes, check if email and password are 'admin'
    if (email === 'admin' && password === 'admin') {
        res.json({ success: true });
    } else {
        res.status(401).json({ message: 'Invalid email or password' });
    }
});

module.exports = router;
