import { Router } from "express";
import 'dotenv/config';
import db from "../databases/config.js";

const router = Router();

router.post('/registrasi', async (req, res) => {
  const { username, email, password } = req.body;
    
  if (!username || !email || !password) {
    return res.status(400).json({ error: 'Seluruh isian harus diisi' });
  }
  const [ checkUsername ] = await db.query(`SELECT id FROM users WHERE username = '${username}'`);
    
  if (checkUsername.length > 0) {
    return res.status(400).json({ error: 'Username sudah terdaftar' });
  }
  
  try {
    await db.query(`
      INSERT INTO users (username, email, password, status)
        VALUES ('${username}', '${email}', '${password}','activated');
    `);
    res.status(200).json({ message: 'Registrasi berhasil', berhasil: true});
  } catch (err) {
    res.status(500).json({ error: `Kesalahan:\n${err}` });
  }
});

export default router;