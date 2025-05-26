const express = require('express');
const router = express.Router();
const db = require('../db');

// Obtener los horarios de un docente específico
router.get('/docente/:userId', async (req, res) => {
    const { userId } = req.params;
  
    try {
      const [rows] = await db.query(
        `SELECT 
           s.schedule_id,
           s.classroom_id, 
           sub.name AS subjectName,
           c.number AS classroomNumber,
           s.start_time,
           s.end_time,
           s.day_of_week,
           CONCAT(d.nombres, ' ', d.primer_apellido, ' ', d.segundo_apellido) AS professorName
         FROM schedules s
         JOIN subjects sub ON s.subject_id = sub.subject_id
         JOIN classrooms c ON s.classroom_id = c.classroom_id
         JOIN docentes d ON s.docente_id = d.docente_id
         WHERE d.user_id = ?`,
        [userId]
      );
  
      res.json({ success: true, schedules: rows });
    } catch (error) {
      console.error('Error al obtener horarios del docente:', error);
      res.status(500).json({ success: false, error: 'Error interno del servidor' });
    }
  });
  
  // Obtener todos los horarios (para el admin)
router.get('/all', async (req, res) => {
  try {
    const [rows] = await db.query(
      `SELECT 
         s.schedule_id,
         s.classroom_id, 
         sub.name AS subjectName,
         c.number AS classroomNumber,
         s.start_time,
         s.end_time,
         s.day_of_week,
         CONCAT(d.nombres, ' ', d.primer_apellido, ' ', d.segundo_apellido) AS professorName
       FROM schedules s
       JOIN subjects sub ON s.subject_id = sub.subject_id
       JOIN classrooms c ON s.classroom_id = c.classroom_id
       JOIN docentes d ON s.docente_id = d.docente_id`
    );

    res.json({ success: true, schedules: rows });
  } catch (error) {
    console.error('Error al obtener todos los horarios:', error);
    res.status(500).json({ success: false, error: 'Error interno del servidor' });
  }
});


module.exports = router;
