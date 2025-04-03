import 'package:flutter/material.dart';

class ProductImagePreview extends StatelessWidget {
  final String imageUrl;

  const ProductImagePreview({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: InteractiveViewer(
        child: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, color: Colors.white)),
        ),
      ),
    );
  }
}
