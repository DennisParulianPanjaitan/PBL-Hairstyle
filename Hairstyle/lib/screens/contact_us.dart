import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
            'Help and Contact',
            style: TextStyle(
              color: Color(0xFF1B1A55),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TabBar(
                  tabs: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Help',
                        style: TextStyle(
                          color: Color(0xFF1B1A55),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Contact Us',
                        style: TextStyle(
                          color: Color(0xFF1B1A55),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                  indicatorColor: Color(0xFF1B1A55),
                  indicatorWeight: 3,
                  dividerColor: Colors.transparent,
                  labelPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // FAQ Tab
            ListView(
              padding: const EdgeInsets.all(16),
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
                    'Buka aplikasi HairMate.',
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
                    'Anda dapat menghubungi kami melalui Email atau contact lain kami.',
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
            // Contact Us Tab
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[100],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      _buildContactItem(
                        icon: Icons.headphones,
                        title: 'WhatsApp',
                        content: '+62 881036644160',
                        onTap: () {
                          // action for WhatsApp
                        },
                      ),
                      _buildContactItem(
                        icon: Icons.phone,
                        title: 'Phone Number',
                        content: '+11133343535',
                        onTap: () {
                          // action for calling phone number
                        },
                      ),
                      _buildContactItem(
                        icon: Icons.email,
                        title: 'Email',
                        content: 'support@hairmate.com',
                        onTap: () {
                          // action for sending email
                        },
                      ),
                      _buildContactItem(
                        icon: Icons.business,
                        title: 'Office Address',
                        content: '123 HairMate Street, City, Country',
                        onTap: () {
                          // action for showing address
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    String? subtitle,
    required String content,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: Icon(icon, color: Color(0xFF1B1A55)),
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF1B1A55),
            // fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: subtitle != null ? Text(subtitle) : null,
        children: [
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                content,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep(String title, List<String> instructions) {
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
        ...instructions.map(
          (step) => Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              '- $step',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
