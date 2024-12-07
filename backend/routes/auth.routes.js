import dotenv from 'dotenv';  // Load environment variables from the .env file

import { Router } from 'express';
import { compare } from 'bcrypt';
import jwt from 'jsonwebtoken';
import { getUserByUserName } from '../databases/populate.postgre.js';
import db from '../databases/config.js';

dotenv.config();  // Load environment variables
dotenv.config({ path: '.env.development.local' }); // Load environment variables

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
router.post('/login', async (req, res) => {
    const { username, password } = req.body;

    const [ userData ] = await db.query(`SELECT id, username, email, password FROM users WHERE username = "${username}" OR email = "${username}";`);
    // Find user by username or email
    const user = userData.find((user) => user['username'] === username || user['email'] === username);
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
    return res.status(200).json({ message: 'Login successful', token, id: user.id, username: user.username });
  });
  
  // Protected route
  router.get('/protected', (req, res) => {
    const token = req.headers['authorization'];
  
    if (!token) {
      return res.status(403).json({ message: 'No token provided' });
    }

    verify(token, SECRET_KEY, (err, decoded) => {
      if (err) return res.status(401).json({ message: 'Failed to authenticate token' });
      // Proceed with the request
      return res.status(200).json({ message: 'Access granted', userId: decoded.id });
    });
  });
  
  export default router;