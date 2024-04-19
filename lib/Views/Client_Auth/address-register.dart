import 'package:flutter/material.dart';
import 'package:iservice_application/Models/User/UserInfo.dart';
import 'package:iservice_application/Services/Auth/register.dart';
import 'package:iservice_application/Views/Home_Page/home-page-client.dart';
import '../../Services/Auth/cep.dart';
import '../../Services/Utils/textFieldUtils.dart';
import '../../Models/User/Address.dart';

class AddressRegister extends StatefulWidget {
  final UserInfo userInfo;

  const AddressRegister({required this.userInfo, Key? key}) : super(key: key);

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
          numController.text.isNotEmpty &&
          compController.text.isNotEmpty;

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
    await EndCep.fetchData(
      cepController.text,
      stateController,
      cityController,
      hoodController,
      streetController,
    );
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
                  widget.userInfo.address = Address(
                    street: streetController.text,
                    number: numController.text,
                    additionalInfo: compController.text,
                    city: cityController.text,
                    state: stateController.text,
                    country: 'BR',
                    postalCode: cepController.text,
                  );

                  RegisterService()
                      .register(widget.userInfo)
                      .then((UserInfo userInfo) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomePageClient(userInfo: userInfo),
                      ),
                    );
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
