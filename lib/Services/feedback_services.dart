import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/Request/feedback_model.dart';
import 'package:iservice_application/Models/feedback.dart';
import 'package:iservice_application/Models/service.dart';
import 'package:iservice_application/Models/Request/service_model.dart';
import 'package:iservice_application/Models/service_category.dart';

class ServiceServices {
  Future<List<ServiceCategory>> getFeedbackByEstablishmentProfileId(
      int establishmentProfileId) async {
    var url = Uri.parse(
        'http://10.0.2.2:5120/Feedback/getFeedbackByEstablishmentProfileId/$establishmentProfileId');
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

  Future<Feedback> addFeedback(FeedbackModel request) async {
    print('Request Data: ${jsonEncode(request)}');

    var url = Uri.parse('http://10.0.2.2:5120/Feedback');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );
    print('');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Feedback.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Feedback> editFeedback(Feedback request) async {
    print('Request Data: ${jsonEncode(request.toJson())}');

    var url = Uri.parse('http://10.0.2.2:5120/Feedback/${request.feedbackId}');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Feedback.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
