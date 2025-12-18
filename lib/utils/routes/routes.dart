import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:assetmanag/view/about.dart';
import 'package:assetmanag/view/auth/change_password.dart';
import 'package:assetmanag/view/challenge_module/add_challenge.dart';
import 'package:assetmanag/view/complain_module/add_complain.dart';
import 'package:assetmanag/view/modules/identity_page.dart';
import 'package:assetmanag/view/splash_screen.dart';
import 'package:assetmanag/view/staff_module/enrol_number.dart';
import 'package:assetmanag/view/starting_page.dart';
import 'package:assetmanag/view/suggestion_module/maoni.dart';
import 'package:assetmanag/view/swahiliscreen.dart';
import 'package:flutter/material.dart';

import '../../view/auth/form_registration.dart';
import '../../view/auth/login_form.dart';
import '../../view/englishhomescreen.dart';
import '../../view/languageselectionscreen.dart';
import '../../view/modules/add_proffessional.dart';
import '../../view/modules/view_proffessional.dart';


class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutesName.about:
        return MaterialPageRoute(builder: (_) => const AboutAppPage());

      case RoutesName.viewProffessional:
        return MaterialPageRoute(builder: (_) =>  ViewProfessionalPage());
      case RoutesName.addProffessional:
        return MaterialPageRoute(builder: (_) => const AddProfessionalPage());

      case RoutesName.languageSelection:
        return MaterialPageRoute(builder: (_) => const LanguageSelectionScreen());

      case RoutesName.englishscreen:
        final language = settings.arguments as String? ?? "English";
        return MaterialPageRoute(
          builder: (_) => EnglishHomeScreen(initialLanguage: language),
        );

      case RoutesName.swahiliscreen:
        final language = settings.arguments as String? ?? "Swahili";
        return MaterialPageRoute(
          builder: (_) => SwahiliHomeScreen(initialLanguage: language),
        );

      case RoutesName.signIn:
        final args = settings.arguments as Map<String, String>? ?? {};
        final role = args['role'] ?? "User";
        final initialLanguage = args['language'] ?? "English";
        return MaterialPageRoute(
          builder: (context) => SignInPage(
            role: role,
            initialLanguage: initialLanguage,
          ),
        );

      case RoutesName.registration:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());

      case RoutesName.identity:
        return MaterialPageRoute(builder: (context) =>  IdentityPage());



      case RoutesName.homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(initialLanguage: 'Swahili'),
        );

      case RoutesName.addComplain:
        return MaterialPageRoute(builder: (context) => const AddComplain());

      case RoutesName.maoni:
        return MaterialPageRoute(builder: (context) => const Maoni());

      case RoutesName.changePassword:
        return MaterialPageRoute(builder: (context) => const ChangePasswordScreen());











      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }

    // ✅ This ensures a return even if Dart’s analyzer gets confused
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Unknown route')),
      ),
    );
  }
}
