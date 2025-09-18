import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // Keys for shared preferences
  static const String _keyClientId = 'client_id';
  static const String _keyFirstName = 'first_name';
  static const String _keyMiddleName = 'middle_name';
  static const String _keyLastName = 'last_name';
  static const String _keyPhoneNo = 'phone_no';
  static const String _keyGender = 'gender';
  static const String _keyEmail = 'email';

  // Save user data
  Future<void> saveUserData({
    required int clientId,
    required String firstName,
    required String middleName,
    required String lastName,
    required String phoneNo,
    required String gender,
    required String email,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt(_keyClientId, clientId);
    await prefs.setString(_keyFirstName, firstName);
    await prefs.setString(_keyMiddleName, middleName);
    await prefs.setString(_keyLastName, lastName);
    await prefs.setString(_keyPhoneNo, phoneNo);
    await prefs.setString(_keyGender, gender);
    await prefs.setString(_keyEmail, email);
  }

  // Get user data
  Future<Map<String, dynamic>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return {
      'client_id': prefs.getInt(_keyClientId) ?? 0,
      'first_name': prefs.getString(_keyFirstName) ?? '',
      'middle_name': prefs.getString(_keyMiddleName) ?? '',
      'last_name': prefs.getString(_keyLastName) ?? '',
      'phone_no': prefs.getString(_keyPhoneNo) ?? '',
      'gender': prefs.getString(_keyGender) ?? '',
      'email': prefs.getString(_keyEmail) ?? '',
    };
  }

  // Get single field data
  Future<String?> getUserField(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Check if user is logged in
  Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyClientId);
  }

  // Clear session data (for logout)
  Future<void> clearSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
