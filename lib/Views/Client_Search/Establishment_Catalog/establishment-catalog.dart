import 'package:flutter/material.dart';

import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Views/Client_Search/Establishment_Catalog/card-catalog.dart';

class EstablishmentCatalog extends StatefulWidget {
  final UserInfo userInfo;

  const EstablishmentCatalog({required this.userInfo, Key? key})
      : super(key: key);

  @override
  State<EstablishmentCatalog> createState() => _EstablishmentCatalogState();
}

class _EstablishmentCatalogState extends State<EstablishmentCatalog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      fetchDataForTab(_tabController.index);
    }
  }

  void fetchDataForTab(int tabIndex) {
    // Aqui você faria a requisição à API usando o índice do tab para buscar a categoria correspondente
    // Supondo que cada tab tem um ID de categoria, você poderia passar esse ID para a API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jikan Poke"),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 40, // Define o tamanho do avatar
                          backgroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(
                            'https://via.placeholder.com/150', // URL da imagem (substituir posteriormente)
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nome do Estabelecimento',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                'Rua: Manoel de sousa mendes - 162\njardim progresso - mogi guaçu\nCEP: 13844-301',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text("Lista de horarios aqui"),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Horário de funcionamento',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF2864ff),
                              ),
                            ),
                            SizedBox(width: 25),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                '★ 4,8',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: BorderSide(color: Colors.black54),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  Tab(text: "Destaques"),
                  Tab(text: "Monte seu Poke"),
                  Tab(text: "Pokes"),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CardCatalog(),
          Center(child: Text("Personalize seu Poke")),
          Center(child: Text("Lista de Pokes")),
        ],
      ),
    );
  }
}
