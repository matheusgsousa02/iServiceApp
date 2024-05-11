import 'package:flutter/material.dart';
import 'package:iservice_application/Models/Request/establishment_profile_model.dart';
import 'package:iservice_application/Models/establishment_profile.dart';
import 'package:iservice_application/Models/profile_update.dart';
import 'package:iservice_application/Models/user.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/Utils/textFieldUtils.dart';
import 'package:iservice_application/Services/user_services.dart';
import 'package:iservice_application/Views/Address/address-register.dart';

class EditPersonalEstablishment extends StatefulWidget {
  final UserInfo userInfo;

  const EditPersonalEstablishment({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<EditPersonalEstablishment> createState() =>
      _EditPersonalEstablishmentState();
}

class _EditPersonalEstablishmentState extends State<EditPersonalEstablishment> {
  TextEditingController commercialNameController = TextEditingController();
  TextEditingController cnpjController = TextEditingController();
  TextEditingController establishmntNameController = TextEditingController();
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
    fetchData();
    commercialNameController.addListener(atualizarEstadoCampos);
    cnpjController.addListener(atualizarEstadoCampos);
    establishmntNameController.addListener(atualizarEstadoCampos);
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

  Future<void> fetchData() async {
    UserServices()
        .getUserInfoByUserId(widget.userInfo.user.userId)
        .then((UserInfo userInfo) {
      print(userInfo.establishmentProfile);
      commercialNameController.text = userInfo.user.name ?? '';
      cnpjController.text = userInfo.establishmentProfile!.cnpj ?? '';
      establishmntNameController.text =
          userInfo.establishmentProfile!.commercialName ?? '';
      commercialContactController.text =
          userInfo.establishmentProfile!.commercialPhone ?? '';
      commercialEmailController.text =
          userInfo.establishmentProfile!.commercialEmail ?? '';
      /*categoryController.text = userInfo.establishmentProfile!. ?? '';*/
      descriptionController.text =
          userInfo.establishmentProfile!.description ?? '';
    }).catchError((e) {});
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = commercialNameController.text.isNotEmpty &&
          cnpjController.text.isNotEmpty &&
          establishmntNameController.text.isNotEmpty &&
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
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Perfil",
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
          height: 500,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18.0),
            child: Column(
              children: <Widget>[
                const Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Utils.buildTextField(
                  controller: commercialNameController,
                  hintText: 'Nome',
                  prefixIcon: Icons.account_circle_rounded,
                ),
                const SizedBox(
                  height: 10,
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
                  controller: establishmntNameController,
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
                    try {
                      ProfileUpdate request = ProfileUpdate(
                          name: commercialNameController.text,
                          establishmentProfile: EstablishmentProfile(
                            userId: widget.userInfo.user.userId,
                            cnpj: cnpjController.text,
                            commercialName: establishmntNameController.text,
                            establishmentProfileId: widget.userInfo
                                .establishmentProfile!.establishmentProfileId,
                            description: descriptionController.text,
                            commercialPhone: commercialContactController.text,
                            commercialEmail: commercialEmailController.text,
                            addressId: widget.userInfo.address!.addressId,
                            establishmentCategoryId: widget.userInfo
                                .establishmentProfile!.establishmentCategoryId,
                            creationDate: DateTime.now(),
                          ));

                      UserServices()
                          .editProfile(request)
                          .then((UserInfo updatedProfile) {
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
                    "Atualizar",
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
