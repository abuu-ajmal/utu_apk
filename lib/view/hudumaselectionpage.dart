import 'package:flutter/material.dart';

import 'auth/login_form.dart';

class HudumaSelectionPage extends StatelessWidget {
  final String initialLanguage;
  const HudumaSelectionPage({super.key, required this.initialLanguage});

  @override
  Widget build(BuildContext context) {
    // Options based on language
    final List<String> hudumaOptions = initialLanguage == "Swahili"
        ? [
      "Mgonjwa",
      "Afisa Tabibu (CO)",
      "Daktari",
      "Daktari Bingwa",
      "Muuguzi",
      "Mkunga",
      "Famasi",
      "Maabara",
    ]
        : [
      "Patient",
      "Clinical Officer (CO)",
      "Doctor",
      "Specialist Doctor",
      "Nurse",
      "Midwife",
      "Pharmacist",
      "Laboratory",
    ];

    final String title =
    initialLanguage == "Swahili" ? "Chaguo la Aina ya Huduma" : "Select Service Type";
    final String question =
    initialLanguage == "Swahili" ? "Wewe ni nani?" : "Who are you?";

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF0288D1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: hudumaOptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(
                        hudumaOptions[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {
                        // 🚀 Navigate to Sign In Page with selected role
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInPage(
                              role: hudumaOptions[index],
                              initialLanguage: initialLanguage,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
