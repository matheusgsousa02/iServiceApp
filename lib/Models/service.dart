import 'dart:typed_data';
import 'dart:convert';

class Service {
  int serviceId;
  int establishmentProfileId;
  int serviceCategoryId;
  String name;
  String description;
  double price;
  int estimatedDuration;
  String? photo;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  Service({
    required this.serviceId,
    required this.establishmentProfileId,
    required this.serviceCategoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedDuration,
    this.photo,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json['serviceId'] as int,
        establishmentProfileId: json['establishmentProfileId'] as int,
        serviceCategoryId: json['serviceCategoryId'] as int,
        name: json['name'] as String,
        description: json['description'] as String,
        price: (json['price'] as num).toDouble(),
        estimatedDuration: json['estimatedDuration'] as int,
        photo: json['photo'] == null ? null : json['photo'] as String,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'establishmentProfileId': establishmentProfileId,
        'serviceCategoryId': serviceCategoryId,
        'name': name,
        'description': description,
        'price': price,
        'estimatedDuration': estimatedDuration,
        'photo': photo,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
