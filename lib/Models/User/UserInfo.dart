import 'User.dart';
import 'UserRole.dart';
import 'ClientProfile.dart';
import 'EstablishmentProfile.dart';
import 'Address.dart';

class UserInfo {
  User? user;
  UserRole? userRole;
  EstablishmentProfile? establishmentProfile;
  ClientProfile? clientProfile;
  Address? address;

  UserInfo({
    this.user,
    this.userRole,
    this.establishmentProfile,
    this.clientProfile,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'userRole': userRole?.toJson(),
      'establishmentProfile': establishmentProfile?.toJson(),
      'clientProfile': clientProfile?.toJson(),
      'address': address?.toJson(),
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      userRole:
          json['userRole'] != null ? UserRole.fromJson(json['userRole']) : null,
      establishmentProfile: json['establishmentProfile'] != null
          ? EstablishmentProfile.fromJson(json['establishmentProfile'])
          : null,
      clientProfile: json['clientProfile'] != null
          ? ClientProfile.fromJson(json['clientProfile'])
          : null,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }

  @override
  String toString() {
    return 'UserInfo{user: $user, userRole: $userRole, establishmentProfile: $establishmentProfile, clientProfile: $clientProfile, address: $address}';
    // Adicione outras propriedades, se houver
  }
}
