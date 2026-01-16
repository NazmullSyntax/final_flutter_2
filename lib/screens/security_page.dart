import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Security Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('2-Step Verification'),
                  subtitle: const Text('Secure your account'),
                  value: true,
                  onChanged: (value) {},
                  secondary: const Icon(Icons.security),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Biometric Login'),
                  subtitle: const Text('Use fingerprint or face ID'),
                  value: true,
                  onChanged: (value) {},
                  secondary: const Icon(Icons.fingerprint),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Mobile Number Verification'),
                  subtitle: const Text('Verified'),
                  trailing: const Icon(Icons.verified, color: Colors.green),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email Verification'),
                  subtitle: const Text('Verified'),
                  trailing: const Icon(Icons.verified, color: Colors.green),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.devices),
                  title: const Text('Login Devices'),
                  subtitle: const Text('3 devices'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.history),
                  title: const Text('Login History'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications_active),
                  title: const Text('Security Alerts'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title:
                  const Text('Delete Account', style: TextStyle(color: Colors.red)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Account'),
                    content: const Text(
                        'Are you sure you want to delete your account? This action cannot be undone.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}