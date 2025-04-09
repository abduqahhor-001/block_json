import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'product_image_preview.dart';

class ProductDetailImage extends StatelessWidget {
  final String imageUrl;
  final bool isLoading;

  const ProductDetailImage({
    super.key,
    required this.imageUrl,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: isLoading
          ? Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          color: Colors.white,
          width: double.infinity,
        ),
      )
          : GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (_) => ProductImagePreview(imageUrl: imageUrl),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.broken_image),
            ),
          ),
        ),
      ),
    );
  }
}
