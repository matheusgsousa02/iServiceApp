import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iservice_application/Models/establishment_category.dart';
import 'package:iservice_application/Models/establishment_profile.dart';
import 'package:iservice_application/Models/service.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/service_services.dart';
import 'package:iservice_application/Services/user_services.dart';
import 'package:iservice_application/Views/Client_Search/Establishment_Catalog/establishment-catalog.dart';

class EstablishmentCategoryPage extends StatefulWidget {
  final UserInfo userInfo;
  final EstablishmentCategory establishmentCategory;

  const EstablishmentCategoryPage(
      {required this.userInfo, required this.establishmentCategory, Key? key})
      : super(key: key);

  @override
  State<EstablishmentCategoryPage> createState() =>
      _EstablishmentCategoryPageState();
}

class _EstablishmentCategoryPageState extends State<EstablishmentCategoryPage> {
  List<dynamic> listaEstabelecimentos = [];

  @override
  void initState() {
    super.initState();
    _loadEstablishmentData();
  }

  void _loadEstablishmentData() {
    UserServices()
        .getEstablishmentProfileByEstablishmentCategoryId(
            widget.establishmentCategory.establishmentCategoryId!)
        .then((List<EstablishmentProfile> establishments) {
      setState(() {
        listaEstabelecimentos = establishments
            .map((establishment) => {
                  'nome': establishment.commercialName,
                  'avaliacao': '4.7',
                  'categoria': widget.establishmentCategory.name,
                  'URLlogo': establishment.photo ?? 'assets/testeCorte.jpeg'
                })
            .toList();
      });
    }).catchError((e) {
      print('Erro ao carregar dados do estabelecimento: $e');
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
              "Categoria",
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
      body: ListView.builder(
        itemCount: listaEstabelecimentos.length,
        itemBuilder: (context, index) {
          var estabelecimento = listaEstabelecimentos[index];
          return GestureDetector(
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EstablishmentCatalog(
                    establishment: estabelecimento['estabelecimento'],
                  ),
                ),
              );*/
            },
            child: Card(
              color: Colors.white,
              elevation: 0.0,
              margin: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(estabelecimento['URLlogo']),
                    ),
                    title: Text(estabelecimento['nome']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: [
                          Text(
                            '${estabelecimento['avaliacao']} ★',
                            style: TextStyle(color: Color(0xFFe6ac27)),
                          ),
                          Text('  ${estabelecimento['categoria']}'),
                        ]),
                        SizedBox(height: 4.0),
                      ],
                    ),
                  ),
                  Divider(thickness: 1, color: Colors.grey[300]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
