
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app_exception.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiService{


  @override
  Future getGetApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw ExceptionHandling("No Internet Connection");
    }
    return jsonResponse;
  }

  //delete without token

  Future getDeleteApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final response = await http.delete(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response); // Make sure returnResponse handles status codes
    } on SocketException {
      throw ExceptionHandling("No Internet Connection");
    }
    return jsonResponse;
  }

  //delete with token header

  Future getDeleteApiResponsewithToken(String url, {Map<String, String>? headers}) async {
    dynamic jsonResponse;
    try {
      // Load token from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      // Make DELETE request with Authorization header
      final response = await http.delete(
        Uri.parse(url),
        headers: headers ?? {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw ExceptionHandling("No Internet Connection");
    }
    return jsonResponse;
  }



  @override
  Future getGetwithtokenApiResponse(String url) async {
    dynamic jsonResponse;

    try {
      // Load token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");

      if (token == null) {
        throw ExceptionHandling("Unauthorized: No token found");
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",   // ✅ REQUIRED FOR LARAVEL AUTH
        },
      ).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);

    } on SocketException {
      throw ExceptionHandling("No Internet Connection");
    }

    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, dynamic data, {Map<String, String>? headers}) async {
    dynamic jsonResponse;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data,
      ).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw ExceptionHandling("No Internet Connection");
    }
    return jsonResponse;
  }

  Future getPostApiResponseWithHeader(String url, Map<String, dynamic> data, Map<String, String> headers) async {
    dynamic jsonResponse;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: data,
      ).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw ExceptionHandling("No Internet Connection");
    }
    return jsonResponse;
  }


  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200: // OK
      case 201: // Created
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;

      case 400:
        throw ExceptionHandling(response.body.toString());
      case 403:
        throw ExceptionHandling(response.body.toString());
      case 422:
        throw ExceptionHandling(response.body.toString());
      case 500:
        throw ExceptionHandling(response.body.toString());
      default:
        throw ExceptionHandling(
            "Error while communicating with server with status code ${response.statusCode}");
    }
  }


}