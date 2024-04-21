class Schedule {
  int scheduleId;
  int establishmentProfileId;
  String days;
  String start;
  String end;
  String? breakStart;
  String? breakEnd;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  Schedule({
    required this.scheduleId,
    required this.establishmentProfileId,
    required this.days,
    required this.start,
    required this.end,
    this.breakStart,
    this.breakEnd,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        scheduleId: json['scheduleId'] as int,
        establishmentProfileId: json['establishmentProfileId'] as int,
        days: json['days'] as String,
        start: json['start'] as String,
        end: json['end'] as String,
        breakStart: json['breakStart'] as String?,
        breakEnd: json['breakEnd'] as String?,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'scheduleId': scheduleId,
        'establishmentProfileId': establishmentProfileId,
        'days': days,
        'start': start,
        'end': end,
        'breakStart': breakStart,
        'breakEnd': breakEnd,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
