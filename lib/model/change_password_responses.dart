class ChangePasswordResponse {
  final bool success;
  final String message;
  final int statusCode;

  ChangePasswordResponse({
    required this.success,
    required this.message,
    required this.statusCode,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }
}
