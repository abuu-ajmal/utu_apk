import 'package:flutter/material.dart';
import '../model/register_model.dart';
import '../repository/registration_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterRepository _registerRepo = RegisterRepository();

  // -------------------------------
  //  Loading State
  // -------------------------------
  bool _loading = false;
  bool get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // -------------------------------
  //  Register Function
  // -------------------------------
  Future<void> registerUser(RegisterModel model, BuildContext context) async {
    setLoading(true);

    try {
      final result = await _registerRepo.registerUser(model.toJson());

      setLoading(false);

      // Extract generated values from API response
      final String email = result.email ?? model.email ?? "";
      final String phone = result.phone ?? model.phone ?? "";
      final String password = result.password ?? "******"; // From API

      // Show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful!")),
      );

      // Show success dialog
      _showSuccessDialog(
        context,
        email: email,
        phone: phone,
        password: password,
      );

    } catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registration failed: $e")));
    }
  }

  // -------------------------------
  //  Success Dialog
  // -------------------------------
  void _showSuccessDialog(
      BuildContext context, {
        required String email,
        required String phone,
        required String password,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false, // User must tap button
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text(
            "Registration Successful!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("📧 Email: $email"),
              const SizedBox(height: 8),
              Text("📱 Phone: $phone"),
              const SizedBox(height: 8),
              Text("🔑 Password: $password"),
              const SizedBox(height: 12),
              const Text(
                "A confirmation message has been sent to your email.",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous screen
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
