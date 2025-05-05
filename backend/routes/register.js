const express = require('express');
const router = express.Router();
const db = require('../db');
const bcrypt = require('bcryptjs');

// Función corregida para normalizar correctamente
function normalizarNombreCompleto(nombre, primer_apellido, segundo_apellido) {
  return `${primer_apellido} ${segundo_apellido || ''} ${nombre}`
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '') // ← esta regex SÍ elimina acentos bien
    .toUpperCase()
    .replace(/\s+/g, ' ') 
    .trim();
}

router.post('/', async (req, res) => {
  const { nombre, primer_apellido, segundo_apellido, email, password, role } = req.body;

  if (!nombre || !primer_apellido || !email || !password || !role) {
    return res.status(400).json({ success: false, error: 'Faltan datos obligatorios' });
  }

  try {
    const [existingUser] = await db.query('SELECT * FROM users WHERE email = ?', [email]);
    if (existingUser.length > 0) {
      return res.status(400).json({ success: false, error: 'Correo ya registrado' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const [result] = await db.query(
      `INSERT INTO users (nombre, primer_apellido, segundo_apellido, email, password_hash, role, created_at, updated_at)
       VALUES (?, ?, ?, ?, ?, ?, NOW(), NOW())`,
      [nombre, primer_apellido, segundo_apellido || '', email, hashedPassword, role]
    );

    const userId = result.insertId;

    if (role === 'docente') {
      const nombreFormateado = normalizarNombreCompleto(nombre, primer_apellido, segundo_apellido);

      // Buscar el docente por nombre formateado
      const [docenteExistente] = await db.query(
        'SELECT docente_id FROM docentes WHERE nombre_completo_formateado = ?',
        [nombreFormateado]
      );

      if (docenteExistente.length > 0) {
        // Actualizar si existe
        await db.query(
          'UPDATE docentes SET user_id = ?, email = ? WHERE docente_id = ?',
          [userId, email, docenteExistente[0].docente_id]
        );
      } else {
        // Insertar uno nuevo si no existía
        await db.query(
          `INSERT INTO docentes (user_id, nombre, primer_apellido, segundo_apellido, email, nombre_completo_formateado, created_at)
           VALUES (?, ?, ?, ?, ?, ?, NOW())`,
          [userId, nombre, primer_apellido, segundo_apellido || '', email, nombreFormateado]
        );
      }
    }

    res.json({ success: true });
  } catch (err) {
    console.error('Error en registro:', err);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
});

module.exports = router;
