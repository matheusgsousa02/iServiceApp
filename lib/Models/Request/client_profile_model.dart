import 'dart:typed_data'; // Para usar Uint8List

class ClientProfileModel {
  int userId;
  int addressId;
  String cpf;
  DateTime dateOfBirth;
  String phone;
  Uint8List? photo;

  ClientProfileModel({
    required this.userId,
    required this.addressId,
    required this.cpf,
    required this.dateOfBirth,
    required this.phone,
    this.photo,
  });

  factory ClientProfileModel.fromJson(Map<String, dynamic> json) =>
      ClientProfileModel(
        userId: json['userId'] as int,
        addressId: json['addressId'] as int,
        cpf: json['cpf'] as String,
        dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
        phone: json['phone'] as String,
        photo: json['photo'] == null
            ? null
            : Uint8List.fromList(List<int>.from(json['photo'])),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'addressId': addressId,
        'cpf': cpf,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'phone': phone,
        'photo': photo?.toList(),
      };
}
