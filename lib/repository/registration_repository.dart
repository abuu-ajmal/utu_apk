import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/location.dart';
import '../utils/api_call.dart';

class RegistrationRepository {
  Future<List<Location>> fetchLocations() async {
    try {
      final response = await http.get(Uri.parse(ApiCall.locationApi));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'];
        return data.map((location) => Location.fromJson(location)).toList();
      } else {
        throw Exception("Failed to load locations");
      }
    } catch (e) {
      throw Exception("Error fetching locations: $e");
    }
  }

  Future<Map<String, dynamic>> registerClient(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(ApiCall.registrationApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      // Log the response for debugging
      print("HTTP Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Try decoding the response body
      final Map<String, dynamic> responseBody = jsonDecode(response.body);

      // Check if either HTTP statusCode == 201 or responseBody['statusCode'] == 201
      if (responseBody['statusCode'] == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print("Decoded Response: $responseBody");
        return responseBody;


      } else {
        throw Exception(
            "Failed to register: ${responseBody['message'] ?? response.body}");
      }
    } catch (e) {
      print("Exception during registration: $e");
      throw Exception("Error registering client: $e");
    }
  }
}

