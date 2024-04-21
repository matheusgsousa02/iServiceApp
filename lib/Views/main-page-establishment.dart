import 'package:flutter/material.dart';
import 'package:iservice_application/Views/Establishment_MyEstablishment/my-establishment.dart';
import 'package:iservice_application/Views/Establishment_Profile/establishment-profile.dart';
import 'package:iservice_application/Views/Establishment_Services/schedules.dart';
import 'package:iservice_application/Views/Home_Page/home-page-establishment.dart';
import '../../Models/User/UserInfo.dart';

class MainPageEstablishment extends StatefulWidget {
  final UserInfo? userInfo;

  const MainPageEstablishment({this.userInfo, Key? key}) : super(key: key);

  @override
  _MainPageEstablishmentState createState() => _MainPageEstablishmentState();
}

class _MainPageEstablishmentState extends State<MainPageEstablishment> {
  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    HomePageEstablishment(),
    Schedules(),
    MyEstablishment(),
    EstablishmentProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black26, // Cor da linha cinza claro
              width: 0.3, // Largura da linha
            ),
          ),
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Agendamentos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Meu Estabelecimento',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
