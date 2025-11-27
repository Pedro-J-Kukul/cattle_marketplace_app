import 'package:flutter/material.dart';
import '../services/activation_service.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  final tokenController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;

  @override
  void dispose() {
    tokenController.dispose();
    super.dispose();
  }

  Future<void> _handleActivate() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final token = tokenController.text.trim();
    if (token.isEmpty) {
      setState(() {
        isLoading = false;
        errorMessage = 'Please enter your activation token.';
      });
      return;
    }

    try {
      await ActivationService.activate(token);
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      // Success: go to login
      Navigator.pushReplacementNamed(context, '/login');
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
      appBar: AppBar(title: const Text('Activate Account')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Check your email for your activation token.'),
              const SizedBox(height: 10),
              TextField(
                controller: tokenController,
                decoration: const InputDecoration(
                  labelText: "Activation Token",
                ),
              ),
              const SizedBox(height: 16),
              if (errorMessage != null)
                Text(errorMessage!, style: const TextStyle(color: Colors.red)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _handleActivate,
                  child: isLoading
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        )
                      : const Text('Activate'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
