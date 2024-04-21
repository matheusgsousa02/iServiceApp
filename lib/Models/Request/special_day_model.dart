class SpecialDayModel {
  int establishmentProfileId;
  DateTime date;
  String? start;
  String? end;
  String? breakStart;
  String? breakEnd;

  SpecialDayModel({
    required this.establishmentProfileId,
    required this.date,
    this.start,
    this.end,
    this.breakStart,
    this.breakEnd,
  });

  factory SpecialDayModel.fromJson(Map<String, dynamic> json) =>
      SpecialDayModel(
        establishmentProfileId: json['establishmentProfileId'] as int,
        date: DateTime.parse(json['date'] as String),
        start: json['start'] as String?,
        end: json['end'] as String?,
        breakStart: json['breakStart'] as String?,
        breakEnd: json['breakEnd'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'establishmentProfileId': establishmentProfileId,
        'date': date.toIso8601String(),
        'start': start,
        'end': end,
        'breakStart': breakStart,
        'breakEnd': breakEnd,
      };
}
