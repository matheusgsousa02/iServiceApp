import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iservice_application/Models/Request/schedule_model.dart';
import 'package:iservice_application/Models/schedule.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/Utils/textFieldUtils.dart';
import 'package:iservice_application/Services/schedule_services.dart';

class RegisterSpecialDay extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterSpecialDay({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<RegisterSpecialDay> createState() => _RegisterSpecialDayState();
}

class _RegisterSpecialDayState extends State<RegisterSpecialDay> {
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController timeBreakStartController = TextEditingController();
  TextEditingController timeBreakEndController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TimeOfDay? _selectedTime = TimeOfDay.now();
  DateTime? selectedDate = DateTime.now();
  String mensagemErro = '';
  bool filledFields = false;

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (dataEscolhida != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(dataEscolhida);
      });
    }
  }

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
    dateController.addListener(atualizarEstadoCampos);
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
          timeEndController.text.isNotEmpty &&
          dateController.text.isNotEmpty;
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
              "Horário em Dias Especiais",
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
                    "Selecione a data",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: dateController,
                  onTap: () => _selectedDate(context),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Selecione a data',
                    hintStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                    prefixIcon: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.blue, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Colors.blue,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.5),
                    ),
                  ),
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
                    /*
                    if (!filledFields) {
                      atualizarMensagemErro(
                          'Por favor, preencha todos os campos.');
                    } else {
                      try {
                        

                        ScheduleModel request = ScheduleModel(
                          establishmentProfileId: widget.userInfo
                              .establishmentProfile!.establishmentProfileId,
                          days: 
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
                    }*/
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
