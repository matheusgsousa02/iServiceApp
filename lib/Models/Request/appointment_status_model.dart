class AppointmentStatusModel {
  String name;

  AppointmentStatusModel({required this.name});

  factory AppointmentStatusModel.fromJson(Map<String, dynamic> json) =>
      AppointmentStatusModel(
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}
