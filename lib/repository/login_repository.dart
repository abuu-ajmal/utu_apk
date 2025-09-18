import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/login_model.dart';
import '../model/login_session.dart';
import '../utils/api_call.dart';


class LoginRepository {
  final SessionManager _sessionManager = SessionManager();

  Future<LoginResponse> loginClient(Map<String, dynamic> data) async {
    try {
      // Send the login request
      final response = await http.post(
        Uri.parse(ApiCall.loginApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      // Print raw response body for debugging
      print("Raw Response Body: ${response.body}");

      // Check for a successful HTTP status code (200-299)
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode and parse the response
        final parsedResponse = LoginResponse.fromJson(jsonDecode(response.body));

        // Debug print the phoneNo to ensure correct parsing
        print("Parsed Phone Number: ${parsedResponse.phoneNo}");

        // Save user data to session
        await _sessionManager.saveUserData(
          clientId: parsedResponse.clientId ?? 0,
          firstName: parsedResponse.firstName ?? '',
          middleName: parsedResponse.middleName ?? '',
          lastName: parsedResponse.lastName ?? '',
          phoneNo: parsedResponse.phoneNo ?? '',
          gender: parsedResponse.gender ?? '',
          email: parsedResponse.email ?? '',
        );

        print("User data saved to session successfully.");

        return parsedResponse;
      } else {
        // Handle unsuccessful login response
        throw Exception("Failed to login. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      // Throw exception for higher-level handling
      throw Exception("Error during login: $e");
    }
  }
}
