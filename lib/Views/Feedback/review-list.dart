import 'package:flutter/material.dart';
import 'package:iservice_application/Models/user_info.dart';

class ReviewList extends StatefulWidget {
  final UserInfo userInfo;

  const ReviewList({required this.userInfo, Key? key}) : super(key: key);

  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  final double averageRating = 4.8;
  final int totalReviewsLast90Days = 1081;
  final int totalReviews = 12774;

  final List<Map<String, dynamic>> ratings = [
    {'name': 'Juliano', 'rating': 5.0, 'date': '08/05/2024'},
    {'name': 'Camila', 'rating': 5.0, 'date': '08/05/2024'},
    // Adicione mais avaliações aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(right: 55.0),
            child: Text(
              "Avaliações",
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '4,8',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '1.081 avaliações',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: ratings.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 0.0,
                      margin:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: ListTile(
                        title: Text(ratings[index]['name'],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${ratings[index]['rating']} ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            ...List.generate(
                                5,
                                (idx) => Icon(Icons.star,
                                    color: idx < ratings[index]['rating']
                                        ? Colors.orange
                                        : Colors.grey[300],
                                    size: 20)),
                          ],
                        ),
                        trailing: Text(ratings[index]['date'],
                            style: TextStyle(color: Colors.grey, fontSize: 16)),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey[300],
                      height: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
