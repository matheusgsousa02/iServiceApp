import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  List category = [
    "Categoria 1",
    "Categoria 2",
    "Categoria 3",
    "Categoria 4",
  ];

  List<Color> colors = [Colors.blue, Colors.red, Colors.yellow, Colors.purple];

  List<Icon> icon = [
    Icon(
      Icons.video_library,
      color: Colors.white,
      size: 35,
    ),
    Icon(
      Icons.video_library,
      color: Colors.white,
      size: 35,
    ),
    Icon(
      Icons.video_library,
      color: Colors.white,
      size: 35,
    ),
    Icon(
      Icons.video_library,
      color: Colors.white,
      size: 35,
    ),
  ];

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();
  bool _isSearchSelected = false;

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
                  fillColor: Colors
                      .transparent, // Removendo a cor de fundo do TextField
                  hintStyle: TextStyle(color: Colors.grey[600]),
                ),
                onChanged: (value) {
                  setState(() {
                    _isSearchSelected = true;
                  });
                  // Aqui você pode fazer algo com o valor de pesquisa conforme o usuário digita
                },
                onTap: () {
                  setState(() {
                    _isSearchSelected = true;
                  });
                },
              ),
            ),
          ),
          _isSearchSelected ? SizedBox(height: 8) : Container(),
          _isSearchSelected
              ? Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Busca recente"),
                      SizedBox(height: 10),
                      // Aqui você pode exibir a lista de pesquisas recentes
                    ],
                  ),
                )
              : Container(),
          _isSearchSelected ? SizedBox(height: 8) : Container(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: widget.category.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.6,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        width: 180,
                        decoration: BoxDecoration(
                          color: widget.colors[index],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
