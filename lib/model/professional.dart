class ProfessionalModel {
  final int professionalId;
  final String status;

  final String? photo;
  final String? cv;
  final String? license;
  final String? workPermit;
  final String? certificate;

  final TitleModel? title;
  final SpecializationModel? specialization;
  final EducationModel? education;
  final List<ServiceModel> services;

  static const String baseUrl = "http://192.168.1.15:8000/";

  ProfessionalModel({
    required this.professionalId,
    required this.status,
    this.photo,
    this.cv,
    this.license,
    this.workPermit,
    this.certificate,
    this.title,
    this.specialization,
    this.education,
    required this.services,
  });

  factory ProfessionalModel.fromJson(Map<String, dynamic> json) {
    return ProfessionalModel(
      professionalId: json["professional_id"],
      status: json["status"] ?? "Pending",

      // ---------------- DOCUMENTS ----------------
      photo: json["photo"] != null ? baseUrl + json["photo"] : null,
      cv: json["cv"] != null ? baseUrl + json["cv"] : null,
      license: json["license"] != null ? baseUrl + json["license"] : null,
      workPermit: json["work_permit"] != null ? baseUrl + json["work_permit"] : null,
      certificate: json["education_level_certificate"] != null
          ? baseUrl + json["education_level_certificate"]
          : null,

      // ---------------- RELATIONS ----------------
      title: json["title"] != null ? TitleModel.fromJson(json["title"]) : null,
      specialization: json["specialization"] != null
          ? SpecializationModel.fromJson(json["specialization"])
          : null,
      education: json["education_level"] != null
          ? EducationModel.fromJson(json["education_level"])
          : null,
      services: json["services"] != null
          ? List<ServiceModel>.from(
          json["services"].map((x) => ServiceModel.fromJson(x)))
          : [],
    );
  }
}

class TitleModel {
  final String title;
  TitleModel({required this.title});

  factory TitleModel.fromJson(Map<String, dynamic> json) {
    return TitleModel(title: json["title"]);
  }
}

class SpecializationModel {
  final String name;
  SpecializationModel({required this.name});

  factory SpecializationModel.fromJson(Map<String, dynamic> json) {
    return SpecializationModel(name: json["name"]);
  }
}

class EducationModel {
  final String level;
  EducationModel({required this.level});

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    return EducationModel(level: json["level"]);
  }
}

class ServiceModel {
  final int serviceId;
  final String serviceName;

  ServiceModel({
    required this.serviceId,
    required this.serviceName,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      serviceId: json["service_id"],
      serviceName: json["service_name"],
    );
  }
}
