import 'package:flutter/material.dart';

import 'package:flutter_application_2/models/product.dart';
import 'package:flutter_application_2/services/product_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  final _brandController = TextEditingController();
  final _discountController = TextEditingController(text: '0');
  final _ratingController = TextEditingController(text: '0');
  final _thumbnailController = TextEditingController();
  final _imagesController = TextEditingController();
  final _service = ProductService();
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    _brandController.dispose();
    _discountController.dispose();
    _ratingController.dispose();
    _thumbnailController.dispose();
    _imagesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final product = await _service.addProduct(
        title: _titleController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        category: _categoryController.text.trim(),
        description: _descriptionController.text.trim(),
        stock: int.parse(_stockController.text.trim()),
        brand: _brandController.text.trim(),
        discountPercentage: double.parse(_discountController.text.trim()),
        rating: double.parse(_ratingController.text.trim()),
        thumbnail: _thumbnailController.text.trim(),
        images: _imagesController.text
            .split('\n')
            .map((url) => url.trim())
            .where((url) => url.isNotEmpty)
            .toList(),
      );
      if (!mounted) return;
      Navigator.of(context).pop<Product>(product);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) return '$label wajib diisi';
    return null;
  }

  String? _positiveNumber(String? value, String label) {
    final number = double.tryParse(value?.trim() ?? '');
    if (number == null || number < 0) return '$label harus berupa angka valid';
    return null;
  }

  String? _percentage(String? value, String label) {
    final number = double.tryParse(value?.trim() ?? '');
    if (number == null || number < 0 || number > 100) {
      return '$label harus di antara 0 dan 100';
    }
    return null;
  }

  String? _rating(String? value) {
    final number = double.tryParse(value?.trim() ?? '');
    if (number == null || number < 0 || number > 5) {
      return 'Rating harus di antara 0 dan 5';
    }
    return null;
  }

  String? _url(String? value, String label, {bool required = false}) {
    final text = value?.trim() ?? '';
    if (text.isEmpty && !required) return null;
    final uri = Uri.tryParse(text);
    if (uri == null ||
        (uri.scheme != 'http' && uri.scheme != 'https') ||
        uri.host.isEmpty) {
      return '$label harus berupa URL yang valid';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Produk')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const Text(
                  'Data Produk Baru',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Nama produk',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _required(value, 'Nama produk'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _categoryController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    hintText: 'Contoh: beauty',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _required(value, 'Kategori'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _brandController,
                  enabled: !_isLoading,
                  decoration: const InputDecoration(
                    labelText: 'Brand',
                    hintText: 'Contoh: Essence',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _required(value, 'Brand'),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        enabled: !_isLoading,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Harga',
                          prefixText: '\$ ',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => _positiveNumber(value, 'Harga'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _stockController,
                        enabled: !_isLoading,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Stok',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          final stock = int.tryParse(value?.trim() ?? '');
                          if (stock == null || stock < 0) {
                            return 'Stok harus angka';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _discountController,
                        enabled: !_isLoading,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Diskon',
                          suffixText: '%',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => _percentage(value, 'Diskon'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _ratingController,
                        enabled: !_isLoading,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Rating',
                          suffixText: '/ 5',
                          border: OutlineInputBorder(),
                        ),
                        validator: _rating,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  enabled: !_isLoading,
                  minLines: 4,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _required(value, 'Deskripsi'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _thumbnailController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    labelText: 'URL gambar utama',
                    hintText: 'https://example.com/product.jpg',
                    prefixIcon: Icon(Icons.image_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      _url(value, 'URL gambar utama', required: true),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _imagesController,
                  enabled: !_isLoading,
                  keyboardType: TextInputType.url,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'URL gambar galeri',
                    hintText: 'Satu URL per baris (opsional)',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.collections_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final urls = (value ?? '')
                        .split('\n')
                        .map((url) => url.trim())
                        .where((url) => url.isNotEmpty);
                    for (final url in urls) {
                      final error = _url(url, 'URL gambar galeri');
                      if (error != null) return error;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _isLoading ? null : _submit,
                  icon: _isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.add_rounded),
                  label: Text(_isLoading ? 'Menyimpan...' : 'Tambah Produk'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
