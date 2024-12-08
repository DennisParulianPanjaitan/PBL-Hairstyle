import { Router } from "express";
import 'dotenv/config';
// import generateOTP from "../utils/generateOTP.js";
import nodemailer from 'nodemailer';
import db from "../databases/config.js";
// import router from "./auth.routes.js";

const router = Router();
// const otps = generateOTP();
import { customAlphabet } from 'nanoid/non-secure';
import { Error } from "sequelize";
const nanoid = customAlphabet('1234567890abcdef', 4);
// Konfigurasi Nodemailer
// const transporter = nodemailer.createTransport({
//   service: 'Gmail',
//   auth: {
//     user: process.env.EMAIL_USERNAME,
//     pass: process.env.EMAIL_PASSWORD,
//   },
// });
const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 587, // Gunakan 465 jika memakai SSL
  secure: false, // Ubah menjadi true jika port 465
  auth: {
    user: process.env.EMAIL_USERNAME, // Ganti dengan email Gmail Anda
    pass: process.env.EMAIL_PASSWORD,   // Gunakan password aplikasi (bukan password Gmail biasa)
  },
  tls: {
    rejectUnauthorized: true,
  },
});

async function simpanOtp (otp, username, email) {
  await db.query(`
    INSERT INTO users (username, email, otp, status)
      VALUES ('${username}', '${email}', '${otp}', 'register');
  `);
  
  // await db.query(`
  //   UPDATE users 
  //     SET otp = ${otp}
  //     WHERE username = ${username} AND email = ${email};
  // `);
}
async function getOtp (username, email) {
  const [ result ] = await db.query(`
    SELECT otp
      FROM users
      WHERE username = '${username}' AND email = '${email}';
  `);
  return result[0].otp;
}
async function deleteOtp (username, email) {
  await db.query(`
    UPDATE users
      SET otp = NULL, status = 'activated'
      WHERE username = '${username}' AND email = '${email}';
  `);
}
router.post('/send-otp', async (req, res) => {
  const { username, email } = req.body;
  
  if (!username || !email) {
    return res.status(400).json({ error: 'Email and username is required' });
  }
  const [ checkUsername ] = await db.query(`SELECT id FROM users WHERE username = '${username}'`);
  
   if (checkUsername.length > 0) {
    return res.status(400).json({ error: 'Username already exists' });
  }

  const otp = nanoid();
  await simpanOtp(otp, username, email); // Simpan OTP sementara
  try {
    await transporter.sendMail({
      from: process.env.EMAIL_USERNAME,
      to: email,
      subject: 'Kode OTP - Aplikasi Rekomendasi Hairstyle',
      text: `Your OTP is: ${otp}\nJika Anda tidak merasa telah mendaftar dengan email ini, Anda dapat mengabaikan email ini dan pendaftaran tidak akan berhasil`,
    });
    res.status(200).json({ message: 'OTP sent successfully' });
  } catch (err) {
    res.status(500).json({ error: `Failed to send OTP:\n${err}` });
  }
});

// Endpoint untuk verifikasi OTP
router.post('/verify-otp', async (req, res) => {
  const { username, email, otp } = req.body;

  if (!email || !otp) {
    return res.status(400).json({ error: 'Email and OTP are required' });
  }

  const storedOtp = await getOtp(username, email);
  if (storedOtp === otp) {
    // Hapus OTP setelah diverifikasi
    // otps.delete(email);
    await db.query(`
      UPDATE users 
        SET otp = '', status = 'activated'
        WHERE username = '${username}';
    `);
    await deleteOtp(username, email)
    return res.status(200).json({ message: 'OTP verified successfully' });
  }

  res.status(400).json({ error: `Invalid OTP. storedotp: ${storedOtp} with type ${typeof storedOtp}, otpinput: ${otp} with type ${typeof otp}` });
});

export default router;
// Jalankan server
// const PORT = 3000;
// app.listen(PORT, () => console.log(`Server running on port ${PORT}`));