class User {
  int userID;
  int userRoleID;
  String email;
  String password;
  String name;
  DateTime creationDate;
  DateTime? lastLogin;
  DateTime? lastUpdateDate;
  bool excluded;

  User({
    required this.userID,
    required this.userRoleID,
    required this.email,
    required this.password,
    required this.name,
    required this.creationDate,
    this.lastLogin,
    this.lastUpdateDate,
    required this.excluded,
  });

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'userRoleID': userRoleID,
      'email': email,
      'password': password,
      'name': name,
      'creationDate': creationDate.toIso8601String(),
      'lastLogin': lastLogin?.toIso8601String(),
      'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      'excluded': excluded,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userID: json['userID'],
      userRoleID: json['userRoleID'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      creationDate: DateTime.parse(json['creationDate']),
      lastLogin:
          json['lastLogin'] != null ? DateTime.parse(json['lastLogin']) : null,
      lastUpdateDate: json['lastUpdateDate'] != null
          ? DateTime.parse(json['lastUpdateDate'])
          : null,
      excluded: json['excluded'],
    );
  }
}
