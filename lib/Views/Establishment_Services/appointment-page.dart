import 'package:flutter/material.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dots_indicator/dots_indicator.dart';

class AppointmentPage extends StatefulWidget {
  final UserInfo userInfo;

  AppointmentPage({required this.userInfo, Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _selectedDay = DateTime.now();
  List<String> _availableTimes = [];
  String? _selectedTime;
  final PageController _pageController = PageController();
  double _currentIndex = 0;
  bool filledFields = false;

  @override
  void initState() {
    super.initState();
    _fetchAvailableTimes();
  }

  void _fetchAvailableTimes() {
    List<String> fictitiousTimes = [
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00',
      '19:00'
    ];

    setState(() {
      _availableTimes = fictitiousTimes;
    });
  }

  @override
  Widget build(BuildContext context) {
    int gridCount = (_availableTimes.length / 8).ceil();
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selecione o dia da semana e o horário do atendimento",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _selectedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _fetchAvailableTimes();
                    });
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle: TextStyle(fontSize: 16),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.black),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.black),
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.black),
                    weekendTextStyle: TextStyle(color: Colors.black),
                    outsideTextStyle: TextStyle(color: Colors.grey),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xFF2864ff),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white),
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xFF2864ff), width: 1),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(color: Color(0xFF2864ff)),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.black),
                    weekendStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 120,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index.toDouble();
                    });
                  },
                  itemCount: gridCount,
                  itemBuilder: (context, index) {
                    int start = index * 8;
                    int end = (start + 8 > _availableTimes.length)
                        ? _availableTimes.length
                        : start + 8;
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                      ),
                      itemCount: end - start,
                      itemBuilder: (context, i) {
                        String time = _availableTimes[start + i];
                        return ChoiceChip(
                          label: Text(time),
                          selected: _selectedTime == time,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedTime = time;
                            });
                          },
                          selectedColor: Color(0xFF2864ff),
                          labelStyle: TextStyle(
                            color: _selectedTime == time
                                ? Colors.white
                                : Colors.black,
                            fontWeight: _selectedTime == time
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          backgroundColor: Colors.white,
                        );
                      },
                    );
                  },
                ),
              ),
              DotsIndicator(
                dotsCount: gridCount,
                position: _currentIndex,
                decorator: DotsDecorator(
                  activeColor: Color(0xFF2864ff),
                ),
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  if (!filledFields) {}
                },
                color: filledFields ? const Color(0xFF2864ff) : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Finalizar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
