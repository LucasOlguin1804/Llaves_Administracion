const express = require('express');
const router = express.Router();
const multer = require('multer');
const xlsx = require('xlsx');
const db = require('../db');

const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// Función auxiliar: Normalizar nombre
function normalizarNombre(nombre) {
  return nombre
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toUpperCase()
    .replace(/\s+/g, ' ')
    .trim();
}

router.post('/import-excel', upload.single('file'), async (req, res) => {
  const { anio, semestre } = req.body;

  if (!req.file || !anio || !semestre) {
    return res.status(400).json({ success: false, error: 'Datos incompletos' });
  }

  try {
    const workbook = xlsx.read(req.file.buffer, { type: 'buffer' });
    const sheetName = workbook.SheetNames[0];
    const rows = xlsx.utils.sheet_to_json(workbook.Sheets[sheetName]);

    // Buscar o crear gestión activa
    let [gestion] = await db.query(
      'SELECT * FROM gestiones WHERE anio = ? AND semestre = ?',
      [anio, semestre]
    );

    let gestionId;

    if (gestion.length > 0) {
      gestionId = gestion[0].gestion_id;
      await db.query('UPDATE gestiones SET activo = FALSE');
      await db.query('UPDATE gestiones SET activo = TRUE WHERE gestion_id = ?', [gestionId]);
    } else {
      const [insert] = await db.query(
        'INSERT INTO gestiones (anio, semestre, activo) VALUES (?, ?, TRUE)',
        [anio, semestre]
      );
      gestionId = insert.insertId;
    }

    let aulasRegistradas = new Set();
    const [aulas] = await db.query('SELECT number FROM classrooms');
    aulas.forEach(a => aulasRegistradas.add(a.number));

    let insertados = 0, ignorados = 0;

    for (const row of rows) {
      const { Docente, Curso, Día, 'Hora Inicio': HoraInicio, 'Hora Fin': HoraFin, Aula } = row;

      if (!Aula || !aulasRegistradas.has(Aula)) {
        ignorados++;
        continue;
      }

      // Registrar o buscar DOCENTE
      const nombreNormalizado = normalizarNombre(Docente);

      let [docenteRes] = await db.query(
        'SELECT docente_id FROM docentes WHERE nombre_completo_formateado = ?',
        [nombreNormalizado]
      );

      let docenteId;

      if (docenteRes.length > 0) {
        docenteId = docenteRes[0].docente_id;
      } else {
        const partes = nombreNormalizado.split(' ');
        const primerApellido = partes[0] || '';
        const segundoApellido = partes[1] || '';
        const nombres = partes.slice(2).join(' ') || '';

        const [insertDocente] = await db.query(
          `INSERT INTO docentes (primer_apellido, segundo_apellido, nombres, nombre_completo_formateado)
           VALUES (?, ?, ?, ?)`,
          [primerApellido, segundoApellido, nombres, nombreNormalizado]
        );

        docenteId = insertDocente.insertId;
      }

      // Registrar o buscar ASIGNATURA
      const [subjectRes] = await db.query(
        'SELECT subject_id FROM subjects WHERE name = ?',
        [Curso]
      );
      let subjectId = subjectRes.length ? subjectRes[0].subject_id : null;

      if (!subjectId) {
        const [insertSubject] = await db.query(
          'INSERT INTO subjects (name) VALUES (?)',
          [Curso]
        );
        subjectId = insertSubject.insertId;
      }

      const [classroomRes] = await db.query(
        'SELECT classroom_id FROM classrooms WHERE number = ?',
        [Aula]
      );
      const classroomId = classroomRes[0].classroom_id;

      // Registrar HORARIO con docente_id
      await db.query(
        `INSERT INTO schedules (subject_id, classroom_id, docente_id, gestion_id, day_of_week, start_time, end_time)
         VALUES (?, ?, ?, ?, ?, ?, ?)`,
        [subjectId, classroomId, docenteId, gestionId, Día, HoraInicio, HoraFin]
      );

      insertados++;
    }

    res.json({
      success: true,
      mensaje: `${insertados} registros importados, ${ignorados} ignorados (aulas no registradas)`
    });

  } catch (error) {
    console.error('Error al importar Excel:', error);
    res.status(500).json({ success: false, error: 'Error interno al procesar Excel' });
  }
});

module.exports = router;
