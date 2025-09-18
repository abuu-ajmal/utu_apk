
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../app_exception.dart';
import 'BaseApiServices.dart';

class NetworkApiService extends BaseApiService{

  @override
  Future getGetApiResponse(String url) async{
    dynamic jsonResponse;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      jsonResponse = returnResponse(response);
    }on SocketException{
      throw ExceptionHandling("No Internet Connection");
    }
    return jsonResponse;
  }

  @override
  Future getPostApiResponse(String url, data) async{
    dynamic jsonResponse;
    try{
      Response response = await http.post(
          Uri.parse(url),
          body: data
      ).timeout(const Duration(seconds: 10));

      jsonResponse = returnResponse(response);

    }on SocketException{
      throw ExceptionHandling("No Internet Connection");
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response){

    switch(response.statusCode){
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw ExceptionHandling(response.body.toString());
      case 500:
        throw ExceptionHandling(response.body.toString());
      default:
        throw ExceptionHandling("Error while communicating with server with status code ${response.statusCode.toString()}");
    }
  }

}