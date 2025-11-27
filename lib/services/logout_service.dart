// File: lib/services/logout_service.dart
import 'package:http/http.dart' as http;
import 'package:cash_cow_app/constants.dart' as constants;

// You will need to pass the token in the Authorization header!
class LogoutService {
  static Future<void> logout(String token) async {
    final url = Uri.parse('${constants.apiBaseUrl}tokens/authentication');
    final response = await http.delete(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 204) {
      // Successfully logged out
      return;
    } else {
      throw Exception('Failed to log out.');
    }
  }
}
