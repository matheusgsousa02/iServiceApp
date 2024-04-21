class UserModel {
  int userRoleId;
  String email;
  String password;
  String name;

  UserModel({
    required this.userRoleId,
    required this.email,
    required this.password,
    required this.name,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userRoleId: json['userRoleId'] as int,
        email: json['email'] as String,
        password: json['password'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'userRoleId': userRoleId,
        'email': email,
        'password': password,
        'name': name,
      };
}
