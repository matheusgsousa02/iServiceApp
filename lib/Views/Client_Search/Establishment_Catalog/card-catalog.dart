import 'package:flutter/material.dart';

class CardCatalog extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {
      'title': 'Pastel De Brócolis Com Mussarela E Bacon',
      'description': 'Brócolis e mussarela e bacon',
      'price': 'a partir de R\$ 11,99',
      'imageUrl': 'assets/testeCorte.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return MenuItemCard(
          title: items[index]['title'],
          description: items[index]['description'],
          price: items[index]['price'],
          imageUrl: items[index]['imageUrl'],
        );
      },
    );
  }
}

@override
class MenuItemCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String imageUrl;

  const MenuItemCard({
    Key? key,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title.length > 25
                            ? '${title.substring(0, 25)}...'
                            : title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Text(
                        description,
                        style: TextStyle(color: Colors.black),
                      ),
                      Text('$price',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4.0),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  child: Image.asset(imageUrl, fit: BoxFit.cover),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
                thickness: 1, color: Colors.grey[300]), // Divider moved here
          ],
        ),
      ),
    );
  }
}
