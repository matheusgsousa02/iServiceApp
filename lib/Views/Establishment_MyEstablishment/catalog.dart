import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iservice_application/Models/service.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/Auth/register.dart';
import 'package:iservice_application/Services/service_services.dart';
import 'package:iservice_application/Views/Establishment_Services/register-services.dart';
import '../Establishment_MyEstablishment/service-card.dart';

class Catalog extends StatefulWidget {
  final UserInfo userInfo;

  const Catalog({required this.userInfo, Key? key}) : super(key: key);

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  Future<List<Service>> _servicesFuture = Future.value([]);

  @override
  void initState() {
    super.initState();

    // Chamada para obter os serviços da API
    ServiceServices()
        .getByEstablishmentProfileId(
            widget.userInfo.establishmentProfile!.establishmentProfileId)
        .then((List<Service> services) {
      setState(() {
        _servicesFuture = Future.value(services);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Catalogo",
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegisterServices(userInfo: widget.userInfo)),
                );
              },
              child: Container(
                width: 390,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: Color(0xFF2864ff),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Adicionar um novo serviço",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Service>>(
              future: _servicesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.56,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final service = snapshot.data![index];
                      return ServiceCard(
                        serviceName: service.name,
                        serviceDuration: '${service.estimatedDuration} minutos',
                        onTapEdit: () {
                          // Lógica para editar o serviço
                        },
                        onTapRemove: () {
                          // Lógica para remover o serviço
                        },
                      );
                    },
                  );
                } else {
                  return Center(
                      child: Text(
                          'Nenhum serviço disponível.')); // Exibe mensagem se não houver dados
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
