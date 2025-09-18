class Location {
  final String locationId;
  final String locationName;

  Location({
    required this.locationId,
    required this.locationName,
  });

  // Factory to convert from JSON
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationId: json['location_id'].toString(),
      locationName: json['location_name'],
    );
  }
}
