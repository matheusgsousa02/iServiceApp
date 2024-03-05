import 'package:flutter/material.dart';

class UsuarioDados extends StatefulWidget {
  const UsuarioDados({Key? key}) : super(key: key);

  @override
  State<UsuarioDados> createState() => _UsuarioDadosState();
}

class _UsuarioDadosState extends State<UsuarioDados> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 60),
            child: Text(
              "Meus dados",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F6F9),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black,
                  elevation: 5,
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'assets/usuario.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        "Informações pessoais",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F6F9),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black,
                  elevation: 5,
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'assets/notificacao.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        "Dados de contato",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFFF5F6F9),
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadowColor: Colors.black,
                  elevation: 5,
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'assets/configuracao.png',
                      width: 25,
                      height: 25,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Text(
                        "Endereço",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
