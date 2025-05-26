const express = require('express');
const router = express.Router();
const db = require('../db');
const verifyToken = require('../middleware/auth');

router.get('/', verifyToken, async (req, res) => {
  try {
    const userId = req.userId;

    const [rows] = await db.query('SELECT * FROM users WHERE user_id = ?', [userId]);
    if (rows.length === 0) {
      return res.status(404).json({ error: 'Usuario no encontrado' });
    }

    const user = rows[0];

    let fullName = user.nombre;

    if (user.role === 'docente') {
      const [docenteData] = await db.query(
        'SELECT nombres, primer_apellido, segundo_apellido FROM docentes WHERE user_id = ?',
        [user.user_id]
      );

      if (docenteData.length > 0) {
        const d = docenteData[0];
        fullName = `${d.nombres} ${d.primer_apellido}${d.segundo_apellido ? ' ' + d.segundo_apellido : ''}`.trim();
      }
    }

    res.json({
      user_id: user.user_id,
      name: fullName,
      email: user.email,
      role: user.role
    });

  } catch (err) {
    console.error('Error al obtener usuario:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

module.exports = router;
