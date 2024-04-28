import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  List<String> _availableTimes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um Dia'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                // _fetchAvailableTimes();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _availableTimes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_availableTimes[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /*void _fetchAvailableTimes() async {
       final response = await http.get(Uri.parse('https://api.example.com/times/$_selectedDay'));
       if (response.statusCode == 200) {
         setState(() {
           _availableTimes = List<String>.from(json.decode(response.body));
         });
       } else {
         // Tratar erro
         print('Falha ao carregar horários: ${response.statusCode}');
       }
     }*/
}
