class Appointment {
  int appointmentId;
  int serviceId;
  int clientProfileId;
  int establishmentProfileId;
  int appointmentStatusId;
  DateTime start;
  DateTime end;
  DateTime creationDate;
  DateTime? lastUpdateDate;

  Appointment({
    required this.appointmentId,
    required this.serviceId,
    required this.clientProfileId,
    required this.establishmentProfileId,
    required this.appointmentStatusId,
    required this.start,
    required this.end,
    required this.creationDate,
    this.lastUpdateDate,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        appointmentId: json['appointmentId'] as int,
        serviceId: json['serviceId'] as int,
        clientProfileId: json['clientProfileId'] as int,
        establishmentProfileId: json['establishmentProfileId'] as int,
        appointmentStatusId: json['appointmentStatusId'] as int,
        start: DateTime.parse(json['start'] as String),
        end: DateTime.parse(json['end'] as String),
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: json['lastUpdateDate'] == null
            ? null
            : DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'appointmentId': appointmentId,
        'serviceId': serviceId,
        'clientProfileId': clientProfileId,
        'establishmentProfileId': establishmentProfileId,
        'appointmentStatusId': appointmentStatusId,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate?.toIso8601String(),
      };
}
