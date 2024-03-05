class UserRole {
  int userRoleID;
  String role;
  DateTime? creationDate;
  DateTime? lastUpdateDate;
  bool? excluded;

  UserRole({
    required this.userRoleID,
    required this.role,
    this.creationDate,
    this.lastUpdateDate,
    this.excluded,
  });

  Map<String, dynamic> toJson() {
    return {
      'userRoleID': userRoleID,
      'role': role,
      'creationDate': creationDate?.toIso8601String(),
      'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      'excluded': excluded,
    };
  }

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      userRoleID: json['userRoleID'],
      role: json['role'],
      creationDate: DateTime.parse(json['creationDate']),
      lastUpdateDate: json['lastUpdateDate'] != null
          ? DateTime.parse(json['lastUpdateDate'])
          : null,
      excluded: json['excluded'],
    );
  }
}
