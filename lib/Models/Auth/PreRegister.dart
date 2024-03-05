class PreRegister {
  int userRoleID;
  String email;
  String name;
  String password;

  PreRegister({
    required this.userRoleID,
    required this.email,
    required this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userRoleID': userRoleID,
      'email': email,
      'name': name,
      'password': password,
    };
  }

  factory PreRegister.fromJson(Map<String, dynamic> json) {
    return PreRegister(
      userRoleID: json['userRoleID'],
      email: json['email'],
      name: json['name'],
      password: json['password'],
    );
  }
}
