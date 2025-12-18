class RegisterModel {
  final String? fullName;
  final String? dob;
  final String? gender;
  final String? phone;
  final String? email;
  final String? address;
  final String? role;
  final bool? terms_accepted;

  final String? message;
  final int? userId;

  // NEW → Password returned from server
  final String? password;

  RegisterModel({
    this.fullName,
    this.dob,
    this.gender,
    this.phone,
    this.email,
    this.address,
    this.role,
    this.terms_accepted,
    this.message,
    this.userId,
    this.password, // NEW
  });

  // -------------------------------
  //  FROM JSON
  // -------------------------------
  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return RegisterModel(
      fullName: data['full_name'],
      dob: data['dob'],
      gender: data['gender'],
      phone: data['phone'],
      email: data['email'],
      address: data['address'],
      role: data['role'],
       userId: data['user_id'],


      message: json['message'] ?? data['message'],

      // NEW → Accept password from API response
      password: data['password'] ?? json['password'],

      terms_accepted: true,
    );
  }

  // -------------------------------
  //  TO JSON (For sending to API)
  // -------------------------------
  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "dob": dob,
      "gender": gender,
      "phone": phone,
      "email": email,
      "address": address,
      "role": role,
      "terms_accepted": terms_accepted == true ? "1" : "0",
    };
  }
}
