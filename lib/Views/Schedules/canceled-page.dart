import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iservice_application/Models/appointment.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/appointment_services.dart';
import 'package:iservice_application/Views/Feedback/review-page.dart';

class CanceledPage extends StatefulWidget {
  final UserInfo userInfo;

  const CanceledPage({required this.userInfo, Key? key}) : super(key: key);

  @override
  State<CanceledPage> createState() => _CanceledPageState();
}

class _CanceledPageState extends State<CanceledPage> {
  List<Map<String, dynamic>> appointmentsList = [];

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    AppointmentServices()
        .get(widget.userInfo.user.userId)
        .then((List<Appointment> appointments) {
      setState(() {
        appointmentsList = appointments.map((appointment) {
          final String formattedDate =
              DateFormat('dd/MM/yyyy').format(appointment.start);
          final String formattedTime =
              DateFormat('HH:mm').format(appointment.start);
          final String duration = appointment.end
              .difference(appointment.start)
              .inMinutes
              .toString();

          return {
            'clientName': 'generico',
            'service': 'generico',
            'duration': '$duration minutos',
            'date': formattedDate,
            'time': formattedTime
          };
        }).toList();
      });
    }).catchError((e) {
      print('Erro ao carregar dados do estabelecimento: $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: appointmentsList.length,
                  itemBuilder: (context, index) {
                    return SchedulesCard(
                        appointmentsList: appointmentsList[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchedulesCard extends StatelessWidget {
  final Map<String, dynamic> appointmentsList;

  const SchedulesCard({Key? key, required this.appointmentsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: Color.fromARGB(244, 239, 237, 237),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                spreadRadius: 2,
              ),
            ],
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ListTile(
                  title: Text(appointmentsList['clientName'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Serviço: ${appointmentsList['service']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("Duração: ${appointmentsList['duration']}",
                          style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    thickness: 1,
                    height: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_month, color: Colors.black54),
                        const SizedBox(width: 5),
                        Text(appointmentsList["date"]),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time_filled,
                            color: Colors.black54),
                        const SizedBox(width: 5),
                        Text(appointmentsList["time"]),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 340,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(99, 176, 178, 180),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Cancelar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
