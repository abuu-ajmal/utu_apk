class LoginResponse {
  final int clientId;
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNo;
  final String gender;
  final String email;
  final String message;

  LoginResponse({
    required this.clientId,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNo,
    required this.gender,
    required this.email,
    required this.message,
  });

  // Factory method to safely parse JSON
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      clientId: json['client_id'] ?? 0, // Default to 0 if null
      firstName: json['first_name'] ?? '',
      middleName: json['middle_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      gender: json['gender'] ?? '',
      email: json['email'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
