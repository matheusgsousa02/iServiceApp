import 'dart:typed_data'; // Para usar o Uint8List

class EstablishmentProfileModel {
  int userId;
  String cnpj;
  String commercialName;
  int establishmentCategoryId;
  int? addressId;
  String description;
  String commercialPhone;
  String commercialEmail;
  Uint8List? photo;

  EstablishmentProfileModel({
    required this.userId,
    required this.cnpj,
    required this.commercialName,
    required this.establishmentCategoryId,
    this.addressId,
    required this.description,
    required this.commercialPhone,
    required this.commercialEmail,
    this.photo,
  });

  factory EstablishmentProfileModel.fromJson(Map<String, dynamic> json) =>
      EstablishmentProfileModel(
        userId: json['userId'] as int,
        cnpj: json['cnpj'] as String,
        commercialName: json['commercialName'] as String,
        establishmentCategoryId: json['establishmentCategoryId'] as int,
        addressId: json['addressId'] as int?, // Pode ser nulo
        description: json['description'] as String,
        commercialPhone: json['commercialPhone'] as String,
        commercialEmail: json['commercialEmail'] as String,
        photo: json['photo'] == null
            ? null
            : Uint8List.fromList(List<int>.from(json['photo'])),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'cnpj': cnpj,
        'commercialName': commercialName,
        'establishmentCategoryId': establishmentCategoryId,
        'addressId': addressId,
        'description': description,
        'commercialPhone': commercialPhone,
        'commercialEmail': commercialEmail,
        'photo': photo?.toList(),
      };
}
