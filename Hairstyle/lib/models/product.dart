class Product {
  final int id;
  final String name;
  final String description;
  final String? tipeRambut1;
  final String? tipeRambut2;
  final String? tipeRambut3;
  final List<Image> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.tipeRambut1,
    this.tipeRambut2,
    this.tipeRambut3,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var imagesList = (json['images'] as List)
        .map((imageData) => Image.fromJson(imageData))
        .toList();

    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      tipeRambut1: json['tipe_rambut_1'],
      tipeRambut2: json['tipe_rambut_2'],
      tipeRambut3: json['tipe_rambut_3'],
      images: imagesList,
    );
  }
}

class Image {
  final int id;
  final String imageUrl;

  Image({required this.id, required this.imageUrl});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }
}
