class EstablishmentCategoryModel {
  String? name;

  EstablishmentCategoryModel({this.name});

  // Método para converter de um Map para o modelo
  factory EstablishmentCategoryModel.fromJson(Map<String, dynamic> json) =>
      EstablishmentCategoryModel(
        name: json['name'],
      );

  // Método para converter o modelo para um Map
  Map<String, dynamic> toJson() => {
        'name': name,
      };
}