const express = require('express');
const router = express.Router();
const connection = require('../db');

router.get('/', async (req, res) => {
    const query = `SELECT s.*, sc.room_id, st.id AS st_id, st.name AS st_name 
                   FROM showtimes s 
                   LEFT JOIN schedules sc ON s.id = sc.showtime_id 
                   INNER JOIN showtime_types st ON s.showtime_type_id = st.id`;
    try {
        const [results] = await connection.query(query);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});

router.get('/theater:theater_id/date:date', async (req, res) => {
    const theater_id = req.params.theater_id;
    const date = req.params.date;

    if (!date) {
        return res.status(400).json({ error: 'Date is required' });
    }
    const query = `SELECT s.*, sc.room_id, st.id AS st_id, st.name AS st_name 
FROM showtimes s 
LEFT JOIN schedules sc ON s.id = sc.showtime_id 
INNER JOIN showtime_types st ON s.showtime_type_id = st.id 
INNER JOIN rooms r ON sc.room_id = r.id 
WHERE DATE(s.start_time) = ? AND r.theater_id = ?;
`;
    try {
        const [results] = await connection.query(query, [date, theater_id]);
        return res.json(results);
    } catch (error) {
        return res.status(500).json({ error: 'Internal Server Error' });
    }
});
module.exports = router;
