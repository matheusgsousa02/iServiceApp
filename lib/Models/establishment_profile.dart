import 'dart:typed_data'; // Para usar o Uint8List

class EstablishmentProfile {
  int establishmentProfileId;
  int userId;
  String cnpj;
  String commercialName;
  int establishmentCategoryId;
  int addressId;
  String description;
  String commercialPhone;
  String commercialEmail;
  Uint8List? photo;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  EstablishmentProfile({
    required this.establishmentProfileId,
    required this.userId,
    required this.cnpj,
    required this.commercialName,
    required this.establishmentCategoryId,
    required this.addressId,
    required this.description,
    required this.commercialPhone,
    required this.commercialEmail,
    this.photo,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory EstablishmentProfile.fromJson(Map<String, dynamic> json) =>
      EstablishmentProfile(
        establishmentProfileId: json['establishmentProfileId'] as int,
        userId: json['userId'] as int,
        cnpj: json['cnpj'] as String,
        commercialName: json['commercialName'] as String,
        establishmentCategoryId: json['establishmentCategoryId'] as int,
        addressId: json['addressId'] as int,
        description: json['description'] as String,
        commercialPhone: json['commercialPhone'] as String,
        commercialEmail: json['commercialEmail'] as String,
        photo: json['photo'] == null
            ? null
            : Uint8List.fromList(List<int>.from(json['photo'])),
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'establishmentProfileId': establishmentProfileId,
        'userId': userId,
        'cnpj': cnpj,
        'commercialName': commercialName,
        'establishmentCategoryId': establishmentCategoryId,
        'addressId': addressId,
        'description': description,
        'commercialPhone': commercialPhone,
        'commercialEmail': commercialEmail,
        'photo': photo?.toList(),
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
