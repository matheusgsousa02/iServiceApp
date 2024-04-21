class UserRole {
  int userRoleId;
  String name;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  UserRole({
    required this.userRoleId,
    required this.name,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        userRoleId: json['userRoleId'] as int,
        name: json['name'] as String,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'userRoleId': userRoleId,
        'name': name,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
