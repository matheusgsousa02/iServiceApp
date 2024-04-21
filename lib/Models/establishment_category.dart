class EstablishmentCategory {
  int? establishmentCategoryId;
  String? name;
  DateTime? creationDate;
  DateTime? lastUpdateDate;

  EstablishmentCategory({
    this.establishmentCategoryId,
    this.name,
    this.creationDate,
    this.lastUpdateDate,
  });

  // Método para converter de um Map para o modelo
  factory EstablishmentCategory.fromJson(Map<String, dynamic> json) =>
      EstablishmentCategory(
        establishmentCategoryId: json['establishmentCategoryId'] as int?,
        name: json['name'] as String?,
        creationDate: json['creationDate'] == null
            ? null
            : DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  // Método para converter o modelo para um Map
  Map<String, dynamic> toJson() => {
        'establishmentCategoryId': establishmentCategoryId,
        'name': name,
        'creationDate': creationDate?.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
