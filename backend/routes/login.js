const express = require('express');
const router = express.Router();
const db = require('../db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const JWT_SECRET = '123miClaveInseguraPeroTemporal!'; // 🔐 Cámbialo por algo seguro en producción

router.post('/', async (req, res) => {
  try {
    const { email, password } = req.body;

    const [rows] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    if (rows.length === 0) {
      return res.status(401).json({ success: false, error: 'Usuario no encontrado' });
    }

    const user = rows[0];

    const passwordMatch = await bcrypt.compare(password, user.password_hash);
    if (!passwordMatch) {
      return res.status(401).json({ success: false, error: 'Contraseña incorrecta' });
    }

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

    // ✅ Generar token JWT
    const token = jwt.sign({ userId: user.user_id }, JWT_SECRET, { expiresIn: '2h' });

    // ✅ Enviar token junto al usuario
    res.json({
      success: true,
      token,
      user: {
        user_id: user.user_id,
        name: fullName,
        email: user.email,
        role: user.role
      }
    });

  } catch (err) {
    console.error('Error en login:', err);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
});

module.exports = router;
