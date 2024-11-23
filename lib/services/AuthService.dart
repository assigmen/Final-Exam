import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // For JSON encoding/decoding

class AuthService {
  // Register new user
  Future<bool> register(String username, String password, String email) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the list of existing users (or an empty list if none)
    List<String> usersList = prefs.getStringList('users') ?? [];

    // Check if the user already exists
    if (usersList.any((userJson) {
      Map<String, dynamic> user = json.decode(userJson);
      return user['username'] == username;
    })) {
      return false; // User already exists
    }

    // Create a new user object and add it to the list
    Map<String, String> newUser = {'username': username, 'password': password, 'email': email};
    usersList.add(json.encode(newUser));

    // Save the updated list back to SharedPreferences
    await prefs.setStringList('users', usersList);

    return true; // Registration successful
  }

  // Login user
  Future<bool> login(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the list of users
    List<String> usersList = prefs.getStringList('users') ?? [];

    // Check if the user exists and the password matches
    bool userFound = usersList.any((userJson) {
      Map<String, dynamic> user = json.decode(userJson);
      return user['username'] == username && user['password'] == password;
    });

    if (userFound) {
      // Save the logged-in user's username and email in SharedPreferences
      await _saveLoggedInUser(username);
    }

    return userFound;
  }

  // Save the logged-in user's data
  Future<void> _saveLoggedInUser(String username) async {
    final prefs = await SharedPreferences.getInstance();

    // Get the list of users
    List<String> usersList = prefs.getStringList('users') ?? [];

    // Find the user in the list
    Map<String, dynamic>? loggedInUser;
    for (var userJson in usersList) {
      Map<String, dynamic> user = json.decode(userJson);
      if (user['username'] == username) {
        loggedInUser = user;
        break;
      }
    }

    if (loggedInUser != null) {
      // Store the logged-in user's details in SharedPreferences
      await prefs.setString('loggedInUsername', loggedInUser['username'] ?? '');
      await prefs.setString('loggedInEmail', loggedInUser['email'] ?? '');
    }
  }

  // Get logged-in user's data
  Future<Map<String, String?>> getLoggedInUserData() async {
    final prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString('loggedInUsername');
    String? email = prefs.getString('loggedInEmail');

    return {
      'username': username,
      'email': email,
    };
  }

  // Log out the user by clearing saved data
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInUsername');
    await prefs.remove('loggedInEmail');
  }
}
