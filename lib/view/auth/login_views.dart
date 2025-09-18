import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/login_model.dart';
import '../../model/login_session.dart';
import '../../repository/login_repository.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/colors.dart';
import '../../utils/utils.dart';

import '../../widget/button_widget.dart';

class LoginViews extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _referenceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final LoginRepository _authRepository = LoginRepository();
  final SessionManager _sessionManager = SessionManager();

  // Login function
  void _login(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'phone_no': _phoneController.text,
        'reference_no': _referenceController.text,
      };

      try {
        // Call repository to perform login
        final LoginResponse response = await _authRepository.loginClient(data);

        if (response.message == 'login seccessfully') {
          // Save session data
          await _sessionManager.saveUserData(
            clientId: response.clientId ?? 0,
            firstName: response.firstName ?? '',
            middleName: response.middleName ?? '',
            lastName: response.lastName ?? '',
            phoneNo: response.phoneNo ?? '',
            gender: response.gender ?? '',
            email: response.email ?? '',
          );

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Successful. Welcome, ${response.phoneNo}!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to the home page
          Navigator.pushReplacementNamed(context, RoutesName.home);
        } else {
          // Show login failure message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.message ?? 'Login failed.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        // Handle any exception that occurs during login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Validate phone number
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (value.length <= 9) {
      return 'Phone number must be at least 10 digits';
    }
    return null;
  }

  // Validate reference number
  String? _validateReference(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your Reference number';
    } else if (value.length <= 5) {
      return 'Reference number must be at least 6 digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                  Container(
                    height: width - 100,
                    color: blue.withOpacity(0.9),
                  ),
                ],
              ),
              Container(
                height: height - width + 100,
                color: white,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 700,
              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 520,
                        padding: const EdgeInsets.all(16),
                        child: Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  const Text(
                                    'Afya Maoni',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Wizara ya Afya Zanzibar',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 10),

                                  // Phone number input
                                  TextFormField(
                                    controller: _phoneController,
                                    decoration: Utils.getDecoration(
                                      labelText: "Ingiza Namba Ya Simu",
                                      hintText: "Namba Ya Simu",
                                      decorationColor: blue,
                                      prefixIcon: Icons.call,
                                    ),
                                    validator: _validatePhone,
                                  ),
                                  const SizedBox(height: 10),

                                  // Reference number input
                                  TextFormField(
                                    controller: _referenceController,
                                    decoration: Utils.getDecoration(
                                      labelText: "Ingiza Reference Number",
                                      hintText: "Reference Number",
                                      decorationColor: blue,
                                      prefixIcon: Icons.numbers,
                                    ),
                                    validator: _validateReference,
                                  ),
                                  const SizedBox(height: 20),

                                  // Login button
                                  ButtonWidget(
                                    title: "Ingia Ndani",
                                    color: blue,
                                    textColor: white,
                                    onPressed: () => _login(context),
                                  ),
                                  const SizedBox(height: 30),
                                  Utils.orDivider('Au Jisajili'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Top logo circle
                      Positioned(
                        top: 0,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: white,
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 50,
                          ),
                        ),
                      ),
                      // Bottom register button
                      Positioned(
                        bottom: 0,
                        left: 32,
                        right: 32,
                        child: ButtonWidget(
                          title: "Jisajili",
                          color: blueAccent,
                          textColor: white,
                          onPressed: () =>
                              Navigator.pushNamed(context, RoutesName.register),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
