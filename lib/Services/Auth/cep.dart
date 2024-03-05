import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EndCep {
  static Future<void> fetchData(
    String cep,
    TextEditingController stateController,
    TextEditingController cityController,
    TextEditingController hoodController,
    TextEditingController streetController,
  ) async {
    final Uri url = Uri.parse('http://10.0.2.2:5120/v1/search?cep=$cep');

    http.Response response;

    try {
      response = await http.get(url);
    } catch (error) {
      print('Erro na requisição: $error');
      return;
    }

    if (response.statusCode == 200) {
      try {
        Map<String, dynamic> responseData = json.decode(response.body);

        print('Resposta da API: $responseData');

        if (responseData.containsKey('address')) {
          Map<String, dynamic> addressData = responseData['address'];

          if (addressData.containsKey('uf') &&
              addressData.containsKey('localidade') &&
              addressData.containsKey('bairro') &&
              addressData.containsKey('logradouro')) {
            stateController.text = addressData['uf'] ?? '';
            cityController.text = addressData['localidade'] ?? '';
            hoodController.text = addressData['bairro'] ?? '';
            streetController.text = addressData['logradouro'] ?? '';
          } else {
            print('Campos necessários ausentes na resposta da API.');
          }
        } else {
          print('Chave "address" ausente na resposta da API.');
        }
      } catch (error) {
        print('Erro ao decodificar resposta JSON: $error');
      }
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }
  }
}
