import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iservice_application/Models/Request/appointment_model.dart';
import 'package:iservice_application/Models/appointment.dart';

class AppointmentServices {
  Future<Appointment> getById(int id) async {
    print('Request Data: ${jsonEncode(id)}');

    var url = Uri.parse('http://10.0.2.2:5120/Appointment/GetById/$id');
    var response = await http.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Appointment.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Appointment> addAppointment(AppointmentModel request) async {
    print('Request Data: ${jsonEncode(request)}');

    var url = Uri.parse('http://10.0.2.2:5120/Appointment');
    var response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: request);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Appointment.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }

  Future<Appointment> editAppointment(Appointment request) async {
    print('Request Data: ${jsonEncode(request)}');

    var url =
        Uri.parse('http://10.0.2.2:5120/Appointment/${request.appointmentId}');
    var response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: request);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      return Appointment.fromJson(jsonResponse);
    } else {
      var jsonResponse = jsonDecode(response.body);
      var errorMessage = jsonResponse['message'] ?? 'Erro desconhecido';
      throw Exception(errorMessage);
    }
  }
}
