import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Views/Special_Day/register-specialday.dart';

class SpecialDayPage extends StatefulWidget {
  final UserInfo userInfo;

  const SpecialDayPage({required this.userInfo, Key? key}) : super(key: key);

  @override
  State<SpecialDayPage> createState() => _SpecialDayPageState();
}

class _SpecialDayPageState extends State<SpecialDayPage> {
  List<Map<String, String>> specialDaysList = [];

  @override
  void initState() {
    super.initState();
    _loadSpecialDays();
  }

  void _loadSpecialDays() {
    // Dados falsos para simular dias especiais
    specialDaysList = [
      {
        'date': '27/05/2024',
        'operatingStart': '08:00',
        'operatingEnd': '18:00',
        'breakStart': '12:00',
        'breakEnd': '13:00',
      },
      {
        'date': '28/05/2024',
        'operatingStart': '09:00',
        'operatingEnd': '17:00',
        'breakStart': '12:30',
        'breakEnd': '13:30',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Horário em Dia Especial",
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
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterSpecialDay(userInfo: widget.userInfo)),
                );
              },
              child: Container(
                width: 390,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF2864ff),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Adicionar um horário especial",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: specialDaysList.length,
              itemBuilder: (context, index) {
                return SchedulesCard(specialDay: specialDaysList[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SchedulesCard extends StatelessWidget {
  final Map<String, String> specialDay;

  const SchedulesCard({Key? key, required this.specialDay}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              specialDay['date']!,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2864ff)),
            ),
            SizedBox(height: 10),
            Text('Horário de funcionamento',
                style: TextStyle(fontSize: 18, color: Colors.black54)),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(specialDay['operatingStart']!,
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                Text(
                  " - ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(specialDay['operatingEnd']!,
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            Text('Horário de intervalo',
                style: TextStyle(fontSize: 18, color: Colors.black54)),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(specialDay['breakStart']!,
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                Text(
                  " - ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(specialDay['breakEnd']!,
                    style: TextStyle(fontSize: 16, color: Colors.black)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Ação para Editar
                  },
                  child: Container(
                    width: 155,
                    padding: EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: Color(0xFF2864ff),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Editar",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Ação para Remover
                  },
                  child: Container(
                    width: 155,
                    padding: EdgeInsets.symmetric(vertical: 7),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(100, 216, 218, 221),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Remover",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
