import 'package:flutter/material.dart';
import '../main.dart';

class ChangeLanguageScreen extends StatefulWidget {
  @override
  _ChangeLanguageScreenState createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  bool _isKhmer = false;

  void _changeLanguage(bool isKhmer) {
    setState(() {
      _isKhmer = isKhmer;
      Locale newLocale = isKhmer ? const Locale('kh') : const Locale('en');
      MyApp.setLocale(context, newLocale); // Update the app language
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Language'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Khmer Language Option
            ListTile(
              title: const Text('Khmer'),
              trailing: _isKhmer ? const Icon(Icons.check) : null,
              onTap: () => _changeLanguage(true),
            ),
            // English Language Option
            ListTile(
              title: const Text('English'),
              trailing: !_isKhmer ? const Icon(Icons.check) : null,
              onTap: () => _changeLanguage(false),
            ),
          ],
        ),
      ),
    );
  }
}
