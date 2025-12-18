import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:assetmanag/view_model/change_password_view_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChangePasswordViewModel(),
      child: Consumer<ChangePasswordViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          backgroundColor: const Color(0xFFE3F2FD),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                width: 380,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5)),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Icon(Icons.lock_outline,
                          color: Colors.blueAccent, size: 70),
                      const SizedBox(height: 10),
                      const Text(
                        "Change Your Password",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 25),
                      _passwordField(
                        controller: _oldPasswordController,
                        label: 'Old Password',
                        obscure: _obscureOld,
                        toggle: () =>
                            setState(() => _obscureOld = !_obscureOld),
                        validator: (v) => v == null || v.isEmpty
                            ? 'Please enter old password'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _passwordField(
                        controller: _newPasswordController,
                        label: 'New Password',
                        obscure: _obscureNew,
                        toggle: () =>
                            setState(() => _obscureNew = !_obscureNew),
                        validator: (v) => v != null && v.length < 8
                            ? 'Minimum 8 characters'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      _passwordField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        obscure: _obscureConfirm,
                        toggle: () =>
                            setState(() => _obscureConfirm = !_obscureConfirm),
                        validator: (v) =>
                        v != _newPasswordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: viewModel.loading
                              ? null
                              : () {
                            if (_formKey.currentState!.validate()) {
                              viewModel.changePassword(
                                context: context,
                                oldPassword:
                                _oldPasswordController.text.trim(),
                                newPassword:
                                _newPasswordController.text.trim(),
                                confirmPassword:
                                _confirmPasswordController.text
                                    .trim(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 5,
                          ),
                          child: viewModel.loading
                              ? const CircularProgressIndicator(
                              color: Colors.white)
                              : const Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: toggle,
        ),
      ),
    );
  }
}
