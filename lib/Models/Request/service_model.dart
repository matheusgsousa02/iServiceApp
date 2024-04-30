import 'package:http/http.dart' as http;

class ServiceModel {
  int establishmentProfileId;
  int serviceCategoryId;
  String name;
  String description;
  double price; // Decimal em C# é convertido para double em Dart
  double estimatedDuration;
  String? imagePath; // Para armazenar o caminho do arquivo da imagem
  List<int>? photo; // Para armazenar dados binários

  ServiceModel({
    required this.establishmentProfileId,
    required this.serviceCategoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.estimatedDuration,
    this.imagePath,
    this.photo,
  });

  Map<String, dynamic> toJson() {
    return {
      'EstablishmentProfileId': establishmentProfileId,
      'ServiceCategoryId': serviceCategoryId,
      'Name': name,
      'Description': description,
      'Price': price,
      'EstimatedDuration': estimatedDuration,
      'ImagePath':
          imagePath, // Incluído para completude mas não usado tipicamente em envio de arquivos
    };
  }

  static ServiceModel fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      establishmentProfileId: json['EstablishmentProfileId'],
      serviceCategoryId: json['ServiceCategoryId'],
      name: json['Name'],
      description: json['Description'],
      price: json['Price']?.toDouble() ??
          0.0, // Assegurando que o valor é um double
      estimatedDuration: json['EstimatedDuration']?.toDouble() ?? 0.0,
      imagePath: json['ImagePath'],
    );
  }
}
