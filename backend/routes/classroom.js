const express = require('express');
const router = express.Router();
const db = require('../db'); // <- ahora se llama directamente 'db'

router.get('/classrooms', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT * FROM classrooms');
    res.json(rows);
  } catch (err) {
    console.error('Error al obtener aulas:', err);
    res.status(500).json({ error: 'Error al obtener aulas' });
  }
});

module.exports = router;
