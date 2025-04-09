import 'package:flutter/material.dart';

class ProductPriceTile extends StatelessWidget {
  final double price;

  const ProductPriceTile({super.key, required this.price, required bool isLoading});

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${price.toStringAsFixed(2)}',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
