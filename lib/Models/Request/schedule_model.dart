class ScheduleModel {
  int establishmentProfileId;
  String days;
  String start;
  String end;
  String? breakStart;
  String? breakEnd;

  ScheduleModel({
    required this.establishmentProfileId,
    required this.days,
    required this.start,
    required this.end,
    this.breakStart,
    this.breakEnd,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        establishmentProfileId: json['establishmentProfileId'] as int,
        days: json['days'] as String,
        start: json['start'] as String,
        end: json['end'] as String,
        breakStart: json['breakStart'] as String?,
        breakEnd: json['breakEnd'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'establishmentProfileId': establishmentProfileId,
        'days': days,
        'start': start,
        'end': end,
        'breakStart': breakStart,
        'breakEnd': breakEnd,
      };
}
