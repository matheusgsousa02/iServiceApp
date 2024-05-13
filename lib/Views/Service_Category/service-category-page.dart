import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Views/Special_Day/register-specialday.dart';

class ServiceCategoryPage extends StatefulWidget {
  final UserInfo userInfo;

  const ServiceCategoryPage({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<ServiceCategoryPage> createState() => _ServiceCategoryPageState();
}

class _ServiceCategoryPageState extends State<ServiceCategoryPage> {
  List<Map<String, String>> specialDaysList = [];

  @override
  void initState() {
    super.initState();
    _loadSpecialDays();
  }

  void _loadSpecialDays() {
    // Dados falsos para simular
    specialDaysList = [
      {
        'category': 'Corte de Cabelo',
      },
      {
        'category': 'Barba',
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
              "Categorias de Serviço",
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
                    "Adicionar uma categoria",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  specialDay['category']!,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    // Ação para Remover
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                          100, 216, 218, 221), // Cor de fundo do botão
                      shape: BoxShape.circle, // Forma circular
                    ),
                    child: IconButton(
                      icon: Icon(Icons.delete), // Ícone de lixeira
                      color: Colors.black, // Cor do ícone
                      onPressed: () {
                        // Ação ao clicar no botão
                        print('Botão lixeira pressionado');
                      },
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
