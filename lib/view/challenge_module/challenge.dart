import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Challenge extends StatefulWidget {
  const Challenge({super.key});

  @override
  State<Challenge> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Challenge> {
  void _showRegisterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Are you a staff member?',
            style: TextStyle(fontSize: 14),
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                // Handle Login action
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
            // TextButton(
            //   child: Text('Yes'),
            //   onPressed: () {
            //     // Handle the "Yes" action
            //     print('User  selected: Yes');
            //     Navigator.of(context).pop(); // Close the dialog
            //   },
            // ),
            // TextButton(
            //   child: Text('No'),
            //   onPressed: () {
            //     // Handle the "No" action
            //     print('User  selected: No');
            //     Navigator.of(context).pop(); // Close the dialog
            //   },
            // ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              // Background Container
              Container(
                height: 420,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 92, 175, 243),
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(100.0), // Round bottom left corner
                    bottomRight:
                        Radius.circular(100.0), // Round bottom right corner
                  ),
                ),
              ),
              Container(
                height: 415,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(100.0), // Round bottom left corner
                    bottomRight:
                        Radius.circular(100.0), // Round bottom right corner
                  ),
                ),
              ),
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 92, 175, 243),
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(100.0), // Round bottom left corner
                    bottomRight:
                        Radius.circular(100.0), // Round bottom right corner
                  ),
                ),
              ),
              // Positioned Widgets
              const Positioned(
                right: 100,
                top: 80,
                child: Text(
                  "Welcome to",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
              Positioned(
                right: 130,
                top: 140, // Adjusted to avoid overlap with the previous text
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                ),
              ),
              const Positioned(
                right: 100,
                top: 220, // Adjusted to avoid overlap with the logo
                child: Text(
                  "Wizara Ya Afya",
                  style: TextStyle(color: Colors.white, fontSize: 28),
                ),
              ),
              const Positioned(
                left: 70,
                top: 270, // Adjusted to avoid overlap with the previous text
                child: Text(
                  "ZanAfya Maoni",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
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
              OutlinedButton(
                onPressed: _showRegisterDialog, // Show the dialog on press
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue), // Blue border
                  backgroundColor: Colors.white, // White background
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.blue), // Blue text
                ),
              ),
              const SizedBox(width: 20), // Space between buttons
              // Login Button
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.loginView);
                  // Handle Login action
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue), // Blue border
                  backgroundColor: Colors.white, // White background
                ),
                child: const Text(
                  'Login',
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
          Container(
            width: 120, // Height of the line
            height: 10, // Width of the line
            color: Colors.blue, // Color of the line
          )
        ],
      ),
    );
  }
}
