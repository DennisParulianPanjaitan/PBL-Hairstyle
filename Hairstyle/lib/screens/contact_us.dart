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
                  'Welcome to our Help and Support page. If you need assistance on how to use the HairMate application, follow the steps below to get started and make use of the available features.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Steps to Use the HairMate Application',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B1A55)),
                ),
                const SizedBox(height: 16),
                _buildStep(
                  'Account Registration',
                  [
                    'Open the HairMate application.',
                    'Select the Register option on the main page.',
                    'Fill in the required information such as name, email, and password.',
                    'Click Register to create your account. You will receive a confirmation email for verification.',
                  ],
                ),
                const SizedBox(height: 16),
                _buildStep(
                  'Login to Your Account',
                  [
                    'After successfully registering, open the app and select Login.',
                    'Enter the email and password you registered with.',
                    'Click Login to access the application.',
                  ],
                ),
                const SizedBox(height: 16),
                _buildStep(
                  'Uploading a Face Photo',
                  [
                    'On the main page of the app, select the Scan or Upload Photo menu.',
                    'Choose your face photo from the gallery or take a new photo using the camera.',
                    'Ensure the photo is taken with good lighting for more accurate detection results.',
                  ],
                ),
                const SizedBox(height: 16),
                _buildStep(
                  'Getting Hairstyle Recommendations',
                  [
                    'Once the face photo is successfully uploaded, the app will process the image to detect your face shape.',
                    'Based on the detected face shape, the app will provide several hairstyle recommendations that suit you.',
                    'You can view hairstyle images and choose the style that best matches your preference.',
                  ],
                ),
                const SizedBox(height: 16),
                _buildStep(
                  'Saving and Managing Recommendations',
                  [
                    'If you are interested in a recommended hairstyle, select the Save or Add to Wishlist option.',
                    'You can access the saved hairstyles through the Wishlist menu in the app.',
                  ],
                ),
                const SizedBox(height: 16),
                _buildStep(
                  'Managing Your Profile',
                  [
                    'To update your personal information, go to the Profile menu.',
                    'On the profile page, you can change your profile photo, name, email, and other preferences.',
                    'Click Save Changes to update the information.',
                  ],
                ),
                const SizedBox(height: 16),
                _buildStep(
                  'Contacting Customer Support',
                  [
                    'If you have any issues or questions, select the Contact Us menu.',
                    'You can contact us via Email or other contact options.',
                    'If you need further information or have other questions, do not hesitate to contact our support team via email or other available contacts.',
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'By following the steps above, you can easily use HairMate and get the best hairstyle recommendations based on your face shape.',
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
                        content: '123 True Street, Malang, Indonesia',
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
