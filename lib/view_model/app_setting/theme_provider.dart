import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme { Light, Dark, System }

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;
  AppTheme _appTheme;

  ThemeProvider(this._themeData, this._appTheme);

  ThemeData get themeData => _themeData;
  AppTheme get appTheme => _appTheme;

  void setTheme(AppTheme theme) async {
    _appTheme = theme;
    switch (theme) {
      case AppTheme.Light:
        _themeData = ThemeData.light();
        break;
      case AppTheme.Dark:
        _themeData = ThemeData.dark();
        break;
      case AppTheme.System:
        _themeData = ThemeData.light(); // default theme
        break;
    }
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme.toString());
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');
    if (theme == null) {
      _appTheme = AppTheme.System;
      _themeData = ThemeData.light();
    } else {
      switch (theme) {
        case 'AppTheme.Light':
          _appTheme = AppTheme.Light;
          _themeData = ThemeData.light();
          break;
        case 'AppTheme.Dark':
          _appTheme = AppTheme.Dark;
          _themeData = ThemeData.dark();
          break;
        default:
          _appTheme = AppTheme.System;
          _themeData = ThemeData.light();
          break;
      }
    }
    notifyListeners();
  }
}
