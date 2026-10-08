import 'dart:convert';

import 'package:flutter_application_2/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  ProductService({http.Client? client}) : _client = client ?? http.Client();

  static final Uri _productsUri = Uri.parse(
    'http://10.101.84.177:8000/api/products?imit=10',
  );
  static final Uri _addProductUri = Uri.parse(
    'http://10.101.84.177:8000/api/products',
  );

  final http.Client _client;

  Future<Product> addProduct({
    required String title,
    required double price,
    required String category,
    required String description,
    required int stock,
    required String brand,
    required double discountPercentage,
    required double rating,
    required String thumbnail,
    required List<String> images,
  }) async {
    final response = await _client.post(
      _addProductUri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'price': price,
        'category': category,
        'description': description,
        'stock': stock,
        'brand': brand,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'thumbnail': thumbnail,
        'images': images,
      }),
    );

    final decoded = jsonDecode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decoded is Map<String, dynamic>
          ? decoded['message'] as String?
          : null;
      throw Exception(message ?? 'Gagal menambahkan produk.');
    }

    final productJson = _extractProduct(decoded);
    if (productJson == null) {
      throw const FormatException('Format data produk tidak valid.');
    }

    return Product.fromJson(productJson);
  }

  Map<String, dynamic>? _extractProduct(Object? decoded) {
    if (decoded is! Map<String, dynamic>) return null;

    final data = decoded['data'];
    if (data is Map<String, dynamic>) return data;

    final product = decoded['product'];
    if (product is Map<String, dynamic>) return product;

    return decoded;
  }

  Future<List<Product>> fetchProducts() async {
    final response = await _client.get(_productsUri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Gagal memuat produk (HTTP ${response.statusCode}).');
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map<String, dynamic> || decoded['products'] is! List) {
      throw const FormatException('Format data produk tidak valid.');
    }

    return (decoded['products'] as List<dynamic>)
        .whereType<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList();
  }
}
