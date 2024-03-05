class ClientProfile {
  int? clientProfileID;
  int? userID;
  String cpf;
  DateTime dateOfBirth;
  String phone;
  int? addressID;
  DateTime? creationDate;
  DateTime? lastUpdateDate;
  bool? excluded;

  ClientProfile({
    this.clientProfileID,
    this.userID,
    required this.cpf,
    required this.dateOfBirth,
    required this.phone,
    this.addressID,
    this.creationDate,
    this.lastUpdateDate,
    this.excluded,
  }) {}

  ClientProfile.required({
    required this.cpf,
    required this.dateOfBirth,
    required this.phone,
  })  : clientProfileID = null,
        userID = null,
        addressID = null,
        creationDate = null,
        lastUpdateDate = null,
        excluded = null;

  Map<String, dynamic> toJson() {
    return {
      'clientProfileID': clientProfileID,
      'userID': userID,
      'cpf': cpf,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'phone': phone,
      'addressID': addressID,
      'creationDate': creationDate?.toIso8601String(),
      'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      'excluded': excluded,
    };
  }

  factory ClientProfile.fromJson(Map<String, dynamic> json) {
    return ClientProfile(
      clientProfileID: json['clientProfileID'],
      userID: json['userID'],
      cpf: json['cpf'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      phone: json['phone'],
      addressID: json['addressID'],
      creationDate: DateTime.parse(json['creationDate']),
      lastUpdateDate: json['lastUpdateDate'] != null
          ? DateTime.parse(json['lastUpdateDate'])
          : null,
      excluded: json['excluded'],
    );
  }
}
