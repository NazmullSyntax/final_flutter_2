import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class EditAddressPage extends StatefulWidget {
  final UserProfile profile;
  final Function(UserProfile) onProfileUpdated;

  const EditAddressPage({
    super.key,
    required this.profile,
    required this.onProfileUpdated,
  });

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _postalCodeController;
  String? _selectedDivision;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.profile.address);
    _cityController = TextEditingController(text: 'Dhaka');
    _postalCodeController = TextEditingController(text: '1209');
    _selectedDivision = 'Dhaka';
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  void _saveAddress() {
    final updatedProfile = UserProfile(
      name: widget.profile.name,
      email: widget.profile.email,
      phone: widget.profile.phone,
      address: _addressController.text,
      gender: widget.profile.gender,
      profileImageUrl: widget.profile.profileImageUrl,
    );

    widget.onProfileUpdated(updatedProfile);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Address updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Address'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'House/Flat/Road No.',
                hintText: 'Enter your complete address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedDivision,
              decoration: InputDecoration(
                labelText: 'Division',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['Dhaka', 'Chittagong', 'Rajshahi', 'Khulna', 'Barisal', 'Sylhet', 'Rangpur', 'Mymensingh']
                  .map((division) => DropdownMenuItem(
                        value: division,
                        child: Text(division),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDivision = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'City/Thana',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _postalCodeController,
              decoration: InputDecoration(
                labelText: 'Postal Code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveAddress,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Address',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Saved Addresses',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Color(0xFF2E7D32)),
                title: const Text('Home Address'),
                subtitle: const Text('House #123, Road #45, Dhanmondi, Dhaka-1209'),
                trailing: const Icon(Icons.check_circle, color: Colors.green),
                onTap: () {
                  _addressController.text = 'House #123, Road #45, Dhanmondi, Dhaka';
                  _cityController.text = 'Dhaka';
                  _postalCodeController.text = '1209';
                  _selectedDivision = 'Dhaka';
                },
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on, color: Color(0xFF2E7D32)),
                title: const Text('Office Address'),
                subtitle: const Text('Building #78, Gulshan-1, Dhaka-1212'),
                trailing: const Icon(Icons.radio_button_unchecked),
                onTap: () {
                  _addressController.text = 'Building #78, Gulshan-1, Dhaka';
                  _cityController.text = 'Dhaka';
                  _postalCodeController.text = '1212';
                  _selectedDivision = 'Dhaka';
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}