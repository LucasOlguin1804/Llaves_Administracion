const express = require('express');
const http = require('http'); // <-- debe ir antes de usar http
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express(); // <-- primero defines 'app'
const server = http.createServer(app); // <-- luego usas 'app' aquí

const { Server } = require('socket.io');
const io = new Server(server, {
  cors: {
    origin: '*',
  }
});

// Guarda io en la app para usarlo en rutas
app.set('io', io);

// Middlewares
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
const keyRequestsRoute = require('./routes/key-requestes');
const userRoute = require('./routes/user');

// Usa rutas
app.use('/register', registerRoute);
app.use('/login', loginRoute);
app.use('/api', classroomRoutes);
app.use('/api', importExcelRoute);
app.use('/api/schedules', scheduleRoutes);
app.use('/api', keysRoute);
app.use('/api', externalLoanRoute);
app.use('/api/key-requests', keyRequestsRoute);
app.use('/api/user', userRoute);

// WebSocket de prueba
io.on('connection', (socket) => {
  console.log('🟢 User conectado');
  socket.on('disconnect', () => {
    console.log('🔴   User desconectado');
  });
});

// Iniciar servidor
const PORT = 3000;
server.listen(PORT, '0.0.0.0', () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
