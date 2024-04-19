import 'package:flutter/material.dart';
import 'package:iservice_application/Services/Utils/barChart.dart';
import '../../Models/User/UserInfo.dart';

class HomePageEstablishment extends StatefulWidget {
  final UserInfo? userInfo;

  const HomePageEstablishment({this.userInfo, Key? key}) : super(key: key);

  @override
  State<HomePageEstablishment> createState() => _HomePageEstablishmentState();
}

class _HomePageEstablishmentState extends State<HomePageEstablishment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello, name",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/foto_perfil.png"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 175,
                  height: 175,
                  child: InkWell(
                    onTap: () {
                      // Adicione a lógica desejada quando o contêiner for tocado
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2864ff),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.article_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "9",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Agendamentos",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 175,
                  height: 175,
                  child: InkWell(
                    onTap: () {
                      // Adicione a lógica desejada quando o contêiner for tocado
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2864ff),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.add_chart_rounded,
                            color: Colors.white,
                            size: 35,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "5",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Produtos",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            BarChartSample7()
          ],
        ),
      ),
    );
  }
}
