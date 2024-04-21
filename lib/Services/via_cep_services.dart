import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/via_cep.dart';

class ViaCepServices {
  Future<ViaCep> getAddress(String cep) async {
    print('Request Data: ${jsonEncode(cep)}');

    var url = Uri.parse('http://10.0.2.2:5120/ViaCep/Search/$cep');
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return ViaCep.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
