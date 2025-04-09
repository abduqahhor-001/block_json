import '../../domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String thumbnail;
  final double rating;
  final String category;
  final String brand;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.rating,
    required this.category,
    required this.brand,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No title',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      thumbnail: json['thumbnail'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      category: json['category'] ?? 'Unknown',
      brand: json['brand'] ?? 'Unknown',
      images: (json['images'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail,
      category: category,
    );
  }
}
