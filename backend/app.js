import express from 'express';
import bodyParser from 'body-parser';
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
app.use(bodyParser.json());

// Use authentication routes
app.use('/auth', authRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});