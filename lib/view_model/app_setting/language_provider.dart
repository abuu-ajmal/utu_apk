import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en');
  Locale get locale => _locale;

  LanguageProvider() {
   // _loadLocale();
  }

  // Future<void> _loadLocale() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String localeCode = prefs.getString('locale') ?? 'en';
  //   _locale = Locale(localeCode);
  //   await TranslationService.load(localeCode);
  //   notifyListeners();
  // }
  //
  // Future<void> changeLanguage(String languageCode) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   _locale = Locale(languageCode);
  //   prefs.setString('locale', languageCode);
  //   await TranslationService.load(languageCode);
  //   notifyListeners();
  // }
}
