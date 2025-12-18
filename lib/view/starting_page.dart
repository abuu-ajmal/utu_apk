import 'package:flutter/material.dart';

import '../utils/routes/routes_name.dart';

class HomePage extends StatefulWidget {
  final String initialLanguage;

  const HomePage({super.key, required this.initialLanguage});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool isSwahili;
  bool showRegistrationMenu = false;

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

  // Open registration expandable menu
  void toggleRegistrationMenu() {
    setState(() {
      showRegistrationMenu = !showRegistrationMenu;
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
              isSwahili ? "Afya Nyumbani" : "Doctor Appointment",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
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
            onPressed: () {},
          ),
        ],
      ),

      body: Stack(
        children: [
          // MAIN PAGE CONTENT
          mainPageContent(),

          // REGISTRATION EXPANDABLE MENU
          if (showRegistrationMenu) registrationMenu(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: showRegistrationMenu ? 1 : 0,
        onTap: (index) {
          if (index == 1) {
            toggleRegistrationMenu();
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: isSwahili ? "Nyumbani" : "Home",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.app_registration),
            label: isSwahili ? "Usajili" : "Registration",
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: isSwahili ? "Mipangilio" : "Settings",
          ),
        ],
      ),
    );
  }

  // =============================
  // MAIN HOME CONTENT
  // =============================
  Widget mainPageContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          // Top Banner Card
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [Colors.green.shade400, Colors.green.shade200],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      isSwahili ? "Karibu!" : "Welcome!",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
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
              Positioned(
                top: 130,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('assets/images/plus.png'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 70),

          // 2 Cards per row
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2 / 3,
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
                      ? "Angalia miadi yako"
                      : "View your appointments",
                  colors: [Colors.orange.shade400, Colors.orange.shade200],
                ),
                buildFeatureCard(
                  icon: Icons.folder_shared,
                  title: isSwahili ? "Rekodi za Afya" : "Health Records",
                  subtitle: isSwahili
                      ? "Historia ya vipimo na matibabu"
                      : "Your medical records",
                  colors: [Colors.blue.shade400, Colors.blue.shade200],
                ),
                buildFeatureCard(
                  icon: Icons.info_outline,
                  title: isSwahili ? "Kuhusu" : "About",
                  subtitle: isSwahili
                      ? "Maelezo kuhusu huduma"
                      : "Learn about this service",
                  colors: [Colors.purple.shade400, Colors.purple.shade200],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============================
  // REGISTRATION EXPANDABLE MENU
  // =============================
  Widget registrationMenu() {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            menuItem(
              icon: Icons.credit_card,
              text: "Identity Registration",
              onTap: () {
                Navigator.pushNamed(context, RoutesName.identity);
              },
            ),
            const Divider(),
            menuItem(
              icon: Icons.school,
              text: "View Professional",
              onTap: () {
                Navigator.pushNamed(context, RoutesName.viewProffessional);
              },
            ),
            const Divider(),
            menuItem(
              icon: Icons.access_time_filled,
              text: "Add Professional",
              onTap: () {
                Navigator.pushNamed(context, RoutesName.addProffessional);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget menuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: Colors.green, size: 28),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
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
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}


