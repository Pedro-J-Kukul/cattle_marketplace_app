import 'package:flutter/material.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/activation_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/settings/settings_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sales Management',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/activate': (context) => const ActivationScreen(),
        '/signup': (context) => const SignupScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            elevation: 2,
          ),
        ),
      ),
    );
  }
}
