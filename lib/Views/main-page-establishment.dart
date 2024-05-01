import 'package:flutter/material.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Views/Establishment_MyEstablishment/catalog.dart';
import 'package:iservice_application/Views/Establishment_MyEstablishment/my-establishment.dart';
import 'package:iservice_application/Views/Establishment_Profile/establishment-profile.dart';
import 'package:iservice_application/Views/Establishment_Services/schedules.dart';
import 'package:iservice_application/Views/Home_Page/home-page-establishment.dart';

class MainPageEstablishment extends StatefulWidget {
  final UserInfo userInfo;

  const MainPageEstablishment({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<MainPageEstablishment> createState() => _MainPageEstablishmentState();
}

class _MainPageEstablishmentState extends State<MainPageEstablishment> {
  int _selectedIndex = 0;

  late List<Widget> _pages = <Widget>[
    HomePageEstablishment(userInfo: widget.userInfo),
    Schedules(),
    Catalog(userInfo: widget.userInfo),
    MyEstablishment(userInfo: widget.userInfo),
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
              color: Colors.black26,
              width: 0.3,
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
              icon: Icon(Icons.view_list),
              label: 'Catálogo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Meu Estabelecimento',
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
