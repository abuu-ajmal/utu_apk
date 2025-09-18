import 'package:flutter/material.dart';
import '../../utils/routes/routes_name.dart';
import 'malaria_education.dart';

class HomeModule extends StatefulWidget {
  const HomeModule({super.key});

  @override
  State<HomeModule> createState() => _HomeModuleState();
}

class _HomeModuleState extends State<HomeModule> {
  String selectedLanguage = 'en';

  final List<String> moduleKeys = [
    "Malaria Visit",
    "Family Planning",
    "Mental Health"
  ];

  final Map<String, String> moduleIcons = {
    "Malaria Visit": "🦟",
    "Family Planning": "👨‍👩‍👧‍👦",
    "Mental Health": "🧠",
  };

  final Map<String, Map<String, String>> translations = {
    'en': {
      "Malaria Visit": "Malaria Visit",
      "Family Planning": "Family Planning",
      "Mental Health": "Mental Health"

    },
    'sw': {
      "Malaria Visit": "Ziara ya Malaria",
      "Family Planning": "Uzazi wa Mpango",
      "Mental Health": "Afya ya Akili"

    },
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          // Header
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 320,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 92, 175, 243),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(120.0),
                    bottomRight: Radius.circular(120.0),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                child: Container(
                  height: 310,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120.0),
                      bottomRight: Radius.circular(120.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                child: Container(
                  height: 300,
                  width: screenWidth,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 92, 175, 243),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(120.0),
                      bottomRight: Radius.circular(120.0),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 20,
                right: 16,
                child: DropdownButton<String>(
                  value: selectedLanguage,
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.language, color: Colors.white),
                  underline: const SizedBox(),
                  onChanged: (value) {
                    setState(() {
                      selectedLanguage = value!;
                    });
                  },
                  items: [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'sw', child: Text('Kiswahili')),
                  ],
                ),
              ),
              Positioned(
                top: 60,
                child: Column(
                  children: [
                    const Text(
                      "Welcome to",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/images/logo.png',
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Ministry of Health",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "COMMUNITY HEALTH",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                translations[selectedLanguage]?["Community Health Modules"] ?? "Community Health Modules",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Scrollable card list inside Expanded
          Expanded(
            child: ListView.builder(
              itemCount: moduleKeys.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final key = moduleKeys[index];
                final title = translations[selectedLanguage]?[key] ?? key;
                final icon = moduleIcons[key]!;

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: Text(icon, style: const TextStyle(fontSize: 24)),
                    ),
                    title: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                      onTap: () {
                        if (key == 'Malaria Visit') {
                          Navigator.pushNamed(
                            context,
                            RoutesName.malariaModule,
                            arguments: selectedLanguage,
                          );
                        } else  if (key == 'Mental Health') {
                          Navigator.pushNamed(
                            context,
                            RoutesName.mentalHealth,
                            arguments: selectedLanguage,
                          );
                        }
                        else if (key == 'Family Planning') {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) {
                              final isSwahili = selectedLanguage == 'sw';
                              final options = isSwahili
                                  ? [
                                    'Elimu kuhusu Uzazi wa mpango',
                                'Uzazi wa Mpango baada ya ujauzito',
                                'Uzazi wa Mpango kabla ya ujauzito',
                                'Uzazi wa Mpango kwa wanawake wa kawaida',
                              ]
                                  : [
                                    'Family Planning Education',
                                'Family Planning After Pregnancy',
                                'Family Planning Before Pregnancy',
                                'Family Planning for Normal Women',
                              ];

                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    isSwahili
                                        ? 'Chagua aina ya uzazi wa mpango'
                                        : 'Choose Family Planning Type',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const Divider(),
                                  ...options.asMap().entries.map((entry) {
                                    final index = entry.key;
                                    final option = entry.value;

                                    return ListTile(
                                      leading: const Icon(Icons.check_circle_outline),
                                      title: Text(option),
                                      onTap: () {
                                        Navigator.pop(context); // Close the bottom sheet

                                        // Navigate based on selected index
                                        switch (index) {
                                          case 0:
                                            Navigator.pushNamed(
                                              context,
                                              RoutesName.familyPlanningEducation,
                                              arguments: selectedLanguage,
                                            );
                                            break;
                                          case 1:
                                            Navigator.pushNamed(
                                              context,
                                              RoutesName.familyPlanningAfterPregnancy,
                                              arguments: selectedLanguage,
                                            );
                                            break;
                                          case 2:
                                            Navigator.pushNamed(
                                              context,
                                              RoutesName.familyPlanningBeforePregnancy,
                                              arguments: selectedLanguage,
                                            );
                                            break;
                                          case 3:
                                            Navigator.pushNamed(
                                              context,
                                              RoutesName.familyPlanningNormalWomen,
                                              arguments: selectedLanguage,
                                            );
                                            break;
                                        }
                                      },
                                    );
                                  }).toList(),
                                  const SizedBox(height: 60),
                                ],
                              );
                            },
                          );
                        }
                      }





                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
