class ImageModel {
  int id;
  String? imagePath; // Para armazenar o caminho do arquivo da imagem
  List<int>?
      photo; // Para armazenar dados binários da foto (equivalente a byte[])

  ImageModel({
    required this.id,
    this.imagePath,
    this.photo,
  });

  // Método para converter o modelo em um mapa, útil para enviar dados via API
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      if (imagePath != null) 'Image': imagePath,
      if (photo != null) 'Photo': photo,
    };
  }

  // Método para criar uma instância da classe a partir de um mapa
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['Id'],
      imagePath: json['Image'],
      photo: json['Photo'] != null ? List<int>.from(json['Photo']) : null,
    );
  }
}
