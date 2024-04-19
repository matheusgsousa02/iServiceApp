import 'package:flutter/material.dart';
import 'package:iservice_application/Models/User/UserInfo.dart';
import 'package:iservice_application/Services/Auth/pre_register.dart';
import 'package:iservice_application/Services/Utils/textFieldUtils.dart';
import 'package:iservice_application/Views/Establishment_Auth/personal-register.dart';
import '../../Services/Utils/validationsUtils.dart';

class RegisterEstablishmentPage extends StatefulWidget {
  const RegisterEstablishmentPage({Key? key}) : super(key: key);

  @override
  State<RegisterEstablishmentPage> createState() =>
      _RegisterEstablishmentPageState();
}

class _RegisterEstablishmentPageState extends State<RegisterEstablishmentPage> {
  TextEditingController commercialNameController = TextEditingController();
  TextEditingController commercialEmailController = TextEditingController();
  TextEditingController commercialPasswordController = TextEditingController();
  TextEditingController confirmCPasswordController = TextEditingController();
  String mensagemErro = '';
  bool filledFields = false;
  bool visiblePassword = false;
  bool visibleCPassword = false;

  @override
  void initState() {
    super.initState();

    commercialNameController.addListener(atualizarEstadoCampos);
    commercialEmailController.addListener(atualizarEstadoCampos);
    commercialPasswordController.addListener(atualizarEstadoCampos);
    confirmCPasswordController.addListener(atualizarEstadoCampos);
  }

  void atualizarEstadoCampos() {
    setState(() {
      filledFields = commercialNameController.text.isNotEmpty &&
          commercialEmailController.text.isNotEmpty &&
          commercialPasswordController.text.isNotEmpty &&
          confirmCPasswordController.text.isNotEmpty;

      if (filledFields) {
        atualizarMensagemErro('');
      }
    });
  }

  List<ValidationResult> passwordValidations = [];

  void atualizarValidacoesSenha(String senha) {
    setState(() {
      passwordValidations = ValidationPassword.validatePassword(senha);
    });
  }

  void atualizarMensagemErro(String mensagem) {
    setState(() {
      mensagemErro = mensagem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Text(
                "Crie sua conta",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Utils.buildTextField(
                controller: commercialNameController,
                hintText: 'Nome',
                prefixIcon: Icons.account_circle_rounded,
              ),
              const SizedBox(
                height: 20,
              ),
              Utils.buildTextField(
                controller: commercialEmailController,
                hintText: 'E-mail',
                prefixIcon: Icons.email_sharp,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: commercialPasswordController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                obscureText: !visiblePassword,
                onChanged: (senha) {
                  atualizarValidacoesSenha(senha);
                },
                decoration: InputDecoration(
                  hintText: 'Senha',
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
                      Icons.lock_open_sharp,
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.5),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      visiblePassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        visiblePassword = !visiblePassword;
                      });
                    },
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: passwordValidations.map((validation) {
                  return Text(
                    '${validation.message}: ${validation.isValid ? 'OK' : 'Falta'}',
                    style: TextStyle(
                      color: validation.isValid ? Colors.green : Colors.red,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: confirmCPasswordController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                obscureText: !visibleCPassword,
                decoration: InputDecoration(
                  hintText: 'Confirme a senha',
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
                      Icons.lock_outline_sharp,
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.5),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      visibleCPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        visibleCPassword = !visibleCPassword;
                      });
                    },
                  ),
                ),
              ),
              // Botão de avançar
              SizedBox(
                height: 40,
                child: Text(
                  mensagemErro,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () async {
                  if (!filledFields) {
                    atualizarMensagemErro(
                        'Por favor, preencha todos os campos.');
                  } else if (commercialPasswordController.text !=
                      confirmCPasswordController.text) {
                    atualizarMensagemErro('As senhas não são iguais.');
                  } else if (!ValidationUtils.isValidEmail(
                      commercialEmailController.text)) {
                    setState(() {
                      mensagemErro = 'Por favor, insira um e-mail válido.';
                    });
                    print('Mensagem de erro definida para: $mensagemErro');
                  } else {
                    try {
                      PreRegisterService()
                          .preRegister(
                        1,
                        commercialEmailController.text,
                        commercialNameController.text,
                        commercialPasswordController.text,
                      )
                          .then((UserInfo userInfo) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonalRegisterEstablishment(
                                userInfo: userInfo),
                          ),
                        );
                      }).catchError((e) {
                        print('Erro ao registrar usuário: $e');
                        atualizarMensagemErro('Erro ao registrar usuário: $e');
                      });
                    } catch (error) {
                      atualizarMensagemErro(
                          'Erro ao registrar usuário: $error');
                    }
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
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
