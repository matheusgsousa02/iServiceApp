import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String serviceName;
  final String serviceDuration;
  final String? serviceImage;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapRemove;

  const ServiceCard({
    required this.serviceName,
    required this.serviceDuration,
    this.serviceImage,
    this.onTapEdit,
    this.onTapRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {},
            child: Container(
              child: serviceImage == null
                  ? Image.asset('assets/testeCorte.jpeg') // Imagem padrão
                  : Image.network(serviceImage!), // Imagem da web
              width: 155,
              height: 155,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 5),
          Text(
            serviceName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16, // Reduzindo o tamanho do texto
            ),
          ),
          Text(
            serviceDuration,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              thickness: 1,
              height: 25,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onTapEdit ?? () {},
                child: Container(
                  width: 155,
                  padding: EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    color: Color(0xFF2864ff),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Editar",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: onTapRemove ?? () {},
                child: Container(
                  width: 155,
                  padding: EdgeInsets.symmetric(vertical: 7),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(100, 216, 218, 221),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Remover",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
