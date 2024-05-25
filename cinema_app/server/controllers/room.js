const express = require('express');
const router = express.Router();
const connection = require('../db');

router.get('/', async (req, res) => {
    const query = 'SELECT rooms.*, GROUP_CONCAT(DISTINCT seats.seat_type_id) AS seat_type_ids FROM rooms LEFT JOIN seats ON rooms.id = seats.room_id GROUP BY rooms.id';
    try {
        const [results] = await connection.query(query);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/id:id', async (req, res) => {
    const id = req.params.id;
    const query = 'SELECT rooms.*, GROUP_CONCAT(DISTINCT seats.seat_type_id) AS seat_type_ids FROM rooms LEFT JOIN seats ON rooms.id = seats.room_id WHERE rooms.id in (?) GROUP BY rooms.id';
    try {
        const [results] = await connection.query(query, [id]);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/seat_id:seat_id', async (req, res) => {
    const seat_id = req.params.seat_id.split(',');
    const query = 'SELECT * FROM ticket_options WHERE seat_type_id in (?)';
    try {
        const [results] = await connection.query(query, [seat_id]);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});


module.exports = router;
