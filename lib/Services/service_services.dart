import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/service.dart';
import 'package:iservice_application/Models/Request/service_model.dart';
import 'package:iservice_application/Models/service_category.dart';

class ServiceServices {
  Future<List<ServiceCategory>> getServicesCategories() async {
    var url = Uri.parse('http://10.0.2.2:5120/ServiceCategory');
    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body) as List;
      print(jsonResponse);
      return jsonResponse
          .map((categoryJson) => ServiceCategory.fromJson(categoryJson))
          .toList();
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<List<Service>> getByServiceCategoryId(int serviceCategoryId) async {
    var url = Uri.parse(
        'http://10.0.2.2:5120/GetByServiceCategoryId/$serviceCategoryId');
    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body) as List;
      print(jsonResponse);
      return jsonResponse
          .map((categoryJson) => Service.fromJson(categoryJson))
          .toList();
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Service> addService(ServiceModel request) async {
    print('Request Data: ${jsonEncode(request.toJson())}');

    var url = Uri.parse('http://10.0.2.2:5120/Service');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Service.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Service> editService(Service request) async {
    print('Request Data: ${jsonEncode(request.toJson())}');

    var url = Uri.parse('http://10.0.2.2:5120/Service/${request.serviceId}');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Service.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
