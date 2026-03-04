class Place {
  final String title;
  final String image;
  final String description;
  final String workingHours;
  final String modelPath;
  final String category;
  final String locationName;
  final double latitude;
  final double longitude;

  final String? plusCode; // 👈 الجديد

  Place({
    required this.title,
    required this.image,
    required this.description,
    required this.workingHours,
    required this.modelPath,
    required this.category,
    required this.locationName,
    required this.latitude,
    required this.longitude,
    this.plusCode, // 👈 الجديد
  });
}