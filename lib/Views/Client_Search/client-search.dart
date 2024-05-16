import 'package:flutter/material.dart';
import 'package:iservice_application/Models/establishment_category.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/user_services.dart';
import 'package:iservice_application/Views/Client_Search/establishment-category.dart';

class SearchPage extends StatefulWidget {
  final UserInfo userInfo;

  const SearchPage({required this.userInfo, Key? key}) : super(key: key);

  static final List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.purple
  ];
  static final List<IconData> icons = [
    Icons.content_cut,
    Icons.content_cut,
    Icons.local_hospital,
    Icons.restaurant_menu
  ];

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  bool _isSearchSelected = false;
  late Future<List<EstablishmentCategory>> _categoryFuture;

  @override
  void initState() {
    super.initState();
    _categoryFuture = UserServices().getEstablishmentCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
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
              "Busca",
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
            padding: const EdgeInsets.all(18),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _isSearchSelected ? Colors.grey[200] : Colors.grey[200],
              ),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: "Buscar",
                  prefixIcon: Icon(Icons.search, color: Color(0xFF2864ff)),
                  suffixIcon: _isSearchSelected
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchFocusNode.unfocus();
                            setState(() {
                              _isSearchSelected = false;
                            });
                          },
                          icon: Icon(Icons.cancel, color: Color(0xFF2864ff)),
                        )
                      : null,
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                onChanged: (value) {
                  setState(() {
                    _isSearchSelected = true;
                  });
                },
                onTap: () {
                  setState(() {
                    _isSearchSelected = true;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<EstablishmentCategory>>(
              future: _categoryFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var categories = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.9,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        var category = categories[index].name;
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EstablishmentCategoryPage(
                                          userInfo: widget.userInfo,
                                          establishmentCategory:
                                              categories[index])),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: SearchPage
                                  .colors[index % SearchPage.colors.length],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    SearchPage
                                        .icons[index % SearchPage.icons.length],
                                    size: 25,
                                    color: SearchPage.colors[
                                        index % SearchPage.colors.length],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  category ?? 'Categoria Desconhecida',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("Erro ao carregar dados"));
                } else {
                  return Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF2864ff)));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
