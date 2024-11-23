import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picker
import 'dart:io'; // To use File for the selected image

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  File? _profileImage; // Variable to store the selected image
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  // Function to pick an image
  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Use the gallery to pick an image
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path); // Set the selected image to the profileImage variable
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            GestureDetector(
              onTap: _pickImage, // Allow the user to tap and select an image
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) // If image is selected, display it
                    : const AssetImage('assets/images/placeholder.png') as ImageProvider, // Placeholder image
                child: _profileImage == null ? const Icon(Icons.camera_alt, size: 30) : null,
              ),
            ),
            const SizedBox(height: 20),
            // Form Fields Section
            TextField(
              decoration: const InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),
            // Update Button
            ElevatedButton(
              onPressed: () {
                // Handle update logic here
                print("Profile updated");
              },
              child: const Text('UPDATE'),
            ),
          ],
        ),
      ),
    );
  }
}
