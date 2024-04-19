import 'package:flutter/material.dart';
import 'package:iservice_application/Views/Client_Profile/client-profile.dart';
import 'package:iservice_application/Views/Client_Search/client-search.dart';
import 'package:iservice_application/Views/Establishment_Services/schedules.dart';
import 'package:iservice_application/Views/Home_Page/home-page-client.dart';

class MainPageClient extends StatefulWidget {
  @override
  _MainPageClientState createState() => _MainPageClientState();
}

class _MainPageClientState extends State<MainPageClient> {
  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    HomePageClient(),
    Schedules(),
    SearchPage(),
    ClientProfile(),
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
              icon: Icon(Icons.search),
              label: 'Busca',
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
