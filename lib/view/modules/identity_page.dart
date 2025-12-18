import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_login.dart';
import '../../view_model/identity_view_model.dart';

class IdentityPage extends StatefulWidget {
  @override
  _IdentityPageState createState() => _IdentityPageState();
}

class _IdentityPageState extends State<IdentityPage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedIdentityType;
  final identityNumberController = TextEditingController();

  File? selectedDocument;

  @override
  void initState() {
    super.initState();
    // Load identities for the current logged-in user
    Future.microtask(() {
      final authUserId =
          Provider.of<AuthViewModel>(context, listen: false).user?.userId;
      if (authUserId != null) {
        Provider.of<IdentityViewModel>(context, listen: false)
            .getIdentities(context);
      }
    });
  }

  /// Pick PDF document
  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );

    if (result != null) {
      setState(() {
        selectedDocument = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<IdentityViewModel>(context);
    final authUserId = Provider.of<AuthViewModel>(context).user?.userId;

    // Filter identities for logged-in user
    final userIdentities = provider.identities
        .where((item) => item.userId == authUserId)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Identity Information"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// FORM
            Form(
              key: _formKey,
              child: Column(
                children: [
                  /// ID TYPE DROPDOWN
                  DropdownButtonFormField<String>(
                    value: selectedIdentityType,
                    decoration: const InputDecoration(
                      labelText: "Identity Type",
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: "ZANID", child: Text("ZANID")),
                      DropdownMenuItem(value: "NIDA", child: Text("NIDA")),
                      DropdownMenuItem(value: "Passport", child: Text("Passport")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedIdentityType = value!;
                      });
                    },
                    validator: (value) =>
                    value == null ? "Please select identity type" : null,
                  ),

                  const SizedBox(height: 12),

                  /// ID NUMBER
                  TextFormField(
                    controller: identityNumberController,
                    decoration: const InputDecoration(
                      labelText: "Identity Number",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value!.isEmpty ? "Enter identity number" : null,
                  ),

                  const SizedBox(height: 12),

                  /// FILE PICKER BUTTON
                  ElevatedButton.icon(
                    onPressed: pickDocument,
                    icon: const Icon(Icons.upload_file),
                    label: Text(selectedDocument == null
                        ? "Upload Identity Document (PDF)"
                        : "File Selected"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// SUBMIT BUTTON
                  provider.loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (selectedDocument == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please upload a PDF file"),
                            ),
                          );
                          return;
                        }

                        if (authUserId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("User not logged in"),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        Map<String, dynamic> data = {
                          "identity_type": selectedIdentityType,
                          "identity_number": identityNumberController.text,
                        };

                        bool success = await provider.registerIdentity(
                            data, selectedDocument, context);

                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text("Identity registered successfully"),
                              backgroundColor: Colors.green,
                            ),
                          );

                          // Clear form
                          setState(() {
                            selectedIdentityType = null;
                            identityNumberController.clear();
                            selectedDocument = null;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text("Failed to register identity"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Register Identity"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Your Saved Identities",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            /// LIST OF OWN IDENTITIES
            Expanded(
              child: provider.loading
                  ? const Center(child: CircularProgressIndicator())
                  : userIdentities.isEmpty
                  ? const Center(child: Text("No identity records found"))
                  : ListView.builder(
                itemCount: userIdentities.length,
                itemBuilder: (context, index) {
                  final id = userIdentities[index];

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    child: ListTile(
                      title: Text(id.identityType),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Number: ${id.identityNumber}"),
                          Text("Document: ${id.identityDocument}"),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.picture_as_pdf,
                            color: Colors.red),
                        onPressed: () {
                          // TODO: Open PDF viewer
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
