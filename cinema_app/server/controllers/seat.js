const express = require('express');
const router = express.Router();
const connection = require('../db');

router.get('/', async (req, res) => {
    const query = 'SELECT * FROM seats';
    try {
        const [results] = await connection.query(query);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/seat_type', async (req, res) => {
    const query = 'SELECT * FROM seat_types';
    try {
        const [results] = await connection.query(query);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/room_id:room_id', async (req, res) => {
    const room_id = req.params.room_id;
    const query = 'SELECT * FROM seats WHERE room_id = ?';
    try {
        const [results] = await connection.query(query, [room_id]);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/ticket:showtime_id', async (req, res) => {
    const showtime_id = req.params.showtime_id;
    const query = 'SELECT seat_id FROM tickets WHERE showtime_id = ?';
    try {
        const [results] = await connection.query(query, [showtime_id]);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

module.exports = router;
