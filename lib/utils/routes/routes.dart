import 'package:assetmanag/utils/routes/routes_name.dart';
import 'package:assetmanag/view/about.dart';
import 'package:assetmanag/view/auth/form_registration.dart';

import 'package:assetmanag/view/challenge_module/add_challenge.dart';
import 'package:assetmanag/view/complain_module/add_complain.dart';


import 'package:assetmanag/view/modules/family_planning_education.dart';
import 'package:assetmanag/view/modules/home_module.dart';
import 'package:assetmanag/view/modules/malaria_education.dart';
import 'package:assetmanag/view/modules/mental_health.dart';
import 'package:assetmanag/view/splash_screen.dart';
import 'package:assetmanag/view/staff_module/enrol_number.dart';
import 'package:assetmanag/view/starting_page.dart';
import 'package:assetmanag/view/suggestion_module/maoni.dart';
import 'package:assetmanag/view/swahiliscreen.dart';
import 'package:flutter/material.dart';

import '../../view/auth/login_form.dart';
import '../../view/englishhomescreen.dart';
import '../../view/languageselectionscreen.dart';
import '../../view/modules/family_planning_after_pregnancy.dart';
import '../../view/modules/family_planning_before_pregnancy.dart';
import '../../view/modules/fammily_planning_normal_women.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.about:
        return MaterialPageRoute(builder: (_) => const AboutAppPage());

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
      case RoutesName.challenge:
        return MaterialPageRoute(builder: (context) => const AddChallenge());
      case RoutesName.signIn:
      // Safely get arguments map
        final args = settings.arguments as Map<String, String>? ?? {};
        final role = args['role'] ?? "User"; // Default role
        final initialLanguage = args['language'] ?? "English"; // Default language
        return MaterialPageRoute(
          builder: (context) => SignInPage(
            role: role,
            initialLanguage: initialLanguage,
          ),
        );


      case RoutesName.homePage:
        return MaterialPageRoute(builder: (context) => const HomePage(initialLanguage: 'Kiswahili',));

      case RoutesName.addComplain:
        return MaterialPageRoute(builder: (context) => const AddComplain());

      case RoutesName.maoni:
        return MaterialPageRoute(builder: (context) => const Maoni());

      case RoutesName.enrolNumber:
        return MaterialPageRoute(builder: (context) => EnrolNumber());

      case RoutesName.registration:
      // Safely get arguments map
        final args = settings.arguments as Map<String, String>? ?? {};
        final role = args['role'] ?? "User"; // Default role
        final initialLanguage = args['language'] ?? "English"; // Default language

        return MaterialPageRoute(
          builder: (context) => SignUpPage(
            role: role,
            initialLanguage: initialLanguage,
          ),
        );



      case RoutesName.modulePage:
        return MaterialPageRoute(builder: (context) => const HomeModule());
      case RoutesName.mentalHealth:
        final language = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MentalHealth(initialLanguage: language),
        );
      case RoutesName.malariaModule:
        final language = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => MalariaEducationPage(initialLanguage: language),
        );





      case RoutesName.familyPlanningAfterPregnancy:
        final language = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => FamilyPlanningAfterPregnancyPage(language: language),
        );

      case RoutesName.familyPlanningBeforePregnancy:
        final language = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => FamilyPlanningBeforePregnancyPage(language: language),
        );

      case RoutesName.familyPlanningNormalWomen:
        final language = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => FamilyPlanningForNormalWomenPage(language: language),
        );

      case RoutesName.familyPlanningEducation:
        final language = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => FamilyPlanningEducationPage(language: language),
        );



      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
