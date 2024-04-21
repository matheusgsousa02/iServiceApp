import 'dart:typed_data'; // Necessary for using Uint8List

class ImageModel {
  int id;
  Uint8List photo;

  ImageModel({
    required this.id,
    required this.photo,
  });

  // Method to convert from JSON map to ImageModel instance
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'] as int,
      photo: Uint8List.fromList(List<int>.from(json['photo'])),
    );
  }

  // Method to convert ImageModel instance to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photo': photo.toList(),
    };
  }
}
