// File: lib/services/product_service.dart

import 'dart:convert';
import '../models/product.dart';
import 'api_service.dart';

class ProductService {
  // Get all products
  static Future<List<Product>> getProducts() async {
    try {
      final response = await ApiService.get('/v1/products', includeAuth: true);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> productsJson = json['products'] ?? [];
        return productsJson.map((p) => Product.fromJson(p)).toList();
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Get product by ID
  static Future<Product> getProduct(int productId) async {
    try {
      final response = await ApiService.get('/v1/products/$productId', includeAuth: true);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Product.fromJson(json['product']);
      } else if (response.statusCode == 404) {
        throw Exception('Product not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  // Create product (manager/admin only)
  static Future<Product> createProduct({
    required String name,
    required String description,
    required double price,
    required int stockQuantity,
    String? category,
  }) async {
    try {
      final response = await ApiService.post(
        '/v1/products',
        {
          'name': name,
          'description': description,
          'price': price,
          'stock_quantity': stockQuantity,
          if (category != null) 'category': category,
        },
        includeAuth: true,
      );

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        return Product.fromJson(json['product']);
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to create products');
      } else if (response.statusCode == 422) {
        throw Exception(ApiService.parseError(response));
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Create product error: $e');
    }
  }

  // Update product (manager/admin only)
  static Future<Product> updateProduct(int productId, Map<String, dynamic> updates) async {
    try {
      final response = await ApiService.put(
        '/v1/products/$productId',
        updates,
        includeAuth: true,
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Product.fromJson(json['product']);
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to update products');
      } else if (response.statusCode == 404) {
        throw Exception('Product not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  // Delete product (manager/admin only)
  static Future<void> deleteProduct(int productId) async {
    try {
      final response = await ApiService.delete('/v1/products/$productId', includeAuth: true);

      if (response.statusCode == 204) {
        return;
      } else if (response.statusCode == 403) {
        throw Exception('You do not have permission to delete products');
      } else if (response.statusCode == 404) {
        throw Exception('Product not found');
      } else {
        throw Exception(ApiService.parseError(response));
      }
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
