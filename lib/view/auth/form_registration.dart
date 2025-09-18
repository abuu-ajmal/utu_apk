import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../utils/api_call.dart';
import '../../utils/utils.dart';

class FormRegistration extends StatefulWidget {
  const FormRegistration({super.key});

  @override
  State<FormRegistration> createState() => _FormRegistrationState();
}

class _FormRegistrationState extends State<FormRegistration> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  String _gender = "Male";
  List<Map<String, dynamic>> _locations = [];
  String? _selectedLocationId;

  @override
  void initState() {
    super.initState();
    // _fetchLocations();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _fetchLocations(); // Fetch locations
    // Fetch genders
  }

  Future<void> _fetchLocations() async {
    try {
      final response = await http.get(Uri.parse(ApiCall.locationApi));
      final Map<String, dynamic> responseJson = jsonDecode(response.body);


      if (responseJson.containsKey('data')) {
        final List<dynamic> locationsJson = responseJson['data'];

        print('Fetched Locations: $locationsJson');
        setState(() {
          _locations = locationsJson.map((location) => {
            'location_id': location['location_id'],
            'location_name': location['location_name']
          }).toList();
        });
      } else {
        print('No data found in the response');
      }
    } catch (e) {
      print('Error fetching locations: $e');
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      Map<String, dynamic> formData = {
        'first_name': _firstNameController.text,
        'middle_name': _middleNameController.text,
        'last_name': _lastNameController.text,
        'phone_no': _phoneController.text,
        'email': _emailController.text,
        'gender': _gender,
        'location_id': _selectedLocationId.toString(),
      };

      const String apiUrl = "http://192.168.43.132:8000/api/storeClient";
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(formData),
        );

        var responseBody = jsonDecode(response.body);
        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration Successful')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseBody['message'] ?? 'Failed to Register')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
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
              // Background logo and overlay container
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                  Container(
                    height: width - 160,
                    color: Colors.blue.withOpacity(0.9),
                  ),
                ],
              ),
              Container(
                height: height - width + 100,
                color: Colors.white,
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(

              child: ListView(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(

                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 70, bottom: 20),
                        child: Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const Text(
                                    'Registration Form',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),

                                  // First Name
                                  Consumer(
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        controller: _firstNameController,
                                        decoration: Utils.getDecoration(
                                          labelText: "First Name",
                                          hintText: "Enter First Name",
                                          decorationColor: Colors.blue,
                                          prefixIcon: Icons.person,
                                        ),
                                        validator: (value) => value!.isEmpty ? 'Enter First Name' : null,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10),

                                  Consumer(
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        controller: _middleNameController,
                                        decoration: Utils.getDecoration(
                                          labelText: "Middle Name",
                                          hintText: "Enter Middle Name",
                                          decorationColor: Colors.blue,
                                          prefixIcon: Icons.person_outline,
                                        ),
                                        validator: (value) => value!.isEmpty ? 'Enter Middle Name' : null,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10),

                                  Consumer(
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        controller: _lastNameController,
                                        decoration: Utils.getDecoration(
                                          labelText: "Last Name",
                                          hintText: "Enter Last Name",
                                          decorationColor: Colors.blue,
                                          prefixIcon: Icons.person_outline,
                                        ),
                                        validator: (value) => value!.isEmpty ? 'Enter Last Name' : null,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10),

                                  Consumer(
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        controller: _phoneController,
                                        decoration: Utils.getDecoration(
                                          labelText: "Phone Number",
                                          hintText: "Enter Phone Number",
                                          decorationColor: Colors.blue,
                                          prefixIcon: Icons.phone,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        validator: (value) =>
                                        value!.length < 10 ? 'Enter a valid phone number' : null,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10),

                                  Consumer(
                                    builder: (context, value, child) {
                                      return TextFormField(
                                        controller: _emailController,
                                        decoration: Utils.getDecoration(
                                          labelText: "Email",
                                          hintText: "Enter Email",
                                          decorationColor: Colors.blue,
                                          prefixIcon: Icons.email,
                                        ),
                                        keyboardType: TextInputType.emailAddress,
                                        validator: (value) =>
                                        value!.isEmpty ? 'Enter a valid email address' : null,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10),

// Gender Selection
                                  Row(
                                    children: [
                                      const Text("Gender: "),
                                      Radio(
                                        value: "Male",
                                        groupValue: _gender,
                                        onChanged: (value) => setState(() => _gender = value!),
                                      ),
                                      const Text("Male"),
                                      Radio(
                                        value: "Female",
                                        groupValue: _gender,
                                        onChanged: (value) => setState(() => _gender = value!),
                                      ),
                                      const Text("Female"),
                                    ],
                                  ),
                                  SizedBox(height: 10),

// Location Dropdown
                                  Consumer(
                                    builder: (context, value, child) {
                                      return DropdownButtonFormField<String>(
                                        value: _selectedLocationId,
                                        items: _locations.map((location) {
                                          return DropdownMenuItem<String>(
                                            value: location['location_id'].toString(),
                                            child: Text(location['location_name']),
                                          );
                                        }).toList(),
                                        onChanged: (value) => setState(() => _selectedLocationId = value),
                                        decoration: Utils.getDecoration(
                                          labelText: "Select Location",
                                          hintText: "Choose Location",
                                          decorationColor: Colors.blue,
                                          prefixIcon: Icons.location_on,
                                        ),
                                        validator: (value) =>
                                        value == null ? 'Please select a location' : null,
                                      );
                                    },
                                  ),
                                  SizedBox(height: 10),

// Submit Button
                                  Consumer(
                                    builder: (context, value, child) {
                                      return ElevatedButton(
                                        onPressed: _register,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueAccent,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Text("Register"),
                                      );
                                    },
                                  ),

                                  // Location Dropdown

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
