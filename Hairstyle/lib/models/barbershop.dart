class Barbershop {
  final int id;
  final String name;
  final String location;
  final String? contactInfo;
  final double rating;
  final List<BarbershopImage> images;
  final String? rangeHarga; // Menambahkan rangeHarga sebagai nullable String
  final String description; // Menambahkan rangeHarga sebagai nullable String

  Barbershop({
    required this.id,
    required this.name,
    required this.location,
    this.contactInfo,
    required this.rating,
    required this.images,
    this.rangeHarga, // Tambahkan rangeHarga ke dalam konstruktor
    required this.description, // Tambahkan rangeHarga ke dalam konstruktor
  });

  factory Barbershop.fromJson(Map<String, dynamic> json) {
    // Mengonversi daftar gambar dari JSON
    var imagesList = (json['images'] as List)
        .map((imageData) => BarbershopImage.fromJson(imageData))
        .toList();

    return Barbershop(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      contactInfo: json['contact_info'],
      rating: (json['rating'] as num).toDouble(),
      images: imagesList,
      rangeHarga: json['range_harga'], // Mengambil range_harga dari JSON
      description: json['description'], // Mengambil range_harga dari JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'contact_info': contactInfo,
      'rating': rating,
      'images': images.map((image) => image.toJson()).toList(),
      'range_harga': rangeHarga, // Menambahkan range_harga ke JSON
      'description': description, // Menambahkan range_harga ke JSON
    };
  }
}

class BarbershopImage {
  final int id;
  final String imageUrl;

  BarbershopImage({required this.id, required this.imageUrl});

  factory BarbershopImage.fromJson(Map<String, dynamic> json) {
    return BarbershopImage(
      id: json['id'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
    };
  }
}
