import 'package:http/http.dart' as http;

class ServiceModel {
  int establishmentProfileId;
  int serviceCategoryId;
  String name;
  String description;
  double price;
  int estimatedDuration;
  String? imagePath;
  List<int>? photo;

  ServiceModel({
    required this.establishmentProfileId,
    required this.serviceCategoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedDuration,
    this.imagePath,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'EstablishmentProfileId': establishmentProfileId,
      'ServiceCategoryId': serviceCategoryId,
      'Name': name,
      'Description': description,
      'Price': price,
      'EstimatedDuration': estimatedDuration,
      'ImagePath': imagePath,
    };
  }

  static ServiceModel fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      establishmentProfileId: json['EstablishmentProfileId'],
      serviceCategoryId: json['ServiceCategoryId'],
      name: json['Name'],
      description: json['Description'],
      price: json['Price']?.toDouble() ?? 0.0,
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      imagePath: json['ImagePath'],
    );
  }
}
