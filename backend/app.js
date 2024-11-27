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

// Enable CORS for all routes
app.use(cors({
  origin: (origin, callback) => {                           // Allow specific origin
    if (!origin || origin.startsWith('http://localhost')) { // Izinkan semua origin dari localhost
      callback(null, true);
    } else {
      // Tolak origin lain
      callback(new Error('Not allowed by CORS'));
    }
  },   
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

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});