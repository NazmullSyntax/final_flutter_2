import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ki Lagbe - Bangladesh Marketplace',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Favorite Shopping Partner',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Text(
              'Our Story',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Ki Lagbe was founded in 2023 with a simple mission: to make online shopping accessible, affordable, and convenient for everyone in Bangladesh. We believe that everyone deserves access to quality products at fair prices.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            const Text(
              'Our Mission',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'To become Bangladesh\'s most trusted and loved online marketplace by providing exceptional value, quality products, and outstanding customer service.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            const Text(
              'Contact Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildContactInfo(Icons.location_on, 'Head Office', '123 Business Street, Dhaka-1212, Bangladesh'),
            _buildContactInfo(Icons.phone, 'Phone', '+880 9678-123456'),
            _buildContactInfo(Icons.email, 'Email', 'info@kilagbe.com'),
            _buildContactInfo(Icons.access_time, 'Business Hours', 'Saturday - Thursday: 9:00 AM - 11:00 PM'),
            const SizedBox(height: 30),
            const Text(
              'Follow Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook, color: Colors.blue, size: 40),
                  onPressed: () {
                    _launchUrl('https://facebook.com/kilagbe');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.pink, size: 40),
                  onPressed: () {
                    _launchUrl('https://instagram.com/kilagbe');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.red, size: 40),
                  onPressed: () {
                    _launchUrl('https://youtube.com/kilagbe');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.message, color: Colors.green, size: 40),
                  onPressed: () {
                    _launchUrl('https://wa.me/8801234567890');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF2E7D32)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(value, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
}