import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/User/UserInfo.dart';
import '../../Models/Auth/Register.dart';
import '../../Models/User/EstablishmentProfile.dart';
import '../../Models/User/ClientProfile.dart';
import '../../Models/User/Address.dart';

class RegisterService {
  Future<UserInfo> register(UserInfo userInfo) async {
    Register register = Register(
      userId: userInfo.user!.userID,
      address: Address(
        addressID: 0,
        street: userInfo.address!.street,
        number: userInfo.address!.number,
        additionalInfo: userInfo.address!.additionalInfo,
        city: userInfo.address!.city,
        state: userInfo.address!.state,
        country: userInfo.address!.country,
        postalCode: userInfo.address!.postalCode,
      ),
    );
    if (userInfo.userRole!.userRoleID == 1) {
      register.establishment = EstablishmentProfile(
        establishmentProfileID: 0,
        userID: userInfo.user!.userID,
        cnpj: userInfo.establishmentProfile!.cnpj,
        commercialName: userInfo.establishmentProfile!.commercialName,
        addressID: 0,
        description: userInfo.establishmentProfile!.description,
        commercialPhone: userInfo.establishmentProfile!.commercialPhone,
        commercialEmail: userInfo.establishmentProfile!.commercialEmail,
        excluded: true,
      );
    }
    ;
    if (userInfo.userRole!.userRoleID == 2) {
      register.client = ClientProfile(
        clientProfileID: 0,
        userID: userInfo.user!.userID,
        cpf: userInfo.clientProfile!.cpf,
        dateOfBirth: userInfo.clientProfile!.dateOfBirth,
        phone: userInfo.clientProfile!.phone,
        addressID: 0,
        excluded: true,
      );
    }
    ;

    print('Request Data: ${jsonEncode(register.toJson())}');

    var url = Uri.parse('http://10.0.2.2:5120/v1/register');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(register.toJson()),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return UserInfo.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
