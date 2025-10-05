import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String initialLanguage; // "Swahili" or "English"

  const HomePage({super.key, required this.initialLanguage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isSwahili;

  @override
  void initState() {
    super.initState();
    isSwahili = widget.initialLanguage == "Swahili";
  }

  void toggleLanguage() {
    setState(() {
      isSwahili = !isSwahili;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isSwahili ? "Afya Mtaani" : "Doctor Appointment",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            Text(
              isSwahili
                  ? "Huduma za miadi na afya"
                  : "Health & Appointment Services",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language, color: Colors.green),
            onPressed: toggleLanguage,
          ),
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.green),
            onPressed: () {
              // TODO: User profile page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top card and logo
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  elevation: 6,
                  shadowColor: Colors.green.shade200,
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(
                      minHeight: 180,
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        colors: [Colors.green.shade400, Colors.green.shade200],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          isSwahili ? "Karibu!" : "Welcome!",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          isSwahili
                              ? "Panga miadi yako na daktari haraka"
                              : "Book your doctor’s appointment easily",
                          style: const TextStyle(color: Colors.white70, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 135,
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/plus.png'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 60),

            // Feature cards grid
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
                children: [
                  buildFeatureCard(
                    icon: Icons.person_search,
                    title: isSwahili ? "Tafuta Daktari" : "Find Doctor",
                    subtitle: isSwahili
                        ? "Pata daktari kulingana na utaalamu"
                        : "Search doctors by specialty",
                    colors: [Colors.green.shade400, Colors.green.shade200],
                  ),
                  buildFeatureCard(
                    icon: Icons.event_available,
                    title: isSwahili ? "Miadi Yangu" : "My Appointments",
                    subtitle: isSwahili
                        ? "Angalia na thibiti miadi yako"
                        : "View & manage your appointments",
                    colors: [Colors.orange.shade400, Colors.orange.shade200],
                  ),
                  buildFeatureCard(
                    icon: Icons.folder_shared,
                    title: isSwahili ? "Rekodi za Afya" : "Health Records",
                    subtitle: isSwahili
                        ? "Historia ya vipimo na matibabu"
                        : "Your health history & reports",
                    colors: [Colors.blue.shade400, Colors.blue.shade200],
                  ),
                  buildFeatureCard(
                    icon: Icons.info_outline,
                    title: isSwahili ? "Kuhusu" : "About",
                    subtitle: isSwahili
                        ? "Jua zaidi kuhusu huduma"
                        : "Learn more about this service",
                    colors: [Colors.purple.shade400, Colors.purple.shade200],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: isSwahili ? "Nyumbani" : "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.event_note),
            label: isSwahili ? "Miadi" : "Appointments",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: isSwahili ? "Mipangilio" : "Settings",
          ),
        ],
      ),
    );
  }

  Widget buildFeatureCard(
      {required IconData icon,
        required String title,
        required String subtitle,
        required List<Color> colors}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 5,
      shadowColor: Colors.grey.shade400,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          // TODO: Navigate to feature page
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45, color: Colors.white),
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 6),
              Text(subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.white70),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
