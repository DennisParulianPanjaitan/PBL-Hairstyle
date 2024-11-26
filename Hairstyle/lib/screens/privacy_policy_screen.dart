import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
          'Privacy Policy',
          style: TextStyle(
            color: Color(0xFF1B1A55),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'HairMate sangat menghargai privasi Anda. Kebijakan ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi data pribadi Anda saat menggunakan aplikasi kami. Dengan menggunakan aplikasi ini, Anda menyetujui ketentuan dalam kebijakan privasi ini.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),

            // 1. Informasi yang Kami Kumpulkan
            Text(
              'Informasi yang Kami Kumpulkan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Warna biru untuk judul
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Kami mengumpulkan informasi yang Anda berikan secara langsung, seperti data diri, email, dan informasi lainnya. Selain itu, kami juga mengumpulkan foto wajah yang diunggah untuk mendeteksi bentuk wajah dan memberikan rekomendasi gaya rambut.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 2. Penggunaan Informasi
            Text(
              'Penggunaan Informasi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Warna biru untuk judul
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Informasi yang kami kumpulkan digunakan untuk menyediakan layanan inti aplikasi, seperti analisis bentuk wajah dan rekomendasi gaya rambut. Selain itu, data juga dapat digunakan untuk mempersonalisasi layanan dan mengirimkan pembaruan terkait aplikasi. Kami tidak menjual atau menyewakan informasi pribadi Anda kepada pihak ketiga. Dalam beberapa kasus, data Anda dapat dibagikan dengan penyedia layanan pihak ketiga yang membantu kami dalam memproses informasi tersebut, atau jika diwajibkan oleh hukum.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 3. Perlindungan Data
            Text(
              'Perlindungan Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Warna biru untuk judul
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Kami berkomitmen untuk melindungi data Anda dengan menerapkan langkah-langkah keamanan teknis dan organisasi yang sesuai. Meskipun kami berupaya keras menjaga keamanan data Anda, tidak ada sistem yang sepenuhnya bebas risiko. Kami menyarankan Anda untuk menjaga keamanan informasi pribadi Anda juga.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 4. Hak Anda
            Text(
              'Hak Anda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Warna biru untuk judul
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Anda memiliki hak untuk mengakses, memperbaiki, atau menghapus data pribadi Anda kapan saja. Anda juga dapat menarik persetujuan untuk pengolahan data tertentu. Jika Anda ingin menggunakan hak-hak ini, Anda dapat menghubungi kami. Kami akan berusaha merespons permintaan Anda secepat mungkin.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 5. Perubahan Kebijakan
            Text(
              'Perubahan Kebijakan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Warna biru untuk judul
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Kebijakan privasi ini dapat diperbarui dari waktu ke waktu untuk mencerminkan perubahan dalam layanan atau persyaratan hukum. Jika ada pembaruan, kami akan memberi tahu Anda melalui aplikasi atau metode lain yang sesuai. Dengan terus menggunakan aplikasi setelah pembaruan, Anda dianggap menyetujui kebijakan privasi yang diperbarui.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 6. Hubungi Kami
            Text(
              'Hubungi Kami',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Warna biru untuk judul
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Jika Anda memiliki pertanyaan atau kekhawatiran terkait kebijakan privasi ini, Anda dapat menghubungi kami.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        ...content.map((item) => _buildBulletPoint(item)),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
