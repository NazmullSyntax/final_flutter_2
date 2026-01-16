import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_profile.dart';

class EditProfilePage extends StatefulWidget {
  final UserProfile profile;
  final Function(UserProfile) onProfileUpdated;

  const EditProfilePage({
    super.key,
    required this.profile,
    required this.onProfileUpdated,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  String? _selectedGender;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _addressController = TextEditingController(text: widget.profile.address);
    _selectedGender = widget.profile.gender;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  void _saveProfile() {
    final updatedProfile = UserProfile(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
      gender: _selectedGender ?? 'Male',
      profileImageUrl: _profileImage != null ? _profileImage!.path : widget.profile.profileImageUrl,
    );

    widget.onProfileUpdated(updatedProfile);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade100,
                      border: Border.all(color: Colors.green.shade300, width: 3),
                      image: _profileImage != null
                          ? DecorationImage(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.cover,
                            )
                          : widget.profile.profileImageUrl != null
                              ? DecorationImage(
                                  image: NetworkImage(widget.profile.profileImageUrl!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                    ),
                    child: _profileImage == null && widget.profile.profileImageUrl == null
                        ? const Icon(Icons.person, size: 50, color: Colors.green)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tap to change photo',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedGender,
              decoration: InputDecoration(
                labelText: 'Gender',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['Male', 'Female', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}