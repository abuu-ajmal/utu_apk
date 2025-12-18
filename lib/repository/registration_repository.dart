import 'dart:convert';
import '../data/network/NetworkApiServices.dart';
import '../model/register_model.dart';
import '../utils/api_call.dart';


class RegisterRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<RegisterModel> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.getPostApiResponse(
        ApiCall.registrationApi,
        data,
      );
      print("REGISTER RESPONSE: $response");

      return RegisterModel.fromJson(response); // ✅ NO MORE ERROR
    } catch (e) {
      rethrow;
    }
  }
}

