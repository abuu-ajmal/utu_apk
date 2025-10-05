import 'package:assetmanag/utils/routes/routes.dart';
import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:assetmanag/view/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AFYA NYUMBANI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.splash, // au RoutesName.splash
      onGenerateRoute: Routes.generateRoute, // 👈 tumia routes.dart
    );
  }
}
