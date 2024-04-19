import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Models/Auth/Login.dart';
import '../../Models/User/UserInfo.dart';

class LoginService {
  Future<UserInfo> login(String email, String password) async {
    Login login = Login(email: email, password: password);

    var url = Uri.parse('http://10.0.2.2:5120/Auth/login');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(login.toJson()),
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
