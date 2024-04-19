import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/User/UserInfo.dart';
import '../../Models/Auth/PreRegister.dart';

class PreRegisterService {
  Future<UserInfo> preRegister(
      int userRoleID, String email, String name, String password) async {
    PreRegister preRegister = PreRegister(
        userRoleID: userRoleID, email: email, name: name, password: password);
    print('Request Data: ${jsonEncode(preRegister.toJson())}');

    var url = Uri.parse('http://10.0.2.2:5120/Auth/preregister');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(preRegister.toJson()),
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
