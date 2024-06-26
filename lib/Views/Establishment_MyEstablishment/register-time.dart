import 'package:flutter/material.dart';
import 'package:iservice_application/Models/Request/schedule_model.dart';
import 'package:iservice_application/Models/schedule.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/Utils/textFieldUtils.dart';
import 'package:iservice_application/Services/schedule_services.dart';

class RegisterTime extends StatefulWidget {
  final UserInfo userInfo;
  final _DiasDaSemanaState? diasSelecionados;

  const RegisterTime({required this.userInfo, this.diasSelecionados, Key? key})
      : super(key: key);

  @override
  State<RegisterTime> createState() => _RegisterTimeState();
}

class _RegisterTimeState extends State<RegisterTime> {
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController timeBreakStartController = TextEditingController();
  TextEditingController timeBreakEndController = TextEditingController();
  TimeOfDay? _selectedTime = TimeOfDay.now();
  String mensagemErro = '';
  bool filledFields = false;
  _DiasDaSemanaState diasDaSemana = _DiasDaSemanaState();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    timeStartController.addListener(atualizarEstadoCampos);
    timeEndController.addListener(atualizarEstadoCampos);
    timeBreakStartController.addListener(atualizarEstadoCampos);
    timeBreakEndController.addListener(atualizarEstadoCampos);
  }

  void atualizarMensagemErro(String mensagem) {
    setState(() {
      mensagemErro = mensagem;
    });
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = timeStartController.text.isNotEmpty &&
          timeEndController.text.isNotEmpty;
      if (filledFields) {
        atualizarMensagemErro('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Horário de Funcionamento",
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Selecione os dias da semana",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DiasDaSemana(
                  onUpdateSelectedDays: (selectedDays) {
                    setState(() {
                      diasDaSemana._diasSelecionados = selectedDays;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Selecione o horário de expediente",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Utils.buildTimePickerFormField(
                      context: context,
                      controller: timeStartController,
                      prefixIcon: Icons.access_time,
                      hintText: 'Início',
                    ),
                    SizedBox(width: 10),
                    Utils.buildTimePickerFormField(
                      context: context,
                      controller: timeEndController,
                      prefixIcon: Icons.history_toggle_off,
                      hintText: 'Término',
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    "Selecione o horário de intervalo",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: <Widget>[
                    Utils.buildTimePickerFormField(
                      context: context,
                      controller: timeBreakStartController,
                      prefixIcon: Icons.access_time,
                      hintText: 'Início',
                    ),
                    SizedBox(width: 10),
                    Utils.buildTimePickerFormField(
                      context: context,
                      controller: timeBreakEndController,
                      prefixIcon: Icons.history_toggle_off,
                      hintText: 'Término',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  mensagemErro,
                  style: const TextStyle(color: Colors.red),
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    if (!filledFields) {
                      atualizarMensagemErro(
                          'Por favor, preencha todos os campos.');
                    } else {
                      try {
                        ScheduleModel request = ScheduleModel(
                          establishmentProfileId: widget.userInfo
                              .establishmentProfile!.establishmentProfileId,
                          days: diasDaSemana._getDiasSelecionados(),
                          start: timeStartController.text,
                          end: timeEndController.text,
                          breakStart: timeBreakStartController.text,
                          breakEnd: timeBreakEndController.text,
                        );
                        request.days = request.days.replaceAll(" ", "");
                        await ScheduleServices()
                            .addSchedule(request)
                            .then((Schedule schedule) {
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
                          atualizarMensagemErro(
                              'Erro ao registrar servidor: $e');
                        });
                      } catch (error) {
                        atualizarMensagemErro(
                            'Erro ao registrar servidor: $error');
                      }
                    }
                  },
                  color: filledFields ? const Color(0xFF2864ff) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Cadastrar",
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
      ),
    );
  }
}

class DiasDaSemana extends StatefulWidget {
  final Function(List<bool>) onUpdateSelectedDays;

  const DiasDaSemana({required this.onUpdateSelectedDays, Key? key})
      : super(key: key);

  @override
  _DiasDaSemanaState createState() => _DiasDaSemanaState();
}

class _DiasDaSemanaState extends State<DiasDaSemana> {
  List<bool> _diasSelecionados = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < 7; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                _diasSelecionados[i] = !_diasSelecionados[i];
              });
              widget.onUpdateSelectedDays(_diasSelecionados);
            },
            child: Container(
              padding: EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: _diasSelecionados[i] ? Color(0xFF2864ff) : Colors.white,
                border: Border.all(
                    color: _diasSelecionados[i]
                        ? Color(0xFF2864ff)
                        : Colors.black54),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                _nomeDiaSemana(i),
                style: TextStyle(
                    color: _diasSelecionados[i] ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
      ],
    );
  }

  String _nomeDiaSemana(int index) {
    switch (index) {
      case 0:
        return 'Seg';
      case 1:
        return 'Ter';
      case 2:
        return 'Qua';
      case 3:
        return 'Qui';
      case 4:
        return 'Sex';
      case 5:
        return 'Sáb';
      case 6:
        return 'Dom';
      default:
        return '';
    }
  }

  String _getDiasSelecionados() {
    List<int> diasSelecionados = [];
    for (int i = 0; i < _diasSelecionados.length; i++) {
      if (_diasSelecionados[i]) {
        diasSelecionados.add(i);
      }
    }
    return diasSelecionados.join(', ');
  }
}
