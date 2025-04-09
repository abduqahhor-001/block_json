import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/service_locator.dart';
import '../../features/product/presentation/blocs/product_bloc.dart';
import '../../features/product/presentation/screens/add_product_screen.dart';
import '../../features/product/presentation/screens/update_product_screen.dart';
import '../../features/product/presentation/screens/product_detail_screen.dart';
import '../../features/product/presentation/screens/product_list_screen.dart';
import '../root/root_navbar.dart';

final GoRouter router = GoRouter(
  initialLocation: '/product-list',
  routes: [

    GoRoute(
      path: '/add-product',
      builder: (context, state) => const AddProductScreen(),
    ),
    GoRoute(
      path: '/update-product',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return UpdateProductPage(product: extra['product']);
      },
    ),

    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return ProductDetailScreen(productId: id);
      },
    ),
    GoRoute(
      path: '/product-list',
      builder: (context, state) => const ProductListScreen(),
    ),
  ],
);
