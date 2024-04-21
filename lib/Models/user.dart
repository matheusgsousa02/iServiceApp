class User {
  int userId;
  int userRoleId;
  String email;
  String password;
  String name;
  DateTime creationDate;
  DateTime? lastLogin;
  DateTime? lastUpdateDate;

  User({
    required this.userId,
    required this.userRoleId,
    required this.email,
    required this.password,
    required this.name,
    required this.creationDate,
    this.lastLogin,
    this.lastUpdateDate,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'] as int,
        userRoleId: json['userRoleId'] as int,
        email: json['email'] as String,
        password: json['password'] as String,
        name: json['name'] as String,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastLogin: json['lastLogin'] == null
            ? null
            : DateTime.parse(json['lastLogin'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userRoleId': userRoleId,
        'email': email,
        'password': password,
        'name': name,
        'creationDate': creationDate.toIso8601String(),
        'lastLogin': lastLogin?.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
