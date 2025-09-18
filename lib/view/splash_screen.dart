import 'dart:async';


import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushNamed(
            // context, 'login_screen'));
            context,
            'starting'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Colors.white, Colors.lightBlue])),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [

              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 28.0),
              child: Text(
                " Wizara ya Afya \n \t \t Zanzibar",
                style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
              Padding(
              padding:  EdgeInsets.only(top:0,left: 28.0,right: 28.0),
              child: LinearProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 0),
              child: Text(
                "version 1.0.1 ",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
