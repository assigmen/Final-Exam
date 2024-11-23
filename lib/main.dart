import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:midterm/screens/LoginScreen.dart';
import 'package:midterm/services/localization.dart'; // The localization service

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  // Static method to access setLocale
  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en'); // Default locale set to English

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizationsDelegate(), // Custom delegate for localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Ensures Cupertino widget localization
      ],
      supportedLocales: [
        Locale('en', ''), // English
        Locale('kh', ''), // Khmer
      ],
      locale: _locale, // Set the locale dynamically
      home: LoginScreen(), // Your initial screen
    );
  }
}
