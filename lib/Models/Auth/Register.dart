import '../Request/establishment_profile_model.dart';
import '../Request/client_profile_model.dart';
import '../Request/address_model.dart';

class Register {
  int userId;
  EstablishmentProfileModel? establishment;
  ClientProfileModel? client;
  AddressModel address;

  Register({
    required this.userId,
    this.establishment,
    this.client,
    required this.address,
  });

  Register.client({
    required this.userId,
    required this.client,
    required this.address,
  }) : establishment = null;

  Register.establishment({
    required this.userId,
    required this.establishment,
    required this.address,
  }) : client = null;

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
      userId: json['userId'] as int,
      establishment: json['establishment'] != null
          ? EstablishmentProfileModel.fromJson(
              json['establishment'] as Map<String, dynamic>)
          : null,
      client: json['client'] != null
          ? ClientProfileModel.fromJson(json['client'] as Map<String, dynamic>)
          : null,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );
  }
}
