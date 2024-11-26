import 'package:flutter/material.dart';

class HelpAndSupportScreen extends StatelessWidget {
  const HelpAndSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/arrow.png',
            width: 40,
            height: 40,
          ),
          onPressed: () => Navigator.pop(context),
          color: Color(0xFF1B1A55),
        ),
        title: const Text(
          'Help and Support',
          style: TextStyle(
            color: Color(0xFF1B1A55),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Selamat datang di halaman Bantuan dan Dukungan kami. Jika Anda membutuhkan bantuan tentang cara menggunakan aplikasi HairMate, ikuti langkah-langkah di bawah ini untuk memulai dan memanfaatkan fitur-fitur yang tersedia.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 24),
              const Text(
                'Langkah-langkah Penggunaan Aplikasi HairMate',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B1A55)),
              ),
              const SizedBox(height: 16),
              _buildStep(
                'Pendaftaran Akun',
                [
                  'Buka aplikasi [Nama Aplikasi].',
                  'Pilih opsi Daftar di halaman utama.',
                  'Isi informasi yang diperlukan seperti nama, email, dan kata sandi.',
                  'Klik Daftar untuk membuat akun Anda. Anda akan menerima email konfirmasi untuk verifikasi.',
                ],
              ),
              const SizedBox(height: 16),
              _buildStep(
                'Login ke Akun',
                [
                  'Setelah berhasil mendaftar, buka aplikasi dan pilih Masuk.',
                  'Masukkan email dan kata sandi yang telah Anda daftarkan.',
                  'Klik Masuk untuk mengakses aplikasi.',
                ],
              ),
              const SizedBox(height: 16),
              _buildStep(
                'Mengunggah Foto Wajah',
                [
                  'Pada halaman utama aplikasi, pilih menu Scan atau Unggah Foto.',
                  'Pilih foto wajah Anda dari galeri atau ambil foto baru menggunakan kamera.',
                  'Pastikan foto diambil dengan pencahayaan yang baik untuk hasil deteksi yang lebih akurat.',
                ],
              ),
              const SizedBox(height: 16),
              _buildStep(
                'Mendapatkan Rekomendasi Gaya Rambut',
                [
                  'Setelah foto wajah berhasil diunggah, aplikasi akan memproses gambar untuk mendeteksi bentuk wajah Anda.',
                  'Berdasarkan deteksi bentuk wajah, aplikasi akan memberikan beberapa rekomendasi gaya rambut yang cocok.',
                  'Anda dapat melihat gambar model rambut dan memilih gaya yang paling sesuai dengan preferensi Anda.',
                ],
              ),
              const SizedBox(height: 16),
              _buildStep(
                'Menyimpan dan Mengelola Rekomendasi',
                [
                  'Jika Anda tertarik dengan gaya rambut yang direkomendasikan, pilih opsi Simpan atau Tambahkan ke Wishlist untuk menyimpannya.',
                  'Anda dapat mengakses gaya rambut yang telah disimpan melalui menu Wishlist di aplikasi.',
                ],
              ),
              const SizedBox(height: 16),
              _buildStep(
                'Mengatur Profil Pengguna',
                [
                  'Untuk memperbarui informasi pribadi Anda, buka menu Profil.',
                  'Di halaman profil, Anda dapat mengubah foto profil, nama, email, dan preferensi lainnya.',
                  'Klik Simpan Perubahan untuk memperbarui informasi.',
                ],
              ),
              const SizedBox(height: 16),
              _buildStep(
                'Menghubungi Dukungan Pelanggan',
                [
                  'Jika Anda memiliki masalah atau pertanyaan, pilih menu Contact us.',
                  'Anda dapat menghubungi kami melalui Email atau contact lain kami .',
                  'Jika Anda membutuhkan informasi lebih lanjut atau memiliki pertanyaan lain, jangan ragu untuk menghubungi tim dukungan kami melalui email atau contact lain kami.',
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Dengan langkah-langkah di atas, Anda dapat dengan mudah menggunakan HairMate dan mendapatkan rekomendasi gaya rambut terbaik berdasarkan bentuk wajah Anda.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String title, List<String> description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B1A55),
          ),
        ),
        const SizedBox(height: 8),
        ...description.map(
          (item) => Text(
            '• $item',
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}
