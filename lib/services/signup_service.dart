// File: lib/services/signup_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cash_cow_app/constants.dart' as constants;

class SignupService {
  static Future<void> signup({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String farmerID,
    required String phoneNumber,
  }) async {
    final url = Uri.parse('${constants.apiBaseUrl}users');
    final body = {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'farmer_id': farmerID,
      'phone_number': phoneNumber,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      // Success! User created, await email for activation.
      return;
    } else if (response.statusCode == 422 || response.statusCode == 400) {
      final resJson = jsonDecode(response.body);
      throw Exception(resJson['error'] ?? 'Could not register user.');
    } else {
      throw Exception('Registration failed. Try again later.');
    }
  }
}
