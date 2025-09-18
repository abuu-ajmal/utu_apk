import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {
  void _showRegisterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you a Client member?',
            style: TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.enrolNumber);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue), // Blue border
                backgroundColor: Colors.white, // White background
              ),
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.blue), // Blue text
              ),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.register);
                // Handle Login action
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.blue), // Blue border
                backgroundColor: Colors.white, // White background
              ),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.blue), // Blue text
              ),
            ),

          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                // Background Container
                Container(
                  height: 370,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 92, 175, 243),
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(120.0), // Round bottom left corner
                      bottomRight:
                          Radius.circular(120.0), // Round bottom right corner
                    ),
                  ),
                ),
                Container(
                  height: 365,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(120.0), // Round bottom left corner
                      bottomRight:
                          Radius.circular(120.0), // Round bottom right corner
                    ),
                  ),
                ),
                Container(
                  height: 360,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 92, 175, 243),
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(120.0), // Round bottom left corner
                      bottomRight:
                          Radius.circular(120.0), // Round bottom right corner
                    ),
                  ),
                ),
                // Positioned Widgets
                const Positioned(
                  right: 100,
                  top: 80,
                  child: Text(
                    "Welcome to",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: 130,
                  top: 130, // Adjusted to avoid overlap with the previous text
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 100,
                  ),
                ),
                const Positioned(
                  left: 75,
                  top: 210, // Adjusted to avoid overlap with the logo
                  child: Text(
                    "Ministry of Health",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
                const Positioned(
                  left: 70,
                  top: 270, // Adjusted to avoid overlap with the previous text
                  child: Text(
                    "COMMUNITY HEALTH",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50), // Space below the stack
            // Buttons Row
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Register Button
                // OutlinedButton(
                //   onPressed: _showRegisterDialog, // Show the dialog on press
                //   style: OutlinedButton.styleFrom(
                //     side: const BorderSide(color: Colors.blue), // Blue border
                //     backgroundColor: Colors.white, // White background
                //   ),
                //   child: const Text(
                //     'Register',
                //     style: TextStyle(color: Colors.blue), // Blue text
                //   ),
                // ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.enrolNumber);
                    // Handle Login action
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue), // Blue border
                    backgroundColor: Colors.white, // White background
                  ),
                  child: const Text(
                    'Client Login',
                    style: TextStyle(color: Colors.blue), // Blue text
                  ),
                ),
                const SizedBox(width: 20), // Space between buttons
                // Login Button
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.modulePage);
                    // Handle Login action
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue), // Blue border
                    backgroundColor: Colors.white, // White background
                  ),
                  child: const Text(
                    'Education',
                    style: TextStyle(color: Colors.blue), // Blue text
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Text(
                      'Not able to login?',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        print("ipo kwenye matengenezo");
                      },
                      child: const Text(
                        "Click here",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "version 1.0.1",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 120, // Width of the line
                height: 10, // Height of the line
                decoration: const BoxDecoration(
                  color: Colors.blue, // Color of the line
                  borderRadius: BorderRadius.all(
                      Radius.circular(20) // Round bottom right corner
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
