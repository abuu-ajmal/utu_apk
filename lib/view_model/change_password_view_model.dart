import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/auth_repository.dart';
import '../model/change_password_responses.dart';
import '../utils/routes/routes_name.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final AuthRepository _authRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// ✅ Fetch token: use 'temp_token' first (from forced change), else normal 'token'
  Future<String?> _getValidToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('temp_token') ?? prefs.getString('token');
  }

  Future<void> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      setLoading(true);

      final token = await _getValidToken();
      if (token == null || token.isEmpty) {
        setLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Session expired. Please log in again.'),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pushReplacementNamed(context, RoutesName.signIn);
        return;
      }

      // ✅ Call API
      final ChangePasswordResponse result = await _authRepo.changePassword(
        token: token,
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      setLoading(false);

      // ✅ Success
      if (result.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.check_circle, color: Colors.green),
            title: const Text('Password Changed Successfully'),
            content: Text(result.message ?? 'Your password has been updated successfully.'),
            actions: [
              TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('temp_token');
                  await prefs.remove('token');
                  Navigator.pop(context); // close dialog
                  Navigator.pushReplacementNamed(context, RoutesName.signIn);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      // ✅ Old password incorrect
      else if (result.statusCode == 401 ||
          (result.message?.toLowerCase().contains('old password') ?? false)) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.error_outline, color: Colors.red),
            title: const Text('Incorrect Old Password'),
            content: Text(result.message ?? 'Old password is incorrect.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Try Again'),
              ),
            ],
          ),
        );
      }
      // ✅ Validation error (password mismatch, etc.)
      else if (result.statusCode == 422) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
            title: const Text('Validation Error'),
            content: Text(result.message ?? 'Please check your input fields.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
      // ✅ Unknown error
      else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(Icons.error, color: Colors.red),
            title: const Text('Error'),
            content: Text(result.message ?? 'Something went wrong. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }




}
