// File: lib/services/sale_service.dart

import 'dart:convert';
import '../models/sale.dart';
import 'api_service.dart';

class SaleService {
  // Get all sales
  static Future<List<Sale>> getSales() async {
    try {
      final response = await ApiService.get('/v1/sales', includeAuth: true);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> salesJson = json['sales'] ?? [];
        return salesJson.map((s) => Sale.fromJson(s)).toList();
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to fetch sales: $e');
    }
  }

  // Get sale by ID
  static Future<Sale> getSale(int saleId) async {
    try {
      final response = await ApiService.get('/v1/sales/$saleId', includeAuth: true);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Sale.fromJson(json['sale']);
      } else if (response.statusCode == 404) {
        throw Exception('Sale not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to fetch sale: $e');
    }
  }

  // Create sale
  static Future<Sale> createSale({
    required int productId,
    required int quantity,
    required double totalAmount,
    String? notes,
  }) async {
    try {
      final response = await ApiService.post(
        '/v1/sales',
        {
          'product_id': productId,
          'quantity': quantity,
          'total_amount': totalAmount,
          if (notes != null) 'notes': notes,
        },
        includeAuth: true,
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return Sale.fromJson(json['sale']);
      } else if (response.statusCode == 422) {
        throw Exception(ApiService.parseError(response));
      } else {
        throw Exception('Failed to create sale');
      }
    } catch (e) {
      throw Exception('Create sale error: $e');
    }
  }

  // Update sale
  static Future<Sale> updateSale(int saleId, Map<String, dynamic> updates) async {
    try {
      final response = await ApiService.put(
        '/v1/sales/$saleId',
        updates,
        includeAuth: true,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Sale.fromJson(json['sale']);
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to update sales');
      } else if (response.statusCode == 404) {
        throw Exception('Sale not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to update sale: $e');
    }
  }

  // Delete sale (manager/admin only)
  static Future<void> deleteSale(int saleId) async {
    try {
      final response = await ApiService.delete('/v1/sales/$saleId', includeAuth: true);

      if (response.statusCode == 204) {
        return;
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to delete sales');
      } else if (response.statusCode == 404) {
        throw Exception('Sale not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to delete sale: $e');
    }
  }
}
