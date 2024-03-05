class Address {
  int? addressID;
  String street;
  String number;
  String additionalInfo;
  String city;
  String state;
  String country;
  String postalCode;
  DateTime? creationDate;
  DateTime? lastUpdateDate;
  bool? excluded;

  Address({
    this.addressID,
    required this.street,
    required this.number,
    required this.additionalInfo,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    this.creationDate,
    this.lastUpdateDate,
    this.excluded,
  });

  Address.required({
    required this.street,
    required this.number,
    required this.additionalInfo,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  })  : addressID = null,
        creationDate = null,
        lastUpdateDate = null,
        excluded = null;

  Map<String, dynamic> toJson() {
    return {
      'addressID': addressID,
      'street': street,
      'number': number,
      'additionalInfo': additionalInfo,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'creationDate': creationDate?.toIso8601String(),
      'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      'excluded': excluded,
    };
  }

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      addressID: json['addressID'],
      street: json['street'],
      number: json['number'],
      additionalInfo: json['additionalInfo'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
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
