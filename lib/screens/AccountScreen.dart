import 'package:flutter/material.dart';
import 'package:midterm/screens/UpdateProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io'; // Import for handling picked images

import 'ChangeLanguageScreen.dart';
import 'LogoutConfirmationScreen.dart'; // Import UpdateProfileScreen

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Placeholder for user data
  String userName = "Loading...";
  String userEmail = "Loading...";
  bool isLoading = true; // Loading state
  File? _profileImage; // Variable to store the picked image

  // Function to get user data from SharedPreferences
  Future<void> _loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        userName = prefs.getString('username') ?? "chanrithy";
        userEmail = prefs.getString('email') ?? "chanrithy@gmail.com";
        isLoading = false; // Set loading to false once data is fetched
      });
    } catch (e) {
      print("Error loading user data: $e");
      setState(() {
        userName = "Failed to load";
        userEmail = "Failed to load";
        isLoading = false; // Set loading to false even in case of error
      });
    }
  }

  // Function to handle Logout
  void _logout() async {
    // Navigate to the logout confirmation screen
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LogoutConfirmationScreen()),
    );

    // If user confirms logout
    if (result == true) {
      // Perform logout actions, e.g., clearing session, tokens, etc.
      print("Logged out");

      // Clear user data from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('username');
      await prefs.remove('email');

      // After logout, navigate to the login screen
      Navigator.pushReplacementNamed(context, '/login');  // Ensure you have a route to the login screen
    }
  }

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // You can also use ImageSource.camera for taking a photo
    if (image != null) {
      setState(() {
        _profileImage = File(image.path); // Set the picked image
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load the username and email when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[800], // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading // Show loading indicator until data is fetched
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image Section
            GestureDetector(
              onTap: _pickImage, // Tap to pick an image
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage == null
                    ? const AssetImage('assets/images/placeholder.png') // Placeholder if no image selected
                    : FileImage(_profileImage!), // Display the picked image
              ),
            ),
            const SizedBox(height: 20),
            // User Name and Email
            Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(userEmail, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 30),
            // Options Section (My Account, Change Language, Logout)
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("My Account"),
              onTap: () {
                // Navigate to UpdateProfileScreen when "My Account" is clicked
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UpdateProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: const Text("Change Language"),
              onTap: () {
                // Navigate to Change Language screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeLanguageScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              onTap: _logout, // Logout functionality
            ),
          ],
        ),
      ),
    );
  }
}
