import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../data/models/product_model.dart';
import '../widgets/product_detail_image.dart';
import '../widgets/product_info_card.dart';
import '../widgets/product_price_tile.dart';
import '../blocs/crud/product_crud_bloc.dart';
import '../../../../core/di/service_locator.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  Future<ProductModel> fetchProduct() async {
    return await ProductRemoteDataSource().getProductById(productId);
  }

  void _showDeleteDialog(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (ctx) {
        return BlocProvider.value(
          value: sl<ProductCrudBloc>(),
          child: BlocConsumer<ProductCrudBloc, ProductCrudState>(
            listener: (context, state) {
              if (state is ProductCrudSuccess) {
                Navigator.of(ctx).pop(); // Dialogni yopish
                context.go('/product-list'); // Mahsulotlar ro‘yxatiga qaytish
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Mahsulot o‘chirildi")),
                );
              } else if (state is ProductCrudFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Xatolik: ${state.error}")),
                );
              }
            },
            builder: (context, state) {
              return AlertDialog(
                title: const Text("Diqqat!"),
                content: Text("“${product.title}” mahsulotini o‘chirmoqchimisiz?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text("Bekor qilish"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: state is ProductCrudLoading
                        ? null
                        : () {
                      context.read<ProductCrudBloc>().add(DeleteProductEvent(product.id));
                    },
                    child: state is ProductCrudLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                        : const Text("O‘chirish"),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductModel>(
      future: fetchProduct(),
      builder: (context, snapshot) {
        final isLoading = snapshot.connectionState == ConnectionState.waiting;

        final product = snapshot.data ??
            ProductModel(
              id: 0,
              title: '',
              description: '',
              price: 0.0,
              thumbnail: '',
              rating: 0,
              category: '',
              brand: '',
              images: const [],
            );

        return Scaffold(
          appBar: AppBar(
            title: Text(
              isLoading ? 'Yuklanmoqda...' : product.title,
              overflow: TextOverflow.ellipsis,
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go("/product-list"),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductDetailImage(
                    imageUrl: product.thumbnail,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 16),
                  ProductPriceTile(
                    price: product.price,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 16),
                  ProductInfoCard(
                    product: product,
                    isLoading: isLoading,
                  ),
                  const SizedBox(height: 24),
                  if (!isLoading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        ElevatedButton.icon(
                          onPressed: () {

                            context.go(
                              '/update-product',
                              extra: {'product': product},
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Update'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),

                        ElevatedButton.icon(
                          onPressed: () => _showDeleteDialog(context, product),
                          icon: const Icon(Icons.delete),
                          label: const Text('O‘chirish'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
