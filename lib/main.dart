import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';
import 'screens/activation_screen.dart';
import 'screens/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cash Cow',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/activate': (context) => const ActivationScreen(),
        '/signup': (context) => const SignupScreen(),
        // Dashboard navigates with a token: so use push, not route name
      },
      theme: ThemeData(primarySwatch: Colors.green),
    );
  }
}
