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

  Future<List<Service>> getByEstablishmentProfileId(
      int establishmentProfileId) async {
    var url = Uri.parse(
        'http://10.0.2.2:5120/Service/GetByEstablishmentProfileId/$establishmentProfileId');
    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
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

    var uri = Uri.parse('http://10.0.2.2:5120/Service');
    var multipartRequest = http.MultipartRequest('POST', uri);

    multipartRequest.fields['EstablishmentProfileId'] =
        request.establishmentProfileId.toString();
    multipartRequest.fields['ServiceCategoryId'] =
        request.serviceCategoryId.toString();
    multipartRequest.fields['Name'] = request.name;
    multipartRequest.fields['Description'] = request.description;
    multipartRequest.fields['Price'] = request.price.toString();
    multipartRequest.fields['EstimatedDuration'] =
        request.estimatedDuration.toString();

    if (request.imagePath != null) {
      multipartRequest.files
          .add(await http.MultipartFile.fromPath('File', request.imagePath!));
    }

    http.StreamedResponse streamedResponse = await multipartRequest.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      print('Response Data: $jsonResponse');
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

  Future<List<String>> getAvailableTimes(int serviceId, DateTime date) async {
    var formattedDate = date.toIso8601String();
    var url = Uri.parse(
        'http://10.0.2.2:5120/Service/GetAvailableTimes/$serviceId/$formattedDate');

    var response =
        await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body) as List;
      print(jsonResponse);
      // Assumindo que a resposta é uma lista de strings diretamente
      return jsonResponse.map((time) => time.toString()).toList();
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
