// Load environment variables from the .env file
import dotenv from 'dotenv';

// Load environment variables
dotenv.config();

import { Router } from 'express';
import { compare } from 'bcrypt';
import jwt from 'jsonwebtoken';
import { sql } from '@vercel/postgres';

// const supabase = createClient('https://vcixgtpgalxcdxxgdxpe.supabase.co', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjaXhndHBnYWx4Y2R4eGdkeHBlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI3NzQ5NTEsImV4cCI6MjA0ODM1MDk1MX0.qZa9Sxw7nBIssb1zVMEkVqcGPJ0hIBQxXlvYyZ618Uw');
dotenv.config({ path: '.env.local' }); // Load environment variables

const { sign, verify } = jwt;
const router = Router();

const users = [
  {
    id: 1,
    username: 'k1',
    email: 'user1@example.com',
    password: '$2a$12$zPlq1NLDZmgofBpy6LwiB.2q5zSU5TGQdk3Fh3Ll.PFYc7mrQXaAa' // bcrypt hash for 'ti3a'
  }
];

const SECRET_KEY = process.env.JWT_SECRET_KEY;
// const SECRET_KEY = "3938e9e111082bcba44f9d19461580d11177e5af410a485ea417103791fa7ce78656d3bd4651835cf2de75bb2a889717fd0eea7319733fc8c5ffff3f3032c655";
router.post('/login', async (req, res) => {
    const { username, password } = req.body;
  
    // Find user by username or email
    const user = users.find((u) => u.username === username || u.email === username);
  
    if (!user) {
      return res.status(401).json({ message: 'Username salah' });
    }
  
    // Check password
    const isPasswordValid = await compare(password, user.password);
  
    if (!isPasswordValid) {
      return res.status(401).json({ message: "password salah" });
    }
  
    // Create a JWT token
    const token = sign({ id: user.id, username: user.username }, SECRET_KEY, {
      expiresIn: '2h',
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