class Haircut {
  final int id;
  final String name;
  final String description;
  final List<HaircutImage> images;

  Haircut({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
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
