import 'dart:io';
import 'package:flutter/material.dart';
import '../model/identity.dart';
import '../repository/identity_repository.dart';
import 'auth_view_login.dart';
import 'package:provider/provider.dart';

class IdentityViewModel with ChangeNotifier {
  final IdentityRepository _repo = IdentityRepository();

  bool loading = false;
  List<IdentityModel> identities = [];

  /// Fetch user identities
  Future<void> getIdentities(BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      final token = auth.user?.token;

      if (token == null) {
        print("USER NOT LOGGED IN");
        loading = false;
        notifyListeners();
        return;
      }

      identities = await _repo.fetchIdentities(token);
    } catch (e) {
      print("IDENTITY FETCH ERROR: $e");
    }

    loading = false;
    notifyListeners();
  }


  /// Register identity
  Future<bool> registerIdentity(
      Map<String, dynamic> data, File? file, BuildContext context) async {
    loading = true;
    notifyListeners();

    try {
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      final token = auth.user?.token;

      if (token == null) {
        print("USER NOT LOGGED IN");
        return false;
      }

      final success = await _repo.registerIdentity(data, file, token);

      if (success) {
        await getIdentities(context); // Refresh after success
      }

      return success;
    } catch (e) {
      print("REGISTER IDENTITY ERROR: $e");
      return false;
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
