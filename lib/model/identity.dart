class IdentityModel {
  final int identitiesId;
  final int userId;
  final String identityType;
  final String identityNumber;
  final String identityDocument;

  IdentityModel({
    required this.identitiesId,
    required this.userId,
    required this.identityType,
    required this.identityNumber,
    required this.identityDocument,
  });

  factory IdentityModel.fromJson(Map<String, dynamic> json) {
    return IdentityModel(
      identitiesId: json['identities_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      identityType: json['identity_type']?.toString() ?? "",
      identityNumber: json['identity_number']?.toString() ?? "",
      identityDocument: json['identity_document']?.toString() ?? "",
    );
  }
}
