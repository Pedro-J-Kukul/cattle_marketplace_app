import 'package:flutter/material.dart';
import '../services/signup_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final farmerIdController = TextEditingController();
  final phoneNumberController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    farmerIdController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text;
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final farmerId = farmerIdController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if ([
      email,
      password,
      firstName,
      lastName,
      farmerId,
      phoneNumber,
    ].any((e) => e.isEmpty)) {
      setState(() {
        isLoading = false;
        errorMessage = 'Please fill out all fields.';
      });
      return;
    }

    try {
      await SignupService.signup(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        farmerID: farmerId,
        phoneNumber: phoneNumber,
      );
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      // Success: Transition to activation
      Navigator.pushReplacementNamed(context, '/activate');
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: "First Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: "Last Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: farmerIdController,
                decoration: const InputDecoration(labelText: "Farmer ID"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              const SizedBox(height: 16),
              if (errorMessage != null)
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleSignup,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        )
                      : const Text('Sign Up'),
                ),
              ),
              TextButton(
                onPressed: isLoading
                    ? null
                    : () => Navigator.pushReplacementNamed(context, '/login'),
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
