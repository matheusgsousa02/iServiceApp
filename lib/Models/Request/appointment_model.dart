class AppointmentModel {
  int serviceId;
  int clientProfileId;
  int establishmentProfileId;
  int appointmentStatusId;
  DateTime start;
  DateTime end;

  AppointmentModel({
    required this.serviceId,
    required this.clientProfileId,
    required this.establishmentProfileId,
    required this.appointmentStatusId,
    required this.start,
    required this.end,
  });

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'clientProfileId': clientProfileId,
        'establishmentProfileId': establishmentProfileId,
        'appointmentStatusId': appointmentStatusId,
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
      };
}
