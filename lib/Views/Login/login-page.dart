import 'package:flutter/material.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Views/Home_Page/home-page-client.dart';
import 'package:iservice_application/Views/main-page-establishment.dart';
import '../../Services/Utils/validationsUtils.dart';
import '../../Models/Auth/Login.dart';
import '../../Services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String mensagemErro = '';
  bool visiblePassword = false;

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
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Faça login em sua conta",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),

              TextFormField(
                controller: emailController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Email',
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
                      Icons.email_sharp,
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

              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: passwordController,
                style: const TextStyle(
                  color: Colors.black,
                ),
                obscureText: !visiblePassword,
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

              // Esqueceu a senha?
              /*const SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RedefinirSenhaPage(),
                    ),
                  );
                },
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Esqueceu a senha?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),*/
              SizedBox(
                height: 20,
              ),
              if (mensagemErro.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    mensagemErro,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),

              const SizedBox(
                height: 40,
              ),

              MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    setState(() {
                      mensagemErro = 'Por favor, preencha todos os campos.';
                    });
                  } else if (!ValidationUtils.isValidEmail(
                      emailController.text)) {
                    setState(() {
                      mensagemErro = 'Por favor, insira um e-mail válido.';
                    });
                  } else {
                    setState(() {
                      mensagemErro = '';
                    });
                    Login requestLogin = Login(
                        email: emailController.text,
                        password: passwordController.text);
                    AuthServices()
                        .login(requestLogin)
                        .then((UserInfo userInfo) {
                      if (userInfo.userRole.userRoleId == 1) {
                        print('1');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPageEstablishment(),
                          ),
                        );
                      } else if (userInfo.userRole.userRoleId == 2) {
                        print('2');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePageClient(),
                          ),
                        );
                      } else {
                        messageError('404 not found');
                      }
                    }).catchError((e) {
                      messageError(e.toString());
                    });
                  }
                },
                color: const Color(0xFF2864ff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),

              const SizedBox(
                height: 260,
              ),
            ],
          ),
        ),
      ),
    );
  }

  messageError(String message) {
    setState(() {
      mensagemErro = message;
    });
  }
}
