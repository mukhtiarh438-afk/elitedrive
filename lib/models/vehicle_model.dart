class VehicleModel {
  final String id;
  final String model;
  final String plateNumber;
  final String color;
  final String type; // e.g., 'Economy', 'Luxury'

  VehicleModel({
    required this.id,
    required this.model,
    required this.plateNumber,
    required this.color,
    required this.type,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? '',
      model: json['model'] ?? '',
      plateNumber: json['plateNumber'] ?? '',
      color: json['color'] ?? '',
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model': model,
      'plateNumber': plateNumber,
      'color': color,
      'type': type,
    };
  }
}
