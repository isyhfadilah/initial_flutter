import 'dart:convert';

import 'package:flutter_application_2/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  ProductService({http.Client? client}) : _client = client ?? http.Client();

  static final Uri _productsUri = Uri.parse(
    'https://dummyjson.com/products?limit=10',
  );

  final http.Client _client;

  Future<List<Product>> fetchProducts() async {
    final response = await _client.get(_productsUri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Gagal memuat produk (HTTP ${response.statusCode}).',
      );
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
