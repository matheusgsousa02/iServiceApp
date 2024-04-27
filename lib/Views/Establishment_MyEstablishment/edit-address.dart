import 'package:flutter/material.dart';
import 'package:iservice_application/Models/Address.dart';
import 'package:iservice_application/Models/Auth/Register.dart';
import 'package:iservice_application/Models/Request/address_model.dart';
import 'package:iservice_application/Models/Request/client_profile_model.dart';
import 'package:iservice_application/Models/Request/establishment_profile_model.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Models/via_cep.dart';
import 'package:iservice_application/Services/auth_services.dart';
import 'package:iservice_application/Services/user_services.dart';
import 'package:iservice_application/Services/via_cep_services.dart';
import 'package:iservice_application/Views/main-page-client.dart';
import 'package:iservice_application/Views/main-page-establishment.dart';
import '../../Services/Utils/textFieldUtils.dart';

class EditAddress extends StatefulWidget {
  final UserInfo userInfo;
  final ClientProfileModel? clientProfileModel;
  final EstablishmentProfileModel? establishmentProfileModel;

  const EditAddress(
      {required this.userInfo,
      this.clientProfileModel,
      this.establishmentProfileModel,
      Key? key})
      : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
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
    fetchData();
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
    UserServices()
        .getUserInfoByUserId(widget.userInfo.address!.addressId)
        .then((UserInfo userInfo) {
      cepController.text = userInfo.address!.postalCode ?? '';
      stateController.text = userInfo.address!.state ?? '';
      cityController.text = userInfo.address!.city ?? '';
      /*hoodController.text = userInfo.address!. ?? '';*/
      streetController.text = userInfo.address!.street ?? '';
      numController.text = userInfo.address!.number ?? '';
      compController.text = userInfo.address!.additionalInfo ?? '';
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Endereço",
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        children: <Widget>[
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
                  Address request = Address(
                      addressId: widget.userInfo.address!.addressId,
                      street: streetController.text,
                      number: numController.text,
                      additionalInfo: compController.text,
                      city: cityController.text,
                      state: stateController.text,
                      country: 'BR',
                      postalCode: cepController.text,
                      creationDate: DateTime.now());

                  UserServices()
                      .editAddress(request)
                      .then((Address updatedAddress) {
                    if (filledFields) {
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
                    } else {
                      print('404 not found');
                    }
                  });
                } catch (e) {
                  print('Erro ao executar ação: $e');
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
