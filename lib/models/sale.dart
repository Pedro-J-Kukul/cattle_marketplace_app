// File: lib/models/sale.dart

class Sale {
  final int id;
  final int productId;
  final int userId;
  final int quantity;
  final double totalAmount;
  final DateTime saleDate;
  final String? notes;

  Sale({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
    required this.totalAmount,
    required this.saleDate,
    this.notes,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      id: json['id'],
      productId: json['product_id'],
      userId: json['user_id'],
      quantity: json['quantity'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      saleDate: DateTime.parse(json['sale_date']),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'user_id': userId,
      'quantity': quantity,
      'total_amount': totalAmount,
      'sale_date': saleDate.toIso8601String(),
      'notes': notes,
    };
  }
}
