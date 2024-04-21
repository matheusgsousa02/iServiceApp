class Address {
  int addressId;
  String street;
  String number;
  String? additionalInfo;
  String city;
  String state;
  String country;
  String postalCode;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  Address({
    required this.addressId,
    required this.street,
    required this.number,
    this.additionalInfo,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressId: json['addressId'] as int,
        street: json['street'] as String,
        number: json['number'] as String,
        additionalInfo: json['additionalInfo'] as String?,
        city: json['city'] as String,
        state: json['state'] as String,
        country: json['country'] as String,
        postalCode: json['postalCode'] as String,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'street': street,
        'number': number,
        'additionalInfo': additionalInfo,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
