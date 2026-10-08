import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> main() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));
  final data = jsonDecode(response.body);
  final products = data['products'];

  print(products[0]['title']);

  for (var product in products) {
    print('Product: ${product['title']}, Price: ${product['price']}');
  }

  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}