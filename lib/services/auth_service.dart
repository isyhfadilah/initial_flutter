import 'dart:convert';

import 'package:flutter_application_2/models/auth_user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  AuthService({http.Client? client}) : _client = client ?? http.Client();

  static final Uri _loginUri = Uri.parse(
    'https://dummyjson.com/auth/login',
  );

  final http.Client _client;

  Future<AuthUser> login({
    required String username,
    required String password,
  }) async {
    final response = await _client.post(
      _loginUri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'expiresInMins': 30,
      }),
    );

    final decoded = jsonDecode(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      final message = decoded is Map<String, dynamic>
          ? decoded['message'] as String?
          : null;
      throw Exception(message ?? 'Username atau password salah.');
    }

    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Format data login tidak valid.');
    }

    return AuthUser.fromJson(decoded);
  }
}
