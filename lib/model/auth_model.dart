class UserModel {
  final int? userId;
  final String? email;
  final String? phone;
  final String? fullName;
  final String? token;
  final String? message;
  final bool loginStatus;

  UserModel({
    this.userId,
    this.email,
    this.phone,
    this.fullName,
    this.token,
    this.message,
    required this.loginStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    // Normalize login_status
    final rawStatus = data['login_status'];
    bool parsedStatus;
    if (rawStatus is bool) {
      parsedStatus = rawStatus;
    } else if (rawStatus is String) {
      parsedStatus = rawStatus.toLowerCase() == 'true';
    } else if (rawStatus is int) {
      parsedStatus = rawStatus == 1;
    } else {
      parsedStatus = false;
    }

    return UserModel(
      userId: data['user_id'] is String
          ? int.tryParse(data['user_id'] ?? "")
          : data['user_id'],

      email: data['email']?.toString(),
      phone: data['phone']?.toString(),
      fullName: data['full_name']?.toString(),
      token: data['token']?.toString(),
      message: data['message']?.toString() ?? json['message']?.toString(),
      loginStatus: parsedStatus,
    );
  }
}
