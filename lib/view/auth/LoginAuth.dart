import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  get http => null;

  Future<void> loginAuthenticate(
      BuildContext context, Map<String, String> credentials) async {
    // final url = Uri.parse('http://192.168.88.118:8000/api/login'); // Replace with your API URL
    final url = Uri.parse('http://127.0.0.1:8000/api/login');

    try {
      final response =
          await http.post(url, body: json.encode(credentials), headers: {
        'Content-Type': 'application/json',
      });

      final responseData = json.decode(response.body);

      if (response.statusCode == 200 && responseData['statusCode'] == 200) {
        final data = responseData['data'];

        if (data['login_status'] == '1') {
          // Save user data and token locally using SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', 'Bearer ${data['token']}');
          await prefs.setString('user_id', data['user_id']);
          // await prefs.setString('full_name', data['full_name']);
          await prefs.setString('email', data['email']);

          await prefs.setString(
              'roles', data['roles'][0]['name'] ?? 'Default Role');
          await prefs.setBool('isLogin', true);

          // Show success notification
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Successfully'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          // Navigate to another page
          print('yooooo   1');
          Navigator.pushNamed(
              context, 'home_screen'); // Replace with your route
        } else {
          // If password change is required
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please change the password first'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 3),
            ),
          );

          // Navigate to change password page
          print('yooooo   222');
          // Navigator.pushNamed(context, '/set-new-password'); // Replace with your route
        }
      } else {
        // Show error notification if login failed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['message']),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );

        // Optionally navigate back to login screen or homepage
        print('yooooo   333333');
        Navigator.pushNamed(context, 'home_screen');
      }
    } catch (error) {
      // Handle API request failure
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connection failed. Please try again.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
