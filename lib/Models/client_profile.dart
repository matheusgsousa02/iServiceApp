import 'dart:typed_data'; // Para usar Uint8List

class ClientProfile {
  int clientProfileId;
  int userId;
  String cpf;
  DateTime dateOfBirth;
  String phone;
  int addressId;
  Uint8List? photo;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  ClientProfile({
    required this.clientProfileId,
    required this.userId,
    required this.cpf,
    required this.dateOfBirth,
    required this.phone,
    required this.addressId,
    this.photo,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory ClientProfile.fromJson(Map<String, dynamic> json) => ClientProfile(
        clientProfileId: json['clientProfileId'] as int,
        userId: json['userId'] as int,
        cpf: json['cpf'] as String,
        dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
        phone: json['phone'] as String,
        addressId: json['addressId'] as int,
        photo: json['photo'] == null
            ? null
            : Uint8List.fromList(List<int>.from(json['photo'])),
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'clientProfileId': clientProfileId,
        'userId': userId,
        'cpf': cpf,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'phone': phone,
        'addressId': addressId,
        'photo': photo?.toList(),
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
