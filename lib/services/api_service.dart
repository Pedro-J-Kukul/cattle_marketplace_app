// File: lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/preferences.dart';

class ApiService {
  // Get base URL from preferences
  static Future<String> getBaseUrl() async {
    return await AppPreferences.getApiBaseUrl();
  }

  // Helper to create headers with auth token
  static Future<Map<String, String>> getHeaders({bool includeAuth = false}) async {
    final headers = {'Content-Type': 'application/json'};
    
    if (includeAuth) {
      final token = await AppPreferences.getAuthToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    
    return headers;
  }

  // Generic GET request
  static Future<http.Response> get(String endpoint, {bool includeAuth = false}) async {
    final baseUrl = await getBaseUrl();
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders(includeAuth: includeAuth);
    
    return await http.get(url, headers: headers);
  }

  // Generic POST request
  static Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body,
    {bool includeAuth = false}
  ) async {
    final baseUrl = await getBaseUrl();
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders(includeAuth: includeAuth);
    
    return await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  // Generic PUT request
  static Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body,
    {bool includeAuth = false}
  ) async {
    final baseUrl = await getBaseUrl();
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders(includeAuth: includeAuth);
    
    return await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
  }

  // Generic DELETE request
  static Future<http.Response> delete(String endpoint, {bool includeAuth = false}) async {
    final baseUrl = await getBaseUrl();
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = await getHeaders(includeAuth: includeAuth);
    
    return await http.delete(url, headers: headers);
  }

  // Parse error response
  static String parseError(http.Response response) {
    try {
      final json = jsonDecode(response.body);
      return json['error'] ?? 'An error occurred';
    } catch (e) {
      return 'An error occurred';
    }
  }
}
