import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/auth_model.dart';
import '../repository/auth_repository.dart';
import '../utils/routes/routes_name.dart';

class AuthViewModel with ChangeNotifier {
  final _authRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  UserModel? _user;
  UserModel? get user => _user;

  int? get userId => _user?.userId; // ✅ Global shortcut for user_id

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  /// Save permanent login token
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  /// Save user_id for global access
  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  /// Save temporary token
  Future<void> saveTempToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('temp_token', token);
  }

  Future<void> login(String login, String password, BuildContext context) async {
    try {
      setLoading(true);

      // API call
      final result = await _authRepo.login(login, password);

      setLoading(false);

      // Invalid login
      if (result.userId == null || result.token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid username or password.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      _user = result;

      // Save user_id for later (IdentityPage etc.)
      await saveUserId(result.userId!);

      final token = result.token ?? '';

      // Must change password
      if (!result.loginStatus) {
        await saveTempToken(token);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please change your password before continuing.'),
            backgroundColor: Colors.orange,
          ),
        );

        Navigator.pushNamed(
          context,
          RoutesName.changePassword,
          arguments: token,
        );
        return;
      }

      // Successful login
      await saveToken(token);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Welcome, ${result.fullName ?? 'User'}!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushNamed(context, RoutesName.homePage);
    } catch (e) {
      setLoading(false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
