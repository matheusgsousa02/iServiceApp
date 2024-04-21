class AppointmentStatus {
  int appointmentStatusId;
  String name;
  DateTime creationDate;
  DateTime lastUpdateDate;

  AppointmentStatus({
    required this.appointmentStatusId,
    required this.name,
    required this.creationDate,
    required this.lastUpdateDate,
  });

  factory AppointmentStatus.fromJson(Map<String, dynamic> json) =>
      AppointmentStatus(
        appointmentStatusId: json['appointmentStatusId'] as int,
        name: json['name'] as String,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'appointmentStatusId': appointmentStatusId,
        'name': name,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate.toIso8601String(),
      };
}
