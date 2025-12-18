import 'package:assetmanag/utils/routes/routes.dart';
import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:assetmanag/view_model/auth_view_login.dart';
import 'package:assetmanag/view_model/change_password_view_model.dart';
import 'package:assetmanag/view_model/identity_view_model.dart';
import 'package:assetmanag/view_model/proffessional_view_model.dart';
import 'package:assetmanag/view_model/register_view_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<CameraDescription>? cams;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cams = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (_) => LoginViewModel(),
        //   lazy: true,
        // ),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => ChangePasswordViewModel(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => RegisterViewModel(),
          lazy: true,
        ),

        ChangeNotifierProvider(
          create: (_) => IdentityViewModel(),
          lazy: true,
        ),

        ChangeNotifierProvider(
          create: (_) => ProfessionalViewModel(),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
