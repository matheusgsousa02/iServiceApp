class UserRoleModel {
  String name;

  UserRoleModel({required this.name});

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
