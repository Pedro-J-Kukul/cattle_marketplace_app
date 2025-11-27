// File: lib/services/activate_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cash_cow_app/constants.dart' as constants;

class ActivationService {
  static Future<void> activate(String token) async {
    final url = Uri.parse('${constants.apiBaseUrl}users/activate');
    final body = {'token': token};

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Account activated!
      return;
    } else if (response.statusCode == 422 || response.statusCode == 400) {
      final resJson = jsonDecode(response.body);
      throw Exception(
        resJson['error'] ?? 'Invalid or expired activation token.',
      );
    } else {
      throw Exception('Activation failed. Try again later.');
    }
  }
}
