import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Need Help?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'We\'re here to help you with any questions or issues you may have.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  _buildContactOption(
                    Icons.phone,
                    'Call Us',
                    '09678-123456',
                    '24/7 Customer Support',
                    () {
                      _launchUrl('tel:09678123456');
                    },
                  ),
                  _buildContactOption(
                    Icons.email,
                    'Email Us',
                    'support@kilagbe.com',
                    'Response within 24 hours',
                    () {
                      _launchUrl('mailto:support@kilagbe.com');
                    },
                  ),
                  _buildContactOption(
                    Icons.chat,
                    'Live Chat',
                    'Start Chat',
                    'Available 9AM-11PM',
                    () {
                      _showLiveChatDialog(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                _buildFAQItem(
                  'How do I place an order?',
                  'Browse products, add to cart, proceed to checkout, enter shipping details, select payment method, and confirm order.',
                ),
                _buildFAQItem(
                  'What payment methods do you accept?',
                  'We accept bKash, Nagad, Rocket, Visa/MasterCard, and Cash on Delivery.',
                ),
                _buildFAQItem(
                  'How long does delivery take?',
                  'Dhaka: 1-2 days, Other cities: 3-5 days, Remote areas: 5-7 days.',
                ),
                _buildFAQItem(
                  'Can I return a product?',
                  'Yes, you can return products within 7 days of delivery. Products must be unused and in original packaging.',
                ),
                _buildFAQItem(
                  'How do I track my order?',
                  'Go to My Orders section, select your order, and click Track Order. You\'ll receive SMS updates.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Common Issues & Solutions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            child: Column(
              children: [
                _buildIssueItem(
                  'Payment Failed',
                  '• Check internet connection\n• Ensure sufficient balance\n• Try different payment method\n• Contact your bank',
                ),
                _buildIssueItem(
                  'Order Not Delivered',
                  '• Check delivery status in My Orders\n• Contact delivery executive\n• Call our support team\n• Check address details',
                ),
                _buildIssueItem(
                  'Wrong Product Received',
                  '• Contact support immediately\n• Provide order ID and photos\n• Do not open packaging\n• We\'ll arrange replacement',
                ),
                _buildIssueItem(
                  'App Not Working',
                  '• Update to latest version\n• Clear app cache\n• Check internet connection\n• Reinstall the app',
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Report an Issue',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Having trouble? Let us know and we\'ll help you resolve it.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Describe your issue in detail...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _showReportSubmittedDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Submit Report'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(IconData icon, String title, String value, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: const Color(0xFF2E7D32)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontSize: 16)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: const TextStyle(fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(answer, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Widget _buildIssueItem(String issue, String solution) {
    return ExpansionTile(
      title: Text(issue, style: const TextStyle(fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(solution, style: const TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showLiveChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Live Chat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Our customer service representatives are available to chat with you.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _launchUrl('https://wa.me/8801234567890');
              },
              child: const Text('Start WhatsApp Chat'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showReportSubmittedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report Submitted'),
        content: const Text('Thank you for reporting the issue. Our support team will contact you within 24 hours.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}