import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iservice_application/Models/Request/appointment_model.dart';
import 'package:iservice_application/Models/appointment.dart';
import 'package:iservice_application/Models/service.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/appointment_services.dart';
import 'package:iservice_application/Services/service_services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dots_indicator/dots_indicator.dart';

class AppointmentPage extends StatefulWidget {
  final UserInfo userInfo;
  final Service service;

  AppointmentPage({required this.userInfo, required this.service, Key? key})
      : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _selectedDay = DateTime.now();
  Future<List<String>> _availableTimes = Future.value([]);
  String? _selectedTime;
  final PageController _pageController = PageController();
  double _currentIndex = 0;
  bool filledFields = false;
  String mensagemErro = '';

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    fetchAvailableTimes();
  }

  void fetchAvailableTimes() {
    print(widget.service);

    ServiceServices()
        .getAvailableTimes(widget.service.serviceId, _selectedDay)
        .then((List<String> availableTimes) {
      setState(() {
        _availableTimes = Future.value(availableTimes);
      });
    }).catchError((e) {
      print(e.toString());
      setState(() {
        _availableTimes = Future.value([]);
      });
    });
  }

  void atualizarMensagemErro(String mensagem) {
    setState(() {
      mensagemErro = mensagem;
    });
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = _selectedTime != null && _selectedTime!.isNotEmpty;
      if (filledFields) {
        atualizarMensagemErro('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
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

                      fetchAvailableTimes();
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
              FutureBuilder<List<String>>(
                future: _availableTimes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Erro: ${snapshot.error}");
                  } else if (snapshot.data!.isEmpty) {
                    return Text("Não há horários disponíveis",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red));
                  } else {
                    var times = snapshot.data ?? [];
                    int gridCount = (times.length / 8).ceil();
                    return gridCount > 0
                        ? Column(
                            children: [
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
                                    int end = (start + 8 > times.length)
                                        ? times.length
                                        : start + 8;
                                    return GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 2,
                                      ),
                                      itemCount: end - start,
                                      itemBuilder: (context, i) {
                                        String time = times[start + i];
                                        return ChoiceChip(
                                          label: Text(time),
                                          selected: _selectedTime == time,
                                          onSelected: (bool selected) {
                                            setState(() {
                                              _selectedTime = time;
                                              filledFields =
                                                  _selectedTime != null &&
                                                      _selectedTime!.isNotEmpty;
                                              if (filledFields) {
                                                atualizarMensagemErro('');
                                              } else {
                                                atualizarMensagemErro(
                                                    'Por favor, selecione um horário antes de finalizar.');
                                              }
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
                            ],
                          )
                        : Container();
                  }
                },
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  if (_selectedTime == null) {
                    atualizarMensagemErro(
                        'Por favor, selecione um horário antes de finalizar.');
                    return;
                  }

                  try {
                    DateFormat timeFormat = DateFormat("HH:mm");
                    DateTime time = timeFormat.parse(_selectedTime!);

                    DateTime startDateTime = DateTime(
                      _selectedDay.year,
                      _selectedDay.month,
                      _selectedDay.day,
                      time.hour,
                      time.minute,
                    );
                    DateTime endDateTime = startDateTime.add(
                        Duration(minutes: widget.service.estimatedDuration));

                    AppointmentModel request = AppointmentModel(
                        serviceId: widget.service.serviceId,
                        clientProfileId:
                            widget.userInfo.clientProfile!.clientProfileId,
                        establishmentProfileId: widget.userInfo
                            .establishmentProfile!.establishmentProfileId,
                        appointmentStatusId: 1,
                        start: startDateTime,
                        end: endDateTime);

                    await AppointmentServices()
                        .addAppointment(request)
                        .then((Appointment appointment) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Dados cadastrados com sucesso',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }).catchError((e) {
                      print('Erro ao registrar servidor: $e');
                      atualizarMensagemErro('Erro ao registrar servidor: $e');
                    });
                  } catch (error) {
                    print("Erro capturado durante a execução: $error");
                    atualizarMensagemErro('Erro ao registrar servidor: $error');
                  }
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
