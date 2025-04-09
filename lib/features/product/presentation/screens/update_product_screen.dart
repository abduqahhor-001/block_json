import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/product_model.dart';
import '../blocs/crud/product_crud_bloc.dart';
import '../../../../core/di/service_locator.dart';

class UpdateProductPage extends StatelessWidget {
  final ProductModel product;

  const UpdateProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductCrudBloc>(),
      child: _UpdateProductView(product: product),
    );
  }
}

class _UpdateProductView extends StatefulWidget {
  final ProductModel product;

  const _UpdateProductView({required this.product});

  @override
  State<_UpdateProductView> createState() => _UpdateProductViewState();
}

class _UpdateProductViewState extends State<_UpdateProductView> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product.title);
    descriptionController = TextEditingController(text: widget.product.description);
    priceController = TextEditingController(text: widget.product.price.toString());
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _updateProduct() {
    context.read<ProductCrudBloc>().add(
      UpdateProductEvent(
        id: widget.product.id,
        data: {
          'title': titleController.text,
          'description': descriptionController.text,
          'price': double.tryParse(priceController.text) ?? 0.0,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/product-list'),
          ),
          title: const Text("Update Product")),
      body: BlocConsumer<ProductCrudBloc, ProductCrudState>(
        listener: (context, state) {
          if (state is ProductCrudSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("updated successfully")),
            );

            if (context.canPop()) context.pop();
          } else if (state is ProductCrudFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(controller: titleController, decoration: const InputDecoration(labelText: "Title")),
                TextField(controller: descriptionController, decoration: const InputDecoration(labelText: "Description")),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is ProductCrudLoading ? null : _updateProduct,
                  child: state is ProductCrudLoading
                      ? const CircularProgressIndicator()
                      : const Text("Update "),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
