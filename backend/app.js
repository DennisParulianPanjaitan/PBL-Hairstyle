import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import authRoutes from './routes/authRoutes.js'; // Importing routes

// const express = require('express');

// const app = express();

// const port = 3000;
// app.get('/', (req, res) => {
//     res.send('Hello world!');
// });
// app.listen(port, () => {
//     console.log(`Server running at http://localhost:${port}`);
// })

// index.js

const app = express();
const PORT = process.env.PORT || 3000;

import bonjour from 'bonjour';
const bonjourService = bonjour();
// Publikasikan layanan HTTP
bonjourService.publish({
  name: 'AuthService', // Nama layanan
  type: 'http',
  port: PORT,
  txt: {
    id: 'express_server_12345', // Identitas unik
    version: '1.0',
    description: 'Express API for Flutter Authentication',
  },
});

// Enable CORS for all routes
// const allowedOrigins = [
//   'http://localhost:', // Untuk web dari localhost
//   'http://http://10.0.2.2:', // Ganti dengan IP komputer host Anda
// ];
app.use(cors({
  // origin: (origin, callback) => {
  //   if (!origin || allowedOrigins.some(prefix => origin.startsWith(prefix))) { // Izinkan semua origin dari localhost
  //     callback(null, true);
  //   } else {
  //     // Tolak origin lain
  //     callback(new Error('Not allowed by CORS'));
  //   }
  // },
  origin: '*',   
  methods: ['GET', 'POST'],           // Allowed HTTP methods
  credentials: true                   // Allow cookies and credentials
}));

// app.use((req, res, next) => {
//   console.log(`${req.method} ${req.url}`);
//   next();
// });

// Middleware to parse JSON requests
app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Welcome to the API!');
});

// Use authentication routes
app.use('/auth', authRoutes);

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});