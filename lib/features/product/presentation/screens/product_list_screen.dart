import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/service_locator.dart';
import '../blocs/product_bloc.dart';
import '../widgets/product_card.dart';
import '../widgets/search_sort_bar.dart';
import '../widgets/shimmer_loader.dart';
import '../widgets/category_filter_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductBloc>()..add(LoadProductsEvent()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text('all Products'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
          surfaceTintColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const SearchSortBar(),
              const SizedBox(height: 12),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const ShimmerLoader();
                    }

                    if (state is ProductLoaded) {
                      final products = state.products;

                      if (products.isEmpty) {
                        return const Center(
                          child: Text(
                            "😕 No products found in this category.",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      }

                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: products.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductCard(product: product);
                        },
                      );
                    }

                    if (state is ProductError) {
                      return Center(
                        child: Text(
                          "🚫 ${state.message}",
                          style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.go("/add-product"),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
