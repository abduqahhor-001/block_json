import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/models/product_model.dart';
import '../widgets/product_detail_image.dart';
import '../widgets/product_info_card.dart';
import '../widgets/product_price_tile.dart';
import '../widgets/product_gallery.dart';
import '../widgets/product_action_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  Future<ProductModel> fetchProduct() async {
    return await ProductRemoteDataSource().getProductById(productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductModel>(
      future: fetchProduct(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mahsulot Tafsilotlari'),

            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Mahsulot Tafsilotlari'),
            ),
            body: Center(
              child: Text(
                'Xatolik: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          );
        }

        final product = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.go("/"),
            ),
            backgroundColor: Colors.deepPurple,
            elevation: 4,
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductDetailImage(imageUrl: product.thumbnail),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductPriceTile(price: product.price),
                      const SizedBox(height: 16),
                      ProductInfoCard(product: product),
                      const SizedBox(height: 24),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}