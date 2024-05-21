const express = require('express');
const router = express.Router();
const connection = require('../db');

router.get('/', async (req, res) => {
  const query = 'SELECT * FROM theaters';
  try {
    const [results] = await connection.query(query);
    return res.json(results);
  } catch (error) {
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});


module.exports = router;
