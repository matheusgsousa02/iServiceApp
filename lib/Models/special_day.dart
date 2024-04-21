class SpecialDay {
  int specialDayId;
  int establishmentProfileId;
  DateTime date;
  String? start;
  String? end;
  String? breakStart;
  String? breakEnd;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  SpecialDay({
    required this.specialDayId,
    required this.establishmentProfileId,
    required this.date,
    this.start,
    this.end,
    this.breakStart,
    this.breakEnd,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory SpecialDay.fromJson(Map<String, dynamic> json) => SpecialDay(
        specialDayId: json['specialDayId'] as int,
        establishmentProfileId: json['establishmentProfileId'] as int,
        date: DateTime.parse(json['date'] as String),
        start: json['start'] as String?,
        end: json['end'] as String?,
        breakStart: json['breakStart'] as String?,
        breakEnd: json['breakEnd'] as String?,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'specialDayId': specialDayId,
        'establishmentProfileId': establishmentProfileId,
        'date': date.toIso8601String(),
        'start': start,
        'end': end,
        'breakStart': breakStart,
        'breakEnd': breakEnd,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
