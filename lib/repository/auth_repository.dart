
import '../data/network/NetworkApiServices.dart';
import '../utils/api_call.dart';

class AuthRepository{

  final NetworkApiService _apiService = NetworkApiService();

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

}