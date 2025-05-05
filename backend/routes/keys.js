const express = require('express');
const router = express.Router();
const db = require('../db');

// GET /api/keys?classroom_id=1
router.get('/keys', async (req, res) => {
  const classroomId = req.query.classroom_id;

  if (!classroomId) {
    return res.status(400).json({ error: 'classroom_id es requerido' });
  }

  try {
    const [rows] = await db.query(
      'SELECT * FROM key_aula WHERE classroom_id = ? AND estado = "disponible"',
      [classroomId]
    );

    res.json(rows);
  } catch (err) {
    console.error('Error al obtener clave:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

module.exports = router;
