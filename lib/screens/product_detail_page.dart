import 'package:flutter/material.dart';

import 'package:flutter_application_2/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final gallery = product.images.isEmpty
        ? [product.thumbnail]
        : product.images;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
            children: [
              SizedBox(
                height: 310,
                child: PageView.builder(
                  itemCount: gallery.length,
                  itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(
                      gallery[index],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported_outlined,
                        size: 54,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                product.title,
                style: const TextStyle(
                  color: Color(0xFF332222),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${product.brand} • ${_label(product.category)}',
                style: const TextStyle(color: Color(0xFF806B6B)),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF8F2024),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 18),
                  const Icon(Icons.star_rounded,
                      color: Color(0xFFF4B400), size: 22),
                  Text(' ${product.rating.toStringAsFixed(1)}'),
                  const Spacer(),
                  Text('${product.stock} in stock'),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                product.description,
                style: const TextStyle(
                  color: Color(0xFF5F5050),
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              if (product.discountPercentage > 0) ...[
                const SizedBox(height: 18),
                Text(
                  '${product.discountPercentage.toStringAsFixed(0)}% discount',
                  style: const TextStyle(
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _label(String value) {
    return value
        .split('-')
        .map((word) => word.isEmpty
            ? word
            : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}
