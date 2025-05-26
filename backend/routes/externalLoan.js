const express = require('express');
const router = express.Router();
const db = require('../db');

// POST /external-loans
router.post('/external-loans', async (req, res) => {
  const {
    person_name,
    tipo_persona,
    classroom_id,
    key_id,
    expected_return_time,
    registered_by
  } = req.body;

  try {
    const [result] = await db.query(`
      INSERT INTO external_loans 
        (person_name, tipo_persona, classroom_id, key_id, expected_return_time, registered_by) 
      VALUES (?, ?, ?, ?, ?, ?)
    `, [person_name, tipo_persona, classroom_id, key_id, expected_return_time, registered_by]);

    res.status(201).json({ message: 'Préstamo registrado', loan_id: result.insertId });
  } catch (err) {
    console.error('Error al guardar préstamo externo:', err);
    res.status(500).json({ error: 'No se pudo registrar el préstamo' });
  }
});

// GET /external-loans
router.get('/external-loans', async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT * FROM external_loans 
      WHERE estado NOT IN ("devuelta", "vencida") 
      ORDER BY loan_time DESC
    `);
    res.status(200).json(rows);
  } catch (err) {
    console.error('Error al obtener préstamos externos:', err);
    res.status(500).json({ error: 'No se pudo obtener la lista de préstamos externos' });
  }
});

// PUT /external-loans/:id/devolver
router.put('/external-loans/:id/devolver', async (req, res) => {
  const loanId = req.params.id;

  try {
    await db.query(`
      UPDATE external_loans
      SET estado = 'devuelta',
          actual_return_time = NOW()
      WHERE loan_id = ? AND estado = 'prestada'
    `, [loanId]);

    res.json({ message: 'Préstamo marcado como devuelto' });
  } catch (err) {
    console.error('Error al marcar préstamo como devuelto:', err);
    res.status(500).json({ error: 'No se pudo actualizar el estado' });
  }
});

// PUT /external-loans/:id/vencer
router.put('/external-loans/:id/vencer', async (req, res) => {
    const loanId = req.params.id;
  
    try {
      await db.query(`
        UPDATE external_loans
        SET estado = 'vencida',
            actual_return_time = NOW()
        WHERE loan_id = ? AND estado = 'prestada'
      `, [loanId]);
  
      res.json({ message: 'Préstamo marcado como vencido' });
    } catch (err) {
      console.error('Error al marcar préstamo como vencido:', err);
      res.status(500).json({ error: 'No se pudo actualizar el estado' });
    }
  });
  

module.exports = router;
