import '../User/EstablishmentProfile.dart';
import '../User/ClientProfile.dart';
import '../User/Address.dart';

class Register {
  int userId;
  EstablishmentProfile? establishment;
  ClientProfile? client;
  Address address;

  Register({
    required this.userId,
    this.establishment,
    this.client,
    required this.address,
  });

  Register.client({
    required this.userId,
    this.client,
    required this.address,
  });

  Register.establishment({
    required this.userId,
    this.establishment,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'establishment': establishment?.toJson(),
      'client': client?.toJson(),
      'address': address.toJson(),
    };
  }

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      userId: json['userId'],
      establishment: json['establishment'] != null
          ? EstablishmentProfile.fromJson(json['establishment'])
          : null,
      client: json['client'] != null
          ? ClientProfile.fromJson(json['client'])
          : null,
      address: Address.fromJson(json['address']),
    );
  }
}
