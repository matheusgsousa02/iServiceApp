import 'package:flutter/material.dart';
import 'package:iservice_application/Models/User/EstablishmentProfile.dart';
import 'package:iservice_application/Services/Utils/textFieldUtils.dart';
import 'package:iservice_application/Views/Client_Auth/address-register.dart';
import '../../Models/User/UserInfo.dart';

class PersonalRegisterEstablishment extends StatefulWidget {
  final UserInfo userInfo;

  const PersonalRegisterEstablishment({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<PersonalRegisterEstablishment> createState() =>
      _PersonalRegisterEstablishmentState();
}

class _PersonalRegisterEstablishmentState
    extends State<PersonalRegisterEstablishment> {
  TextEditingController cnpjController = TextEditingController();
  TextEditingController commercialNameController = TextEditingController();
  TextEditingController commercialContactController = TextEditingController();
  TextEditingController commercialEmailController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<String> opcoes = [
    'Escolha uma opção',
    'Opção 1',
    'Opção 2',
    'Opção 3',
    'Opção 4'
  ];
  String? selectedValue;
  String mensagemErro = '';
  bool filledFields = false;

  @override
  void initState() {
    super.initState();

    cnpjController.addListener(atualizarEstadoCampos);
    commercialNameController.addListener(atualizarEstadoCampos);
    commercialContactController.addListener(atualizarEstadoCampos);
    commercialEmailController.addListener(atualizarEstadoCampos);
    categoryController.addListener(atualizarEstadoCampos);
    descriptionController.addListener(atualizarEstadoCampos);
    selectedValue = opcoes[0];
  }

  void atualizarMensagemErro(String mensagem) {
    setState(() {
      mensagemErro = mensagem;
    });
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = cnpjController.text.isNotEmpty &&
          commercialNameController.text.isNotEmpty &&
          commercialContactController.text.isNotEmpty &&
          commercialEmailController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty;
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Informações Adicionais",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Utils.buildTextField(
                  controller: cnpjController,
                  hintText: 'CNPJ',
                  prefixIcon: Icons.document_scanner_outlined,
                ),
                const SizedBox(
                  height: 10,
                ),
                Utils.buildTextField(
                  controller: commercialNameController,
                  hintText: 'Nome do seu estabelecimento',
                  prefixIcon: Icons.business,
                ),
                const SizedBox(
                  height: 10,
                ),
                Utils.buildTextField(
                  controller: commercialContactController,
                  hintText: 'Contato comercial',
                  prefixIcon: Icons.local_phone,
                ),
                const SizedBox(
                  height: 10,
                ),
                Utils.buildTextField(
                  controller: commercialEmailController,
                  hintText: 'E-mail comercial',
                  prefixIcon: Icons.email_sharp,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: descriptionController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  maxLines: null,
                  maxLength: 500,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: 'Apresente seu negocio',
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
                        Icons.article_outlined,
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
                  onChanged: (value) {
                    if (descriptionController.text.length > 105) {
                      descriptionController.text =
                          descriptionController.text.substring(0, 105);
                    }
                    atualizarEstadoCampos();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton<String>(
                    value: selectedValue,
                    onChanged: (newValue) {
                      setState(() {
                        selectedValue = newValue;
                        mensagemErro = '';
                      });
                    },
                    items:
                        opcoes.map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.category,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                value ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    underline: Container(
                      height: 1.5,
                      decoration: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  mensagemErro,
                  style: const TextStyle(color: Colors.red),
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () async {
                    if (filledFields) {
                      String cnpj = cnpjController.text;
                      String commercialName = commercialNameController.text;
                      String commercialContact =
                          commercialContactController.text;
                      String commercialEmail = commercialEmailController.text;
                      String description = descriptionController.text;

                      widget.userInfo.establishmentProfile =
                          EstablishmentProfile(
                              cnpj: cnpj,
                              commercialName: commercialName,
                              description: description,
                              commercialPhone: commercialContact,
                              commercialEmail: commercialEmail);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddressRegister(userInfo: widget.userInfo),
                        ),
                      );
                    } else {
                      atualizarMensagemErro(
                          'Por favor, preencha todos os campos.');
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
                const SizedBox(
                  height: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
