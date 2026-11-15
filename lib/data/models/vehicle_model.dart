class VehicleModel {
  final String id;
  final String manufacturer;
  final String model;
  final int year;
  final String generation;
  final String nickname;
  final String imageAsset;
  final String status;
  final Map<String, String> specs;

  const VehicleModel({
    required this.id,
    required this.manufacturer,
    required this.model,
    required this.year,
    required this.generation,
    required this.nickname,
    required this.imageAsset,
    required this.status,
    this.specs = const {},
  });

  String get displayName => '$year $manufacturer $model';
  String get displayFullName => '$year $manufacturer $model ($generation)';
  String get chipLabel => '🏎️ $displayFullName';
}
