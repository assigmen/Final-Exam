import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../services/AuthService.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  final AuthService _authService = AuthService(); // Initialize AuthService instance

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      // Check if username already exists using AuthService
      bool isRegistered = await _authService.register(username, password, email);

      if (!isRegistered) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username already exists.')),
        );
        return;
      }

      // If registration is successful, show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );

      // Navigate back to the login screen after successful registration
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onChanged: (value) => firstName = value,
                validator: (value) =>
                value!.isEmpty ? 'Please enter your first name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onChanged: (value) => lastName = value,
                validator: (value) =>
                value!.isEmpty ? 'Please enter your last name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                onChanged: (value) => username = value,
                validator: (value) =>
                value!.isEmpty ? 'Please enter a username' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => email = value,
                validator: (value) =>
                value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) => password = value,
                validator: (value) =>
                value!.isEmpty ? 'Please enter a password' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                onChanged: (value) => confirmPassword = value,
                validator: (value) =>
                value != password ? 'Passwords do not match' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerUser,
                child: Text('CREATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
