import '../Request/establishment_profile_model.dart';
import '../Request/client_profile_model.dart';
import '../Request/address_model.dart';

class Register {
  int userId;
  EstablishmentProfileModel? establishmentProfile;
  ClientProfileModel? clientProfile;
  AddressModel address;

  Register({
    required this.userId,
    this.establishmentProfile,
    this.clientProfile,
    required this.address,
  });

  Register.clientProfile({
    required this.userId,
    required this.clientProfile,
    required this.address,
  }) : establishmentProfile = null;

  Register.establishmentProfile({
    required this.userId,
    required this.establishmentProfile,
    required this.address,
  }) : clientProfile = null;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'establishmentProfile': establishmentProfile?.toJson(),
      'clientProfile': clientProfile?.toJson(),
      'address': address.toJson(),
    };
  }

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      userId: json['userId'] as int,
      establishmentProfile: json['establishmentProfile'] != null
          ? EstablishmentProfileModel.fromJson(
              json['establishment'] as Map<String, dynamic>)
          : null,
      clientProfile: json['clientProfile'] != null
          ? ClientProfileModel.fromJson(
              json['clientProfile'] as Map<String, dynamic>)
          : null,
      address: AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    );
  }
}
