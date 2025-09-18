import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:shaky_animated_listview/animators/grid_animator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> _userData = {};

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("Loading user data...");
    print("First Name: ${prefs.getString('first_name')}");
    print("Last Name: ${prefs.getString('last_name')}");
    print("Phone: ${prefs.getString('phone_no')}");
    print("Email: ${prefs.getString('email')}");

    setState(() {
      _userData = {
        'first_name': prefs.getString('first_name') ?? '',
        'last_name': prefs.getString('last_name') ?? '',
        'phone_no': prefs.getString('phone_no') ?? '',
        'email': prefs.getString('email') ?? '',
      };
    });
  }


  Widget _buildUserInfo() {
    return _userData.isEmpty
        ? const CircularProgressIndicator()
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Welcome, ${_userData['first_name']} ${_userData['last_name']}"),
        Text("Phone: ${_userData['phone_no']}"),
        Text("Email: ${_userData['email']}"),
      ],
    );
  }

  Widget _buildGridItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GridAnimatorWidget(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Container(
              color: cyan,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: Colors.white, size: 40.0),
                  const SizedBox(height: 8),
                  Text(title, style: cardTextStyle, textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(height: 120, color: cyan),
                      const SizedBox(height: 100),
                    ],
                  ),
                  Positioned(left: 90, top: 90, child: _circleIndicator()),
                  Positioned(right: 90, top: 90, child: _circleIndicator()),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: cyan,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: white,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 130,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(child: _buildUserInfo()),
            SizedBox(
              height: MediaQuery.of(context).size.height - 220,
              child: GridView.count(
                crossAxisCount: 3,
                children: [
                  _buildGridItem(
                    icon: Icons.speaker,
                    title: "Tuma\nMalalamiko",
                    onTap: () => Navigator.pushNamed(context, RoutesName.addComplain),
                  ),
                  _buildGridItem(
                    icon: Icons.email_rounded,
                    title: "Tuna\nMaoni",
                    onTap: () => Navigator.pushNamed(context, RoutesName.maoni),
                  ),
                  _buildGridItem(
                    icon: Icons.question_answer_outlined,
                    title: "Uliza\nMaswali",
                    onTap: () {},
                  ),
                  _buildGridItem(
                    icon: Icons.speaker_group_outlined,
                    title: "Malalamiko\nYaliyohifadhiwa",
                    onTap: () {},
                  ),
                  _buildGridItem(
                    icon: Icons.feedback_outlined,
                    title: "Tupe\nMrejesho",
                    onTap: () {},
                  ),
                  _buildGridItem(
                    icon: Icons.email_outlined,
                    title: "Tuma\nChangamoto",
                    onTap: () => Navigator.pushNamed(context, RoutesName.challenge),
                  ),
                  _buildGridItem(
                    icon: Icons.account_circle,
                    title: "Wasifu\nWangu",
                    onTap: () {},
                  ),
                  _buildGridItem(
                    icon: Icons.handshake_sharp,
                    title: "Tupe\nPongezi",
                    onTap: () {},
                  ),
                  _buildGridItem(
                    icon: Icons.login,
                    title: "Toka Nje",
                    onTap: () => Utils.showAlertDialog(
                      context: context,
                      onApprove: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.loginView,
                            (Route<dynamic> route) => false,
                      ),
                      onCancel: () {},
                      title: 'Kutoka Nje',
                      message: const Text('Huwezi kuingia tena mpaka uingize nambari yako ya simu'),
                      icon: Icons.warning,
                      color: red,
                      confirmButtonName: 'Toka',
                      cancelButtonName: 'Ghairi',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleIndicator() {
    return CircleAvatar(
      radius: 30,
      backgroundColor: cyan.withOpacity(0.5),
    );
  }
}
