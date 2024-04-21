class FeedbackModel {
  int appointmentId;
  String description;
  int rating;

  FeedbackModel({
    required this.appointmentId,
    required this.description,
    required this.rating,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        appointmentId: json['appointmentId'] as int,
        description: json['description'] as String,
        rating: json['rating'] as int,
      );

  Map<String, dynamic> toJson() => {
        'appointmentId': appointmentId,
        'description': description,
        'rating': rating,
      };
}
