// auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://10.10.10.176:8000/api/login'), // Replace with your actual API endpoint
      
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Save the token and other user information
      await storage.write(key: 'access_token', value: data['data']['token']);
      await storage.write(key: 'user_id', value: data['data']['user_id'].toString());
      await storage.write(key: 'full_name', value: data['data']['full_name']);
      await storage.write(key: 'email', value: data['data']['email']);
      await storage.write(key: 'roles', value: json.encode(data['data']['roles']));
      await storage.write(key: 'permissions', value: json.encode(data['data']['permissions']));
      return true;

    } else {
      return false;
    }
  }
}