// File: lib/screens/sales/sale_form_screen.dart

import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../services/product_service.dart';
import '../../services/sale_service.dart';

class SaleFormScreen extends StatefulWidget {
  const SaleFormScreen({super.key});

  @override
  State<SaleFormScreen> createState() => _SaleFormScreenState();
}

class _SaleFormScreenState extends State<SaleFormScreen> {
  final quantityController = TextEditingController();
  final notesController = TextEditingController();

  List<Product> products = [];
  Product? selectedProduct;
  bool isLoading = true;
  bool isSubmitting = false;
  String? errorMessage;
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  void dispose() {
    quantityController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedProducts = await ProductService.getProducts();
      setState(() {
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
        isLoading = false;
      });
    }
  }

  void _calculateTotal() {
    if (selectedProduct == null) {
      setState(() => totalAmount = 0.0);
      return;
    }

    final quantity = int.tryParse(quantityController.text) ?? 0;
    setState(() {
      totalAmount = selectedProduct!.price * quantity;
    });
  }

  Future<void> _handleSubmit() async {
    setState(() {
      isSubmitting = true;
      errorMessage = null;
    });

    if (selectedProduct == null) {
      setState(() {
        isSubmitting = false;
        errorMessage = 'Please select a product.';
      });
      return;
    }

    final quantityStr = quantityController.text.trim();
    final notes = notesController.text.trim();

    if (quantityStr.isEmpty) {
      setState(() {
        isSubmitting = false;
        errorMessage = 'Please enter quantity.';
      });
      return;
    }

    final quantity = int.tryParse(quantityStr);

    if (quantity == null || quantity <= 0) {
      setState(() {
        isSubmitting = false;
        errorMessage = 'Please enter a valid quantity.';
      });
      return;
    }

    if (quantity > selectedProduct!.stockQuantity) {
      setState(() {
        isSubmitting = false;
        errorMessage = 'Insufficient stock. Available: ${selectedProduct!.stockQuantity}';
      });
      return;
    }

    try {
      await SaleService.createSale(
        productId: selectedProduct!.id,
        quantity: quantity,
        totalAmount: totalAmount,
        notes: notes.isEmpty ? null : notes,
      );

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isSubmitting = false;
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Sale'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(
                  child: Text('No products available. Please add products first.'),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select Product *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<Product>(
                        value: selectedProduct,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Choose a product',
                        ),
                        items: products.map((product) {
                          return DropdownMenuItem(
                            value: product,
                            child: Text(
                              '${product.name} (\$${product.price.toStringAsFixed(2)}) - Stock: ${product.stockQuantity}',
                            ),
                          );
                        }).toList(),
                        onChanged: (product) {
                          setState(() {
                            selectedProduct = product;
                          });
                          _calculateTotal();
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: quantityController,
                        decoration: const InputDecoration(
                          labelText: 'Quantity *',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _calculateTotal();
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notes (Optional)',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (errorMessage != null)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error, color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: isSubmitting ? null : _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          child: isSubmitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Record Sale'),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
