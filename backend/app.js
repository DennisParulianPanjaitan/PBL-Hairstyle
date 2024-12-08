import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import authRoutes from './routes/auth.routes.js'; // Importing routes
// import { dotenv } from 'dotenv';
import { populateDB, getUsernameById, getUserByUserName } from './databases/populate.postgre.js';
import { Sequelize } from 'sequelize';
import http from 'http';
import db from './databases/config.js';
import otpRoutes from './routes/otp.routes.js'; // Importing routes
import UserRoutes from './routes/user.routes.js'; // Importing routes

const app = express();
const PORT = 3001;
// Allow specific origin
const allowedOrigins = [
  'http://localhost:', // Untuk web dari localhost
  'http://http://10.0.2.2:', // Ganti dengan IP komputer host Anda
  'http://http://192',
  'http://http://196',
];
app.use(cors({
  origin: '*',
  methods: ['GET', 'POST'],   // Allowed HTTP methods
  credentials: true           // Allow cookies and credentials
}));
app.use(bodyParser.json()); // Middleware to parse JSON requests

app.get('/', (req, res) => {
  res.send('Welcome to the API!');
});
app.use('/auth', authRoutes); // Use authentication routes
app.use('/otp', otpRoutes); // Add OTP routes
app.use('/user', UserRoutes); 
 
app.get('/populate', async (req, res) => {
  await populateDB(); // Call the function to populate the database
  res.send('Database populated!');
});
app.get('/user/:id', async (req, res, next) => {
  const userId = parseInt(req.params.id, 10);
  const [results] = await db.query(`
    SELECT username, email
      FROM users
      WHERE id = ${userId};`);
  // res.send(results[0].username);
  res.send(results);
});
app.get('/username/:username', async (req, res, next) => {
  // const userId = parseInt(req.params.id, 10);
  const [ results ] = await db.query(`SELECT id FROM users WHERE username = '${req.params.username}'`);

  // res.send(results[0].username);
  res.send(results);
});
app.get('/cekOtp', async (req, res, next) => {
  // const userId = parseInt(req.params.id, 10);
  const [ result ] = await db.query(`
    SELECT otp
      FROM users
      WHERE username = 'paksi4' AND email = 'paksi.dh@gmail.com';
  `);
  const tipe = typeof result[0].otp;
  // res.send(results[0].username);
  res.send(tipe);
});
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});