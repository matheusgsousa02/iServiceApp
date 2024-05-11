import 'package:flutter/material.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Views/Schedules/canceled-page.dart';
import 'package:iservice_application/Views/Schedules/finished-page.dart';
import 'package:iservice_application/Views/Schedules/schedule-page.dart';
import '../main-page-establishment.dart';

class Schedules extends StatefulWidget {
  final UserInfo userInfo;

  const Schedules({required this.userInfo, Key? key}) : super(key: key);

  @override
  State<Schedules> createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {
  int buttonIndexMenu = 0;

  late List<Widget> _scheduleWidgets = [
    SchedulePage(userInfo: widget.userInfo),
    FinishedPage(userInfo: widget.userInfo),
    CanceledPage(userInfo: widget.userInfo),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Agendamentos",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Color.fromARGB(100, 216, 218, 221),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _buildButton(context, "Agendado", 0),
                const SizedBox(width: 10),
                _buildButton(context, "Finalizado", 1),
                const SizedBox(width: 10),
                _buildButton(context, "Cancelado", 2),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            // Envolve o widget selecionado com um Expanded
            child: _scheduleWidgets[buttonIndexMenu],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, int index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            buttonIndexMenu = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
          decoration: BoxDecoration(
            color: buttonIndexMenu == index
                ? Color(0xFF2864ff)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: buttonIndexMenu == index ? Colors.white : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}
