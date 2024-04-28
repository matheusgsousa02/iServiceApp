import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/Request/schedule_model.dart';
import 'package:iservice_application/Models/schedule.dart';

class ScheduleServices {
  Future<Schedule> getById(int id) async {
    print('Request Data: ${jsonEncode(id)}');

    var url = Uri.parse('http://10.0.2.2:5120/Schedule/GetById/$id');
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Schedule.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Schedule> getByEstablishmentProfileId(
      int establishmentProfileId) async {
    print('Request Data: ${jsonEncode(establishmentProfileId)}');

    var url = Uri.parse(
        'http://10.0.2.2:5120/Schedule/GetByEstablishmentProfileId/$establishmentProfileId');
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Schedule.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Schedule> addSchedule(ScheduleModel request) async {
    print('Request Data: ${jsonEncode(request)}');

    var url = Uri.parse('http://10.0.2.2:5120/Schedule');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: request);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Schedule.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Schedule> editSchedule(Schedule request) async {
    print('Request Data: ${jsonEncode(request)}');

    var url = Uri.parse('http://10.0.2.2:5120/Schedule/${request.scheduleId}');
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: request);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Schedule.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
