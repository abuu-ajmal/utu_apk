import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0288D1), Color(0xFF4FC3F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🌍 Animated Icon
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: const Icon(
                Icons.language,
                size: 100,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              "Select App Language\nChagua Lugha",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 60),

            // 🇬🇧 English button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                elevation: 5,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.englishscreen,
                   arguments: "English",
                );
              },
              icon: const Text("🇬🇧", style: TextStyle(fontSize: 24)),
              label: const Text(
                "English",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),

            const SizedBox(height: 20),

            // 🇹🇿 Kiswahili button
            // Kiswahili button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                elevation: 5,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.swahiliscreen,
                   arguments: "Kiswahili", // pass the language explicitly
                );
              },
              icon: const Text("🇹🇿", style: TextStyle(fontSize: 24)),
              label: const Text(
                "Kiswahili",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
