import 'package:flutter/material.dart';

import '../model/professional.dart';
import '../repository/proffessional_repository.dart';


class ProfessionalViewModel with ChangeNotifier {
  final _repo = ProfessionalRepository();


  List<ProfessionalModel> professionals = [];

  bool loading = false;
  ProfessionalModel? professional;
  String? errorMessage;


  Future<void> loadProfessional() async {
    loading = true;
    notifyListeners();

    try {
      List<ProfessionalModel> list = await _repo.fetchProfessionals();

      if (list.isNotEmpty) {
        professional = list.first;
        print("Loaded Professional ID: ${professional!.professionalId}");
      } else {
        errorMessage = "No professional data found";
      }
    } catch (e) {
      print("Fetch Error: $e");
      errorMessage = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  Future<bool> deleteAssignedService(int professionalId, int serviceId) async {
    if (professional == null) return false;

    try {
      // Call repository
      await _repo.deleteAssignedService(
        professionalId: professionalId,
        serviceId: serviceId,
      );

      // Update local services list
      professional!.services.removeWhere((s) => s.serviceId == serviceId);
      notifyListeners();

      return true;
    } catch (e) {
      debugPrint("Delete Service Error: $e");
      return false;
    }
  }



  // For adding professional
  Future<dynamic> addProfessional(Map<String, dynamic> data) async {
    return await _repo.addProfessional(data);
  }
}
