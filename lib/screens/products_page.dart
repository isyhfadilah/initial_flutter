import 'package:flutter/material.dart';

import 'package:flutter_application_2/models/auth_user.dart';
import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/screens/add_product_page.dart';
import 'package:flutter_application_2/screens/product_detail_page.dart';
import 'package:flutter_application_2/screens/login_page.dart';
import 'package:flutter_application_2/services/product_service.dart';
import 'package:flutter_application_2/widgets/product_card.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({required this.user, super.key});

  final AuthUser user;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductService _service = ProductService();
  late Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _service.fetchProducts();
  }

  void _retry() {
    setState(() {
      _productsFuture = _service.fetchProducts();
    });
  }

  Future<void> _openAddProduct() async {
    final product = await Navigator.of(
      context,
    ).push<Product>(MaterialPageRoute(builder: (_) => const AddProductPage()));
    if (product == null || !mounted) return;

    final products = await _productsFuture;
    if (!mounted) return;
    setState(() {
      _productsFuture = Future.value([product, ...products]);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produk berhasil ditambahkan.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Catalog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _openAddProduct,
            tooltip: 'Tambah produk',
            icon: const Icon(Icons.add_box_outlined),
          ),
          PopupMenuButton<String>(
            tooltip: 'Account',
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                enabled: false,
                value: 'user',
                child: Text(
                  widget.user.displayName.isEmpty
                      ? widget.user.username
                      : widget.user.displayName,
                ),
              ),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
            child: CircleAvatar(
              radius: 17,
              backgroundImage: widget.user.image.isEmpty
                  ? null
                  : NetworkImage(widget.user.image),
              child: widget.user.image.isEmpty
                  ? Text(
                      widget.user.username.isEmpty
                          ? '?'
                          : widget.user.username.substring(0, 1).toUpperCase(),
                    )
                  : null,
            ),
          ),
          IconButton(
            onPressed: _retry,
            tooltip: 'Refresh products',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _ErrorState(onRetry: _retry);
          }

          final products = snapshot.data ?? const <Product>[];
          if (products.isEmpty) {
            return const Center(child: Text('Belum ada produk.'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 1100
                  ? 4
                  : constraints.maxWidth >= 700
                  ? 3
                  : constraints.maxWidth >= 440
                  ? 2
                  : 1;

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1250),
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent: _cardHeight(
                        constraints.maxWidth,
                        columns,
                      ),
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailPage(product: product),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  double _cardHeight(double availableWidth, int columns) {
    final gridWidth = availableWidth > 1250 ? 1250.0 : availableWidth;
    final cardWidth = (gridWidth - 40 - ((columns - 1) * 16)) / columns;

    // The image uses an aspect ratio of 1.25. The extra space covers the
    // fixed-height text content and leaves a small safety margin.
    return (cardWidth / 1.25) + 145;
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 48),
            const SizedBox(height: 12),
            const Text(
              'Produk tidak dapat dimuat.',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Periksa koneksi internet lalu coba lagi.'),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Coba lagi'),
            ),
          ],
        ),
      ),
    );
  }
}
