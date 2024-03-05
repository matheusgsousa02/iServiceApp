class EstablishmentProfile {
  int? establishmentProfileID;
  int? userID;
  String cnpj;
  String commercialName;
  int? addressID;
  String description;
  String commercialPhone;
  String commercialEmail;
  DateTime? creationDate;
  DateTime? lastUpdateDate;
  bool? excluded;

  EstablishmentProfile({
    this.establishmentProfileID,
    this.userID,
    required this.cnpj,
    required this.commercialName,
    this.addressID,
    required this.description,
    required this.commercialPhone,
    required this.commercialEmail,
    this.creationDate,
    this.lastUpdateDate,
    this.excluded,
  });

  EstablishmentProfile.empty()
      : cnpj = '',
        commercialName = '',
        description = '',
        commercialPhone = '',
        commercialEmail = '';

  EstablishmentProfile.required({
    required this.cnpj,
    required this.commercialName,
    required this.description,
    required this.commercialPhone,
    required this.commercialEmail,
  })  : establishmentProfileID = null,
        userID = null,
        addressID = null,
        creationDate = null,
        lastUpdateDate = null,
        excluded = null;

  Map<String, dynamic> toJson() {
    return {
      'establishmentProfileID': establishmentProfileID,
      'userID': userID,
      'cnpj': cnpj,
      'commercialName': commercialName,
      'addressID': addressID,
      'description': description,
      'commercialPhone': commercialPhone,
      'commercialEmail': commercialEmail,
      'creationDate': creationDate?.toIso8601String(),
      'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      'excluded': excluded,
    };
  }

  factory EstablishmentProfile.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty || json['establishmentProfileID'] == null) {
      return EstablishmentProfile.empty();
    }
    return EstablishmentProfile(
      establishmentProfileID: json['establishmentProfileID'],
      userID: json['userID'],
      cnpj: json['cnpj'],
      commercialName: json['commercialName'],
      addressID: json['addressID'],
      description: json['description'],
      commercialPhone: json['commercialPhone'],
      commercialEmail: json['commercialEmail'],
      creationDate: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
      lastUpdateDate: json['lastUpdateDate'] != null
          ? DateTime.parse(json['lastUpdateDate'])
          : null,
      excluded: json['excluded'],
    );
  }
}
