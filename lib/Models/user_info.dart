import 'user.dart';
import 'user_role.dart';
import 'client_profile.dart';
import 'establishment_profile.dart';
import 'address.dart';

class UserInfo {
  User user; // Assuming this should be non-nullable
  UserRole userRole; // Assuming this should be non-nullable
  EstablishmentProfile? establishmentProfile;
  ClientProfile? clientProfile;
  Address? address; // Assuming this should be non-nullable

  UserInfo({
    required this.user,
    required this.userRole,
    this.establishmentProfile,
    this.clientProfile,
    this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(), // Non-nullable, no need for `?`
      'userRole': userRole.toJson(), // Non-nullable, no need for `?`
      'establishmentProfile': establishmentProfile?.toJson(),
      'clientProfile': clientProfile?.toJson(),
      'address': address?.toJson(), // Non-nullable, no need for `?`
    };
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        user: User.fromJson(json['user'] as Map<String,
            dynamic>), // Non-nullable, assuming the JSON must contain this
        userRole: UserRole.fromJson(json['userRole'] as Map<String,
            dynamic>), // Non-nullable, assuming the JSON must contain this
        establishmentProfile: json['establishmentProfile'] != null
            ? EstablishmentProfile.fromJson(
                json['establishmentProfile'] as Map<String, dynamic>)
            : null,
        clientProfile: json['clientProfile'] != null
            ? ClientProfile.fromJson(
                json['clientProfile'] as Map<String, dynamic>)
            : null,
        address: json['address'] != null
            ? Address.fromJson(json['address'] as Map<String, dynamic>)
            : null);
  }
}
