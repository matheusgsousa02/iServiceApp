import 'dart:typed_data'; // Para usar Uint8List

class ServiceModel {
  int establishmentProfileId;
  int serviceCategoryId;
  String name;
  String description;
  double price;
  double estimatedDuration;
  Uint8List? photo;

  ServiceModel({
    required this.establishmentProfileId,
    required this.serviceCategoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedDuration,
    this.photo,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        establishmentProfileId: json['establishmentProfileId'] as int,
        serviceCategoryId: json['serviceCategoryId'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        estimatedDuration: (json['estimatedDuration'] as num).toDouble(),
        photo: json['photo'] == null
            ? null
            : Uint8List.fromList(List<int>.from(json['photo'])),
      );

  Map<String, dynamic> toJson() => {
        'establishmentProfileId': establishmentProfileId,
        'serviceCategoryId': serviceCategoryId,
        'name': name,
        'description': description,
        'price': price,
        'estimatedDuration': estimatedDuration,
        'photo': photo?.toList(),
      };
}
