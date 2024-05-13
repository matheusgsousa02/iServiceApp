import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iservice_application/Models/Request/schedule_model.dart';
import 'package:iservice_application/Models/schedule.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/Utils/textFieldUtils.dart';
import 'package:iservice_application/Services/schedule_services.dart';

class RegisterServiceCategory extends StatefulWidget {
  final UserInfo userInfo;

  const RegisterServiceCategory({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<RegisterServiceCategory> createState() =>
      _RegisterServiceCategoryState();
}

class _RegisterServiceCategoryState extends State<RegisterServiceCategory> {
  TextEditingController categoryController = TextEditingController();

  String mensagemErro = '';
  bool filledFields = false;

  @override
  void initState() {
    super.initState();

    categoryController.addListener(atualizarEstadoCampos);
  }

  void atualizarMensagemErro(String mensagem) {
    setState(() {
      mensagemErro = mensagem;
    });
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = categoryController.text.isNotEmpty;
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
              "Categoria de Serviços",
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
                Utils.buildTextField(
                  controller: categoryController,
                  hintText: 'Adicione uma categoria de serviço',
                  prefixIcon: Icons.category,
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
