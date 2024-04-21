class ServiceCategory {
  int serviceCategoryId;
  String name;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  ServiceCategory({
    required this.serviceCategoryId,
    required this.name,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) =>
      ServiceCategory(
        serviceCategoryId: json['serviceCategoryId'] as int,
        name: json['name'] as String,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'serviceCategoryId': serviceCategoryId,
        'name': name,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
