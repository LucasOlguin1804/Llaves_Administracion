const express = require('express');
const router = express.Router();
const db = require('../db');

// Crear una nueva solicitud de llave
router.post('/', async (req, res) => {
  const {
    user_id,
    classroom_id,
    schedule_id,
    needs_data_control,
    notes
  } = req.body;

  try {
    const [scheduleRow] = await db.query(
      'SELECT end_time FROM schedules WHERE schedule_id = ?',
      [schedule_id]
    );

    if (scheduleRow.length === 0) {
      return res.status(404).json({ error: 'Horario no encontrado' });
    }

    const today = new Date().toISOString().split('T')[0]; // '2025-05-13'
const returnTime = `${today} ${scheduleRow[0].end_time}`; // '2025-05-13 13:55:00'


    const [result] = await db.query(`
      INSERT INTO key_requests 
        (user_id, classroom_id, schedule_id, needs_data_control, estado, request_time, return_time, notes)
      VALUES (?, ?, ?, ?, 'pending', NOW(), ?, ?)
    `, [user_id, classroom_id, schedule_id, needs_data_control, returnTime, notes]);

    await db.query(`
      INSERT INTO notifications (user_id, title, message, tipo, is_read, created_at)
      VALUES (?, ?, ?, ?, 0, NOW())
    `, [
      1,
      'Nueva solicitud de llave',
      `El docente con ID ${user_id} ha solicitado una llave.`,
      'key_request'
    ]);

    res.status(201).json({ success: true, request_id: result.insertId });
  } catch (err) {
    console.error('Error al registrar solicitud:', err);
    res.status(500).json({ error: 'No se pudo registrar la solicitud' });
  }
});

// Obtener todas las solicitudes de llaves
router.get('/', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT 
  kr.request_id,
  kr.user_id,
  kr.classroom_id,
  kr.schedule_id,
  kr.needs_data_control,
  kr.estado,
  kr.request_time,
  kr.return_time,
  kr.notes,
  kr.approved_by,
  CONCAT(u.nombre, ' ', u.primer_apellido, ' ', u.segundo_apellido) AS professor_name,
  s.start_time,
  s.end_time,
  s.day_of_week,
  sub.name AS subject_name,
  c.number AS classroom_number
FROM key_requests kr
JOIN users u ON kr.user_id = u.user_id
JOIN schedules s ON kr.schedule_id = s.schedule_id
JOIN subjects sub ON s.subject_id = sub.subject_id
JOIN classrooms c ON kr.classroom_id = c.classroom_id
ORDER BY kr.request_time DESC

    `);

    res.json(rows);
  } catch (err) {
    console.error('Error al obtener solicitudes:', err);
    res.status(500).json({ error: 'Error interno del servidor' });
  }
});

// Aprobar solicitud
router.put('/:id/approve', async (req, res) => {
  const { id } = req.params;
  const { admin_id } = req.body;

  try {
    await db.query(`
      UPDATE key_requests
      SET estado = 'approved', approval_time = NOW(), approved_by = ?
      WHERE request_id = ?
    `, [admin_id, id]);

    res.json({ success: true });
  } catch (err) {
    console.error('Error al aprobar solicitud:', err);
    res.status(500).json({ error: 'No se pudo aprobar la solicitud' });
  }
});

// Marcar como devuelta
router.put('/:id/complete', async (req, res) => {
  const { id } = req.params;

  try {
    await db.query(`
      UPDATE key_requests
      SET estado = 'completed', return_time = NOW()
      WHERE request_id = ?
    `, [id]);

    res.json({ success: true });
  } catch (err) {
    console.error('Error al completar solicitud:', err);
    res.status(500).json({ error: 'No se pudo marcar como devuelta' });
  }
});

router.post('/manual', async (req, res) => {
   console.log('Datos recibidos para /manual:', req.body);
  const {
    user_id,
    classroom_id,
    schedule_id,
    needs_data_control,
    notes,
    estado,
    approved_by
  } = req.body;

  try {
    const [scheduleRow] = await db.query(
      'SELECT end_time FROM schedules WHERE schedule_id = ?',
      [schedule_id]
    );

    if (scheduleRow.length === 0) {
      return res.status(404).json({ error: 'Horario no encontrado' });
    }

    const today = new Date().toISOString().split('T')[0]; // "2025-05-13"
const returnTime = `${today} ${scheduleRow[0].end_time}`; // "2025-05-13 13:55:00"


    const [result] = await db.query(`
  INSERT INTO key_requests 
    (user_id, classroom_id, schedule_id, needs_data_control, estado, request_time, approval_time, return_time, approved_by, notes)
  VALUES (?, ?, ?, ?, ?, NOW(), NOW(), ?, ?, ?)
`, [
  user_id,
  classroom_id,
  schedule_id,
  needs_data_control,
  estado || 'approved',
  returnTime,
  approved_by || null,
  notes
]);


    res.status(201).json({ success: true, request_id: result.insertId });
  } catch (err) {
    console.error('Error en /manual:', err);
    res.status(500).json({ error: 'Error al registrar préstamo manual' });
  }
});


module.exports = router;
