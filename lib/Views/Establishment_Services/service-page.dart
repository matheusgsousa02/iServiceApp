import 'package:flutter/material.dart';
import 'package:iservice_application/Models/user_info.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart'
    as CupertinoDatePicker;

class ServicePage extends StatefulWidget {
  final UserInfo userInfo;

  ServicePage({required this.userInfo, Key? key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
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
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'assets/testeCorte.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'produto',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'descrção - Lorem ipsum dolor sit amet. Aut itaque expedita sed tempore nemo qui voluptatem quia aut facilis dicta At quas quia. Sit fugiat laudantium et voluptatum nemo et nisi consequatur ex beatae maxime.',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[700]!,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(18),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.home_work_outlined),
                                SizedBox(width: 10),
                                Text(
                                  'Estabelecimento',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.star,
                                  color: Color(0xFFfead26),
                                ),
                                Text(
                                  '5.0',
                                  style: TextStyle(
                                    color: Color(0xFFe6ac27),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Icon(Icons.access_time_outlined),
                                SizedBox(width: 10),
                                Text(
                                  'Duração:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '1:00',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[],
                              ),
                            );
                          },
                        );
                      },
                      color: const Color(0xFF2864ff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Agendar",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
