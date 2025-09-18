// lib/services/auth_service.dart

import 'dart:convert';
import 'package:assetmanag/utils/api_call.dart';
import 'package:http/http.dart' as http;


class AuthService {
  Future<Map<String, dynamic>> login(String phone_no, String reference_no) async {
    try {
      final response = await http.post(
        Uri.parse(ApiCall.loginApi),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'phone_no': phone_no,
          'reference_no': reference_no,
        }),
      );

      // Decode the response body
      return jsonDecode(response.body);
    } catch (e) {
      print("Error occurred: $e");
      return {'error': 'Error: $e'};
    }
  }
}