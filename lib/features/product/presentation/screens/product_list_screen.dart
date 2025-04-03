import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product_bloc.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../widgets/product_card.dart';
import '../widgets/search_sort_bar.dart';
import '../widgets/shimmer_loader.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        getAllProductsUseCase: GetAllProductsUseCase(ProductRemoteDataSource()),
        dataSource: ProductRemoteDataSource(),
      )..add(LoadProductsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Products'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SearchSortBar(),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const ShimmerLoader();
                    }
                    if (state is ProductLoaded) {
                      return state.products.isEmpty
                          ? const Center(child: Text("Bu kategoriya bo'yicha mahsulot topilmadi."))
                          : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) => ProductCard(product: state.products[index]),
                      );
                    }
                    if (state is ProductError) {
                      return Center(child: Text("Xatolik yuz berdi: ${state.message}"));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}