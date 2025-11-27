// File: lib/services/auth_service.dart

import 'dart:convert';
import '../models/auth.dart';
import '../models/user.dart';
import '../utils/preferences.dart';
import 'api_service.dart';

class AuthService {
  // Login user
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await ApiService.post(
        '/v1/tokens/authentication',
        {'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        final authToken = AuthToken.fromJson(json['authentication_token']);
        final user = User.fromJson(json['user']);

        // Save token and user info
        await AppPreferences.saveAuthToken(authToken.token);
        await AppPreferences.saveUserId(user.id);
        await AppPreferences.saveUserRole(user.role);

        return {
          'token': authToken.token,
          'user': user,
        };
      } else if (response.statusCode == 401 || response.statusCode == 422) {
        throw Exception(ApiService.parseError(response));
      } else {
        throw Exception('Failed to login. Please try again later.');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  // Logout user
  static Future<void> logout() async {
    try {
      final response = await ApiService.delete(
        '/v1/tokens/authentication',
        includeAuth: true,
      );

      if (response.statusCode == 204) {
        await AppPreferences.clearUserData();
      } else {
        throw Exception('Failed to logout');
      }
    } catch (e) {
      // Clear local data even if server request fails
      await AppPreferences.clearUserData();
      throw Exception('Logout error: $e');
    }
  }

  // Register user
  static Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await ApiService.post('/v1/users', {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
      });

      if (response.statusCode == 201) {
        return;
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        throw Exception(ApiService.parseError(response));
      } else {
        throw Exception('Registration failed. Try again later.');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }

  // Activate user account
  static Future<void> activate(String token) async {
    try {
      final response = await ApiService.post(
        '/v1/users/activate',
        {'token': token},
      );

      if (response.statusCode == 200) {
        return;
      } else if (response.statusCode == 422 || response.statusCode == 400) {
        throw Exception(ApiService.parseError(response));
      } else {
        throw Exception('Activation failed. Try again later.');
      }
    } catch (e) {
      throw Exception('Activation error: $e');
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await AppPreferences.getAuthToken();
    return token != null && token.isNotEmpty;
  }

  // Get current user role
  static Future<String?> getCurrentUserRole() async {
    return await AppPreferences.getUserRole();
  }
}
