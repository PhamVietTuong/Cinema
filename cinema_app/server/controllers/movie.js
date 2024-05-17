const express = require('express');
const router = express.Router();
const connection = require('../db');

router.get('/showing', async (req, res) => {
  const query = 'SELECT * FROM movies WHERE status = 1';
  try {
    const [results] = await connection.query(query);
    return res.json(results);
  } catch (error) {
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});

router.get('/ids:ids', async (req, res) => {
  const ids = req.params.ids.split(',');
  const query = `SELECT m.*, ar.id AS ar_id, ar.name AS ar_name, ar.description AS ar_description, 
                   GROUP_CONCAT(mt.name) AS movie_types 
                   FROM movies m 
                   INNER JOIN age_restrictions ar ON m.age_restriction_id = ar.id 
                   INNER JOIN movie_type_details mtd ON m.id = mtd.movie_id 
                   INNER JOIN movie_types mt ON mtd.movie_type_id = mt.id 
                   WHERE m.id IN (?) GROUP BY m.id`;
  try {
    const [results] = await connection.query(query, [ids]);
    return res.json(results);
  } catch (error) {
    return res.status(500).json({ error: 'Internal Server Error' });
  }
});
module.exports = router;
