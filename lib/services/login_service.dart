// File: lib/services/login_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cash_cow_app/constants.dart' as constants;

class LoginService {
  // Method to perform user login
  static Future<String> login(String email, String password) async {
    try {
      // Route URL for login endpoint
      final url = Uri.parse('${constants.apiBaseUrl}login/');

      // Make POST request to login endpoint
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      // Check if the response indicates a successful login
      if (response.statusCode == 201) {
        // Parse the response body
        final Map<String, dynamic> resJson = jsonDecode(response.body);

        // Extract token from response envelope (from your API contract)
        final tokenSection = resJson['authentication_token'];
        if (tokenSection != null && tokenSection['plaintext'] != null) {
          return tokenSection['plaintext'];
        } else {
          throw Exception('Malformed response from server.');
        }
      } else if (response.statusCode == 422) {
        // Unprocessable Entity - Invalid credentials
        final Map<String, dynamic> resJson = jsonDecode(response.body);
        final errorMessage = resJson['error'] ?? 'Invalid credentials.';
        throw Exception(errorMessage);
      } else {
        // Other error responses
        throw Exception('Failed to login. Please try again later.');
      }
    } catch (e) {
      // Handle exceptions and rethrow them
      throw Exception('Login error: $e');
    }
  }
}
