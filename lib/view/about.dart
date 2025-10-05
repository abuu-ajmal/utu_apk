import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutAppPage extends StatefulWidget {
  const AboutAppPage({super.key});

  @override
  State<AboutAppPage> createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  String appName = "My Health App";
  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appName = packageInfo.appName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.local_hospital, size: 80, color: Colors.green),
                      const SizedBox(height: 10),
                      Text(
                        appName,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text("Version $version (Build $buildNumber)"),
                      const Divider(height: 30, thickness: 1),
                    ],
                  ),
                ),

                const Text(
                  "About",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "This app helps patients to book appointments with doctors, "
                      "get health education, and manage medical information easily.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                const Text(
                  "Developer",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text("Ministry of Health - ICT Team"),
                const SizedBox(height: 4),
                const Text("Contact: support@moh.go.tz"),
                const SizedBox(height: 20),

                const Text(
                  "License",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text("© 2025 Ministry of Health. All rights reserved."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
