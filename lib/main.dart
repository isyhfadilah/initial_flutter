import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/products_page.dart';

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF8F2024);

    return MaterialApp(
      title: 'Product Catalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF8F6),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFDF8F6),
          foregroundColor: Color(0xFF3C2020),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      home: const ProductsPage(),
    );
  }
}
