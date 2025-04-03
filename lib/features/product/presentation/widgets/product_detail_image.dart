import 'package:flutter/material.dart';
import 'product_image_preview.dart';

class ProductDetailImage extends StatelessWidget {
  final String imageUrl;

  const ProductDetailImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (_) => ProductImagePreview(imageUrl: imageUrl),
      ),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
