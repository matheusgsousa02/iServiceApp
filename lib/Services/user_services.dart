import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/Address.dart';
import 'package:iservice_application/Models/ImageModel.dart';
import 'package:iservice_application/Models/establishment_category.dart';
import 'package:iservice_application/Models/profile_update.dart';
import 'package:iservice_application/Models/user_info.dart';

class UserServices {
  Future<UserInfo> getUserInfoByUserId(int userId) async {
    print('Request Data: ${jsonEncode(userId)}');

    var url = Uri.parse('http://10.0.2.2:5120/User/GetUserInfoById/$userId');
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
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

  Future<UserInfo> editProfile(ProfileUpdate request) async {
    print('Request Data: ${jsonEncode(request.toJson())}');

    var url = Uri.parse('http://10.0.2.2:5120/User/UpdateUserProfile');
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
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

  Future<bool> uploadPhoto(ImageModel request, int userRole) async {
    print('Request Data: ${jsonEncode(request.toJson())}');

    var url = Uri();

    if (userRole == 1) {
      url = Uri.parse('http://10.0.2.2:5120/EstablishmentProfile/UploadPhoto');
    } else if (userRole == 2) {
      url = Uri.parse('http://10.0.2.2:5120/ClientProfile/UploadPhoto');
    }

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return jsonResponse as bool; // Directly casting the response body to bool
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Address> editAddress(Address request) async {
    print('Request Data: ${jsonEncode(request.toJson())}');

    var url = Uri.parse('http://10.0.2.2:5120/Address/${request.addressId}');
    var response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Address.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<List<EstablishmentCategory>> getEstablishmentCategories() async {
    var url = Uri.parse('http://10.0.2.2:5120/EstablishmentCategory');
    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body) as List;
      print(jsonResponse);
      return jsonResponse
          .map((categoryJson) => EstablishmentCategory.fromJson(categoryJson))
          .toList();
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
