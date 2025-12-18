
import 'dart:convert';

import '../data/network/NetworkApiServices.dart';
import '../model/auth_model.dart';
import '../model/change_password_responses.dart';
import '../utils/api_call.dart';

class AuthRepository{

  final NetworkApiService _apiService = NetworkApiService();

  Future<UserModel> login(String login, String password) async {
    final response = await _apiService.getPostApiResponse(ApiCall.loginApi, {
      "login": login,
      "password": password,
    });
    print("LOGIN RESPONSE: $response"); // 👈 ADD THIS LINE
    return UserModel.fromJson(response);
  }


  Future<dynamic> loginApi(dynamic data) async{
    try{
      dynamic response = await _apiService.getPostApiResponse(ApiCall.loginApi, data);
      return response;
    }catch(e){
      rethrow;
    }

  }

  Future<dynamic> registerApi(dynamic data) async{
    try{
      dynamic response = await _apiService.getPostApiResponse(ApiCall.registrationApi, data);
      return response;
    }catch(e){
      rethrow;
    }

  }
  Future<dynamic> getLocationApi() async{
    try{
      dynamic response = await _apiService.getGetApiResponse(ApiCall.locationApi);
      return response;
    }catch(e){
      rethrow;
    }

  }

  Future<ChangePasswordResponse> changePassword({
    required String token,
    required String newPassword,
    required String confirmPassword,
    String? oldPassword,
  }) async {
    // ✅ Put the network call here
    final response = await _apiService.getPostApiResponseWithHeader(
      ApiCall.changePasswordApi,
      {
        'old_password': oldPassword ?? '',
        'new_password': newPassword,
        'new_password_confirmation': confirmPassword,
      },
      {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    return ChangePasswordResponse.fromJson(response);
  }
}

