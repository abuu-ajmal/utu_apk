

import 'package:assetmanag/utils/api_call.dart';
import 'package:flutter/cupertino.dart';

import '../data/network/NetworkApiServices.dart';
import '../model/professional.dart';

class ProfessionalRepository {
  final _apiService = NetworkApiService();

  Future<List<ProfessionalModel>> fetchProfessionals() async {
    final response = await _apiService.getGetwithtokenApiResponse(ApiCall.professionalsApi);

    if (response["statusCode"] == 200 && response["data"] != null) {
      return List<ProfessionalModel>.from(
        response["data"].map((x) => ProfessionalModel.fromJson(x)),
      );
    } else {
      throw Exception("Failed to load professionals");
    }
  }

  // Delete assigned service
  Future<void> deleteAssignedService({
    required int professionalId,
    required int serviceId,
  }) async {
    try {
      final url = ApiCall.deleteServiceApi(professionalId, serviceId);
      final response = await _apiService.getDeleteApiResponsewithToken(url); // or create DELETE method in NetworkApiService
      if (response['success'] != true) {
        throw Exception(response['message'] ?? "Failed to delete service");
      }
    } catch (e) {
      debugPrint("Delete Service Error: $e");
      rethrow;
    }
  }


  Future<dynamic> addProfessional(Map<String, dynamic> data) async {
    return await _apiService.getPostApiResponse(
      ApiCall.professionalsApi,
      data,
    );
  }
}
