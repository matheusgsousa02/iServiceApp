import 'package:flutter/material.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:iservice_application/Services/Utils/clipPathWidget.dart';
import 'package:iservice_application/Views/Home_Page/home-page-client.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPage extends StatefulWidget {
  final UserInfo userInfo;

  const ReviewPage({required this.userInfo, Key? key}) : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPathWidget(),
            Positioned(
              top: 300,
              left: -187,
              child: Opacity(
                opacity: 0.9,
                child: Image.asset('assets/foto_perfil.png'),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color: Colors.white),
                          child: IconButton(
                            icon: Icon(Icons.arrow_back_ios_new),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        SizedBox(width: 50),
                        Text(
                          'Avalie o serviço!',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        )
                      ],
                    ),
                    SizedBox(height: 55),
                    CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                    SizedBox(height: 10),
                    Text('Estabelecimento',
                        style: TextStyle(color: Colors.black, fontSize: 24)),
                    SizedBox(height: 5),
                    Text('Serviço',
                        style: TextStyle(color: Colors.black54, fontSize: 18)),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Duração',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16)),
                              Text('Valor',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 16)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Duração',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18)),
                              Text('Valor',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18)),
                            ],
                          ),
                          SizedBox(height: 30),
                          Text('Como foi o seu atendimento?',
                              style: TextStyle(fontSize: 18)),
                          SizedBox(height: 10),
                          RatingBar.builder(
                            initialRating: _rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, index) {
                              return Icon(
                                _rating > index
                                    ? Icons.star
                                    : Icons.star_border,
                                color: _rating > index
                                    ? Color(0xFF2864ff)
                                    : Color(0xFF2864ff),
                              );
                            },
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(), // Borda padrão
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF2864ff), width: 2.0),
                              ),
                              labelText: 'Comentário adicional',
                              labelStyle:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 20),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePageClient(
                                          userInfo: widget.userInfo)));
                            },
                            color: const Color(0xFF2864ff),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text("Estabelecimento",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
