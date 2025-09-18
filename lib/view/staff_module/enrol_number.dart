import 'dart:convert';
import 'package:assetmanag/utils/colors.dart';
import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:assetmanag/utils/utils.dart';
import 'package:assetmanag/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class EnrolNumber extends StatefulWidget {
  const EnrolNumber({super.key});

  @override
  State<EnrolNumber> createState() => _EnrolNumberState();
}

class _EnrolNumberState extends State<EnrolNumber> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _matibabuNoController = TextEditingController();
  bool isLoading = false;

  Future<void> loginMatibabu() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:8000/api/matibabu_login"), // change to server IP
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"matibabu_no": _matibabuNoController.text}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['hasAccount'] == true) {
        Utils.showSnackBar(context, data['message'], Colors.green);
        Navigator.pushNamed(context, RoutesName.home); // change to your next screen
      } else {
        Utils.showSnackBar(context, data['message'] ?? "Login failed", Colors.red);
      }
    } catch (e) {
      Utils.showSnackBar(context, "Error: $e", Colors.red);
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(alignment: Alignment.center, children: [
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
                height: 550,
                child: ListView(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 500,
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 50, bottom: 20),
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
                                          'Community Health',
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
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          controller: _matibabuNoController,
                                          decoration: Utils.getDecoration(
                                            labelText:
                                            "Ingiza No. ya kadi matibabu",
                                            hintText: "Matibabu kadi",
                                            decorationColor: blue,
                                            prefixIcon: Icons.call,
                                          ),
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return 'Tafadhali ingiza Kadi Matibabu';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 16),
                                        const SizedBox(height: 30),
                                        Utils.orDivider('Staff Only')
                                      ],
                                    ))),
                          ),
                        ),
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
                        Positioned(
                            bottom: 0,
                            left: 32,
                            right: 32,
                            child: Consumer(
                                builder: (context, value, child) {
                                  return ButtonWidget(
                                    title: "Rudi Nyuma",
                                    color: blueAccent,
                                    textColor: white,
                                    onPressed: () => Navigator.pushNamed(
                                        context, RoutesName.starting),
                                  );
                                }))
                      ],
                    ),
                  ],
                ),
              ))
        ]));
  }
}
