import '../Models/User/Address.dart';
import '../Models/User/ClientProfile.dart';
import '../Models/User/EstablishmentProfile.dart';

class UserRegister {
  int? userID;
  EstablishmentProfile? establishment;
  ClientProfile? client;
  Address? address;

  UserRegister({this.userID, this.establishment, this.client, this.address});

  Map<String, dynamic> toJson() => {
        'userId': userID,
        'establishment': establishment?.toJson(),
        'client': client?.toJson(),
        'address': address?.toJson(),
      };
}
