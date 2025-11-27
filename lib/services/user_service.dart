// File: lib/services/user_service.dart

import 'dart:convert';
import '../models/user.dart';
import 'api_service.dart';

class UserService {
  // Get all users (admin/manager only)
  static Future<List<User>> getUsers() async {
    try {
      final response = await ApiService.get('/v1/users', includeAuth: true);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> usersJson = json['users'] ?? [];
        return usersJson.map((u) => User.fromJson(u)).toList();
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to view users');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  // Get user by ID
  static Future<User> getUser(int userId) async {
    try {
      final response = await ApiService.get('/v1/users/$userId', includeAuth: true);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return User.fromJson(json['user']);
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  // Update user
  static Future<User> updateUser(int userId, Map<String, dynamic> updates) async {
    try {
      final response = await ApiService.put(
        '/v1/users/$userId',
        updates,
        includeAuth: true,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return User.fromJson(json['user']);
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to update this user');
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  // Delete user (admin only)
  static Future<void> deleteUser(int userId) async {
    try {
      final response = await ApiService.delete('/v1/users/$userId', includeAuth: true);

      if (response.statusCode == 204) {
        return;
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to delete users');
      } else if (response.statusCode == 404) {
        throw Exception('User not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
