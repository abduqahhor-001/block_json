import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/models/product_model.dart';

class ProductInfoCard extends StatelessWidget {
  final ProductModel product;
  final bool isLoading;

  const ProductInfoCard({super.key, required this.product, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _shimmerPlaceholder();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.4),
        ),
        const SizedBox(height: 20),

      ],
    );
  }

  Widget _infoBox(BuildContext context, IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          3,
              (index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: double.infinity,
            height: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
