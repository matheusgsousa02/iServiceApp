class Feedback {
  int feedbackId;
  int appointmentId;
  String description;
  int rating;
  DateTime creationDate;
  DateTime lastUpdateDate;

  Feedback({
    required this.feedbackId,
    required this.appointmentId,
    required this.description,
    required this.rating,
    required this.creationDate,
    required this.lastUpdateDate,
  });

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        feedbackId: json['feedbackId'] as int,
        appointmentId: json['appointmentId'] as int,
        description: json['description'] as String,
        rating: json['rating'] as int,
        creationDate: DateTime.parse(json['creationDate'] as String),
        lastUpdateDate: DateTime.parse(json['lastUpdateDate'] as String),
      );

  Map<String, dynamic> toJson() => {
        'feedbackId': feedbackId,
        'appointmentId': appointmentId,
        'description': description,
        'rating': rating,
        'creationDate': creationDate.toIso8601String(),
        'lastUpdateDate': lastUpdateDate.toIso8601String(),
      };
}
