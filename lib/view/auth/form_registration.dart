import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../model/register_model.dart';
import '../../view_model/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int _currentStep = 0;

  final _personalFormKey = GlobalKey<FormState>();
  final _contactFormKey = GlobalKey<FormState>();
  final _roleFormKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final phoneController = TextEditingController(text: '');
  final dobController = TextEditingController(text: '');
  final addressController = TextEditingController(text: '');
  final emailController = TextEditingController();

  String? gender;
  String? role;
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RegisterViewModel>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        title: const Text("User Registration"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth < 600 ? double.infinity : 600,
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 6,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AbsorbPointer(
                absorbing: viewModel.loading, // Disable while loading
                child: Column(
                  children: [
                    Expanded(
                      child: Stepper(
                        type: StepperType.horizontal,
                        currentStep: _currentStep,
                        physics: const ClampingScrollPhysics(),
                        onStepContinue: _onStepContinue(viewModel),
                        onStepCancel: () {
                          if (_currentStep > 0) setState(() => _currentStep -= 1);
                        },
                        controlsBuilder:
                            (BuildContext context, ControlsDetails details) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (_currentStep > 0)
                                  ElevatedButton.icon(
                                    onPressed: details.onStepCancel,
                                    icon: const Icon(Icons.arrow_back_ios_new,
                                        size: 16),
                                    label: const Text("Back"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade400,
                                      foregroundColor: Colors.black87,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                    ),
                                  ),
                                viewModel.loading
                                    ? const CircularProgressIndicator(
                                    color: Colors.teal)
                                    : ElevatedButton.icon(
                                  onPressed: details.onStepContinue,
                                  icon: Icon(
                                    _currentStep == 2
                                        ? Icons.check_circle
                                        : Icons.arrow_forward_ios,
                                    size: 18,
                                  ),
                                  label: Text(_currentStep == 2
                                      ? "Submit"
                                      : "Next Step"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(12)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        steps: _buildSteps(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: const Icon(Icons.person, color: Colors.teal),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _personalFormKey,
          child: Column(
            children: [
              _buildTextField(fullNameController, "Full Name *"),
              const SizedBox(height: 10),
              _buildDobField(),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: gender,
                items: const [
                  DropdownMenuItem(value: "Male", child: Text("Male")),
                  DropdownMenuItem(value: "Female", child: Text("Female")),
                ],
                onChanged: (val) => setState(() => gender = val),
                decoration: _inputDecoration("Gender *"),
                validator: (value) => value == null ? "Select gender" : null,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Icon(Icons.contact_phone, color: Colors.teal),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _contactFormKey,
          child: Column(
            children: [
              _buildTextField(phoneController, "Phone *", isNumeric: true),
              const SizedBox(height: 10),
              _buildTextField(emailController, "Email"),
              const SizedBox(height: 10),
              TextFormField(
                controller: addressController,
                decoration: _inputDecoration("Address"),
                keyboardType: TextInputType.text,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Icon(Icons.badge, color: Colors.teal),
        isActive: _currentStep >= 2,
        content: Form(
          key: _roleFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: "client", child: Text("Client")),
                  DropdownMenuItem(
                      value: "professional", child: Text("Professional")),
                ],
                onChanged: (val) => setState(() => role = val),
                decoration: _inputDecoration("Role *"),
                validator: (value) => value == null ? "Select role" : null,
              ),
              const SizedBox(height: 15),
              const Text(
                "By registering, you agree to provide accurate and truthful information.",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              CheckboxListTile(
                title: const Text("I agree to the terms and conditions"),
                value: termsAccepted,
                onChanged: (val) => setState(() => termsAccepted = val ?? false),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildDobField() {
    return TextFormField(
      controller: dobController,
      readOnly: true,
      decoration: _inputDecoration("Date of Birth *", hint: "YYYY-MM-DD")
          .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
      validator: (value) => value!.isEmpty ? "Enter date of birth" : null,
      onTap: () async {
        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (selectedDate != null) {
          dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
          setState(() {});
        }
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {String? hint, bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      decoration: _inputDecoration(label, hint: hint),
      validator: isNumeric || label == "Email"
          ? null
          : (value) => value!.isEmpty ? "Required field" : null,
    );
  }

  InputDecoration _inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.teal),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.teal, width: 2),
      ),
    );
  }

  VoidCallback _onStepContinue(RegisterViewModel viewModel) {
    return () {
      if (_currentStep == 0 && _personalFormKey.currentState!.validate()) {
        setState(() => _currentStep += 1);
      } else if (_currentStep == 1 &&
          _contactFormKey.currentState!.validate()) {
        setState(() => _currentStep += 1);
      } else if (_currentStep == 2) {
        if (_roleFormKey.currentState!.validate() && termsAccepted) {
          final model = RegisterModel(
            fullName: fullNameController.text.trim(),
            dob: dobController.text.trim(),
            gender: gender ?? '',
            phone: phoneController.text.trim(),
            email: emailController.text.trim(),
            address: addressController.text.trim(),
            role: role ?? '',
            terms_accepted: termsAccepted,
          );
          viewModel.registerUser(model, context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please accept the terms.")),
          );
        }
      }
    };
  }
}
