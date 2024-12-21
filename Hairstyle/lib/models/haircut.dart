class Haircut {
  final int id;
  final String name;
  final String description;
  final List<HaircutImage> images;
  final String? faceShape; // Kolom tambahan
  final String? faceShape2; // Kolom tambahan
  final String? faceShape3; // Kolom tambahan

  Haircut({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    this.faceShape, // Kolom tambahan
    this.faceShape2, // Kolom tambahan
    this.faceShape3, // Kolom tambahan
  });

  factory Haircut.fromJson(Map<String, dynamic> json) {
    var imagesList = (json['images'] as List)
        .map((imageData) => HaircutImage.fromJson(imageData))
        .toList();

    return Haircut(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: imagesList,
      faceShape: json['face_shape'], // Kolom tambahan
      faceShape2: json['face_shape2'], // Kolom tambahan
      faceShape3: json['face_shape3'], // Kolom tambahan
    );
  }
}

class HaircutImage {
  final int id;
  final String imageUrl;

  HaircutImage({required this.id, required this.imageUrl});

  factory HaircutImage.fromJson(Map<String, dynamic> json) {
    return HaircutImage(
      id: json['id'] ?? 0,
      imageUrl: json['image_url'] ?? '',
    );
  }
}
