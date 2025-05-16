const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Importa rutas
const registerRoute = require('./routes/register');
const loginRoute = require('./routes/login');
const classroomRoutes = require('./routes/classroom');
const importExcelRoute = require('./routes/importExcel');
const scheduleRoutes = require('./routes/schedules');
const keysRoute = require('./routes/keys');
const externalLoanRoute = require('./routes/externalLoan');
const keyRequestsRoute = require('./routes/key-requests');


// Usa rutas
app.use('/register', registerRoute);
app.use('/login', loginRoute);
app.use('/api', classroomRoutes);
app.use('/api', importExcelRoute);
app.use('/api/schedules', scheduleRoutes);
app.use('/api', keysRoute);
app.use('/api', externalLoanRoute);
app.use('/api/key-requests', keyRequestsRoute);



// Inicia servidor y acepta conexiones externas
const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
