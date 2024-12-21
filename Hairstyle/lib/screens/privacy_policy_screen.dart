import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              'HairMate greatly values your privacy. This policy explains how we collect, use, and protect your personal data when using our application. By using this application, you agree to the terms of this privacy policy.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),

            // 1. Information We Collect
            Text(
              'Information We Collect',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Blue for title
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We collect information you directly provide, such as personal details, email, and other information. In addition, we collect uploaded facial photos to detect face shapes and provide hairstyle recommendations.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 2. Use of Information
            Text(
              'Use of Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Blue for title
              ),
            ),
            SizedBox(height: 8),
            Text(
              'The information we collect is used to provide core application services, such as face shape analysis and hairstyle recommendations. Additionally, the data may be used to personalize services and send updates related to the application. We do not sell or rent your personal information to third parties. In some cases, your data may be shared with third-party service providers who help us process this information, or if required by law.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 3. Data Protection
            Text(
              'Data Protection',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Blue for title
              ),
            ),
            SizedBox(height: 8),
            Text(
              'We are committed to protecting your data by implementing appropriate technical and organizational security measures. Although we work hard to maintain the security of your data, no system is completely risk-free. We also advise you to safeguard your personal information.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 4. Your Rights
            Text(
              'Free Access',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Blue for title
              ),
            ),
            SizedBox(height: 8),
            Text(
              'You have the right to access, correct, or delete your personal data at any time. You can also withdraw your consent for specific data processing. If you wish to exercise these rights, you can contact us. We will do our best to respond to your request as quickly as possible.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 5. Policy Changes
            Text(
              'Policy Changes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Blue for title
              ),
            ),
            SizedBox(height: 8),
            Text(
              'This privacy policy may be updated from time to time to reflect changes in services or legal requirements. If there are updates, we will notify you through the application or other appropriate methods. By continuing to use the application after updates, you are deemed to agree to the updated privacy policy.',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF3A3A3A),
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            // 6. Contact Us
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B1A55), // Blue for title
              ),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions or concerns regarding this privacy policy, you can contact us.',
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
