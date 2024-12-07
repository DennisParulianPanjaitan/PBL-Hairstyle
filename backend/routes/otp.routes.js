import { Router } from "express";
import generateOTP from "../utils/generateOTP.js";
import nodemailer from 'nodemailer';
import db from "../databases/config.js";
// import router from "./auth.routes.js";

const router = Router();
// const otps = generateOTP();

// Konfigurasi Nodemailer
const transporter = nodemailer.createTransport({
  service: 'Gmail',
  auth: {
    user: 'hairstyle.k13a@gmail.com',
    pass: 'AfrizalDennisDidoPaksi',
  },
});

async function simpanOtp (otp, username, email) {
  await db.query(`
    UPDATE users 
      SET otp = ${otp}
      WHERE username = ${username} AND email = ${email};
  `);
}
async function getOtp (username, email) {
  const [ result ] = await db.query(`
    SELECT otp
      WHERE username = ${username} AND email = ${email};
  `);
  return result[0].otp;
}
async function deleteOtp (username, email) {
  await db.query(`
    UPDATE users
      SET otp = NULL, status = 'activated'
      WHERE username = ${username} AND email = ${email};
  `);
}
router.post('/send-otp', async (req, res) => {
  const { username, email } = req.body;

  if (!username || !email) {
    return res.status(400).json({ error: 'Email and username is required' });
  }

  const otp = generateOTP();
  await simpanOtp(otp, email, username); // Simpan OTP sementara

  try {
    await transporter.sendMail({
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

  const storedOtp = getOtp(username, email);

  if (storedOtp === otp) {
    // Hapus OTP setelah diverifikasi
    // otps.delete(email);
    deleteOtp(username, email)
    return res.status(200).json({ message: 'OTP verified successfully' });
  }

  res.status(400).json({ error: 'Invalid OTP' });
});
export default router;
// Jalankan server
// const PORT = 3000;
// app.listen(PORT, () => console.log(`Server running on port ${PORT}`));