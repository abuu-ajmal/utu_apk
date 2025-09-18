import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert'; // For decoding JSON responses
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginAuth.dart'; // For local storage

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService =
      AuthService(); // Replace with your service injection

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add more validation if necessary
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add more validation if necessary
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // _login();
                  // if (_formKey.currentState!.validate()) {
                  //   // Collect email and password
                  //   final credentials = {
                  //     'email': _emailController.text,
                  //     'password': _passwordController.text,
                  //   };

                  //   // Call the loginAuthenticate method from AuthService
                  //   // _authService.loginAuthenticate(context, credentials);
                  // }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
