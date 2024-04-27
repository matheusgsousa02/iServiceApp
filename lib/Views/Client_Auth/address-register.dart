import 'package:flutter/material.dart';
import 'package:iservice_application/Models/Auth/Register.dart';
import 'package:iservice_application/Models/Request/address_model.dart';
import 'package:iservice_application/Models/Request/client_profile_model.dart';
import 'package:iservice_application/Models/Request/establishment_profile_model.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Models/via_cep.dart';
import 'package:iservice_application/Services/auth_services.dart';
import 'package:iservice_application/Services/via_cep_services.dart';
import 'package:iservice_application/Views/main-page-client.dart';
import 'package:iservice_application/Views/main-page-establishment.dart';
import '../../Services/Auth/cep.dart';
import '../../Services/Utils/textFieldUtils.dart';

class AddressRegister extends StatefulWidget {
  final UserInfo userInfo;
  final ClientProfileModel? clientProfileModel;
  final EstablishmentProfileModel? establishmentProfileModel;

  const AddressRegister(
      {required this.userInfo,
      this.clientProfileModel,
      this.establishmentProfileModel,
      Key? key})
      : super(key: key);

  @override
  State<AddressRegister> createState() => _AddressRegisterState();
}

class _AddressRegisterState extends State<AddressRegister> {
  TextEditingController cepController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController hoodController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController compController = TextEditingController();
  String mensagemErro = '';
  bool filledFields = false;

  @override
  void initState() {
    super.initState();
    cepController.addListener(atualizarEstadoCampos);
    stateController.addListener(atualizarEstadoCampos);
    cityController.addListener(atualizarEstadoCampos);
    hoodController.addListener(atualizarEstadoCampos);
    streetController.addListener(atualizarEstadoCampos);
    numController.addListener(atualizarEstadoCampos);
    compController.addListener(atualizarEstadoCampos);
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = cepController.text.isNotEmpty &&
          stateController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          hoodController.text.isNotEmpty &&
          streetController.text.isNotEmpty &&
          numController.text.isNotEmpty;

      if (filledFields) {
        atualizarMensagemErro('');
      }
    });
  }

  void atualizarMensagemErro(String mensagem) {
    setState(() {
      mensagemErro = mensagem;
    });
  }

  Future<void> fetchData() async {
    ViaCepServices().getAddress(cepController.text).then((ViaCep viaCep) {
      stateController.text = viaCep.uf ?? '';
      cityController.text = viaCep.localidade ?? '';
      hoodController.text = viaCep.bairro ?? '';
      streetController.text = viaCep.logradouro ?? '';
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    print('Conteúdo de userInfo: ${widget.userInfo}');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            "Crie sua conta",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: cepController,
            style: const TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Cep',
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
                  Icons.share_location_sharp,
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
            onEditingComplete: () {
              fetchData();
            },
          ),
          Utils.buildTextField(
            controller: stateController,
            hintText: 'Estado',
            prefixIcon: Icons.location_city,
          ),
          Utils.buildTextField(
            controller: cityController,
            hintText: 'Cidade',
            prefixIcon: Icons.location_city_outlined,
          ),
          Utils.buildTextField(
            controller: hoodController,
            hintText: 'Bairro',
            prefixIcon: Icons.location_on,
          ),
          Utils.buildTextField(
            controller: streetController,
            hintText: 'Rua',
            prefixIcon: Icons.streetview,
          ),
          Utils.buildTextField(
            controller: numController,
            hintText: 'Número',
            prefixIcon: Icons.confirmation_number,
          ),
          Utils.buildTextField(
            controller: compController,
            hintText: 'Complemento',
            prefixIcon: Icons.article,
          ),
          const SizedBox(height: 40),
          Text(
            mensagemErro,
            style: const TextStyle(color: Colors.red),
          ),
          SizedBox(
            height: 60,
            child: MaterialButton(
              onPressed: () async {
                try {
                  print(widget.clientProfileModel);
                  Register request = Register(
                      userId: widget.userInfo.user.userId,
                      address: AddressModel(
                        street: streetController.text,
                        number: numController.text,
                        additionalInfo: compController.text,
                        city: cityController.text,
                        state: stateController.text,
                        country: 'BR',
                        postalCode: cepController.text,
                      ));
                  if (widget.userInfo.user.userRoleId == 1) {
                    request.establishmentProfile =
                        widget.establishmentProfileModel;
                  } else if (widget.userInfo.user.userRoleId == 2) {
                    request.clientProfile = widget.clientProfileModel;
                  }
                  AuthServices().register(request).then((UserInfo userInfo) {
                    if (userInfo.userRole.userRoleId == 1) {
                      print('1');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MainPageEstablishment(userInfo: userInfo),
                        ),
                      );
                    } else if (userInfo.userRole.userRoleId == 2) {
                      print('2');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MainPageClient(userInfo: userInfo),
                        ),
                      );
                    } else {
                      print('404 not found');
                    }
                  });
                } catch (e) {
                  print('Erro ao executar ação: $e');
                  // Adicione qualquer lógica adicional de tratamento de erro, se necessário.
                }
              },
              color: filledFields ? const Color(0xFF2864ff) : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Avançar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 260),
        ],
      ),
    );
  }
}
