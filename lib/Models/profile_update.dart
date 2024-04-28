import 'package:iservice_application/Models/client_profile.dart';
import 'package:iservice_application/Models/establishment_profile.dart';

class ProfileUpdate {
  String name;
  ClientProfile? clientProfile;
  EstablishmentProfile? establishmentProfile;

  ProfileUpdate(
      {required this.name, this.clientProfile, this.establishmentProfile});

  Map<String, dynamic> toJson() => {
        'name': name,
        'clientProfile': clientProfile?.toJson(),
        'establishmentProfile': establishmentProfile?.toJson(),
      };

  factory ProfileUpdate.fromJson(Map<String, dynamic> json) => ProfileUpdate(
        name: json['name'],
        clientProfile: json['clientProfile'] != null
            ? ClientProfile.fromJson(json['clientProfile'])
            : null,
        establishmentProfile: json['establishmentProfile'] != null
            ? EstablishmentProfile.fromJson(json['establishmentProfile'])
            : null,
      );
}
