import 'package:flutter/material.dart';

class Utils {
  static InputDecoration getDecoration({
    required String labelText,
    required String hintText,
    required Color decorationColor,
    required IconData prefixIcon,
    Widget? suffixIcon, // Optional suffix icon
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: TextStyle(color: decorationColor),
      hintStyle: TextStyle(color: Colors.grey),
      prefixIcon: Icon(prefixIcon, color: decorationColor),
      suffixIcon: suffixIcon, // Assign the suffix icon here
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: decorationColor),
      ),
    );
  }
}
