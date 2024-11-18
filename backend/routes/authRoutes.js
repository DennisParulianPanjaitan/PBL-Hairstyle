// Load environment variables from the .env file
require('dotenv').config();

// routes/authRoutes.js
// const express = require('express');
// const jwt = require('jsonwebtoken');
// const bcrypt = require('bcrypt');
import { Router } from 'express';
import { sign, verify } from 'jsonwebtoken';
import { compare } from 'bcrypt';

const router = Router();

const users = [
  {
    id: 1,
    username: 'user1',
    email: 'user1@example.com',
    password: '$2b$10$C/dmTnH4Uaz.jA6Q1Ww5beZkEdM9t1Y3Sp0jLs8AzPIpLgH8A6/eS' // bcrypt hash for 'password123'
  }
];

const SECRET_KEY = process.env.JWT_SECRET_KEY;

router.post('/login', async (req, res) => {
    const { username, password } = req.body;
  
    // Find user by username or email
    const user = users.find((u) => u.username === username || u.email === username);
  
    if (!user) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }
  
    // Check password
    const isPasswordValid = await compare(password, user.password);
  
    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Invalid username or password' });
    }
  
    // Create a JWT token
    const token = sign({ id: user.id, username: user.username }, SECRET_KEY, {
      expiresIn: '1h',
    });
  
    return res.status(200).json({ message: 'Login successful', token });
  });
  
  // Protected route
  router.get('/protected', (req, res) => {
    const token = req.headers['authorization'];
  
    if (!token) {
      return res.status(403).json({ message: 'No token provided' });
    }
  
    verify(token, SECRET_KEY, (err, decoded) => {
      if (err) {
        return res.status(401).json({ message: 'Failed to authenticate token' });
      }
  
      // Proceed with the request
      return res.status(200).json({ message: 'Access granted', userId: decoded.id });
    });
  });
  
  export default router;