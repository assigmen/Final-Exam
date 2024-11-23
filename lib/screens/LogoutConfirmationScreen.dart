import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:midterm/screens/LoginScreen.dart'; // Import LoginScreen

class LogoutConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logout Confirmation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you sure you want to log out?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // No need to clear anything, just navigate to LoginScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('YES'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the confirmation dialog
                  },
                  child: Text('NO'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
