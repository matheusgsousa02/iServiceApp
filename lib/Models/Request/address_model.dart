class AddressModel {
  String street;
  String number;
  String? additionalInfo;
  String city;
  String state;
  String country;
  String postalCode;

  AddressModel({
    required this.street,
    required this.number,
    this.additionalInfo,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json['street'] as String,
        number: json['number'] as String,
        additionalInfo: json['additionalInfo'] as String?,
        city: json['city'] as String,
        state: json['state'] as String,
        country: json['country'] as String,
        postalCode: json['postalCode'] as String,
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'number': number,
        'additionalInfo': additionalInfo,
        'city': city,
        'state': state,
        'country': country,
        'postalCode': postalCode,
      };
}
