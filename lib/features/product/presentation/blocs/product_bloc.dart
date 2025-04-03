import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/datasources/product_remote_data_source.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_all_products_usecase.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProductsUseCase getAllProductsUseCase;
  final ProductRemoteDataSource dataSource;

  ProductBloc({
    required this.getAllProductsUseCase,
    required this.dataSource,
  }) : super(ProductInitial()) {
    // state cache
    List<ProductEntity> _currentProducts = [];

    // 🔄 Load All Products
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getAllProductsUseCase();
        _currentProducts = products;
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError("Failed to load products: ${e.toString()}"));
      }
    });

    // 📦 Load By Category
    on<LoadProductsByCategoryEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final models = await dataSource.getProductsByCategory(event.category);
        final products = models.map((model) =>
            ProductEntity(
              id: model.id,
              title: model.title,
              description: model.description,
              price: model.price,
              thumbnail: model.thumbnail,
              category: model.category,
            )).toList();
        _currentProducts = products;
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError("Category load error: ${e.toString()}"));
      }
    });

    // 🔍 Search
    on<SearchProductsEvent>((event, emit) {
      final filtered = _currentProducts.where((product) =>
          product.title.toLowerCase().contains(event.query.toLowerCase())
      ).toList();
      emit(ProductLoaded(filtered));
    });

    on<SortProductsEvent>((event, emit) {
      final sorted = [..._currentProducts];
      if (event.sortBy == "price") {
        sorted.sort((a, b) =>
        event.order == "asc"
            ? a.price.compareTo(b.price)
            : b.price.compareTo(a.price));
      } else {
        sorted.sort((a, b) =>
        event.order == "asc"
            ? a.title.compareTo(b.title)
            : b.title.compareTo(a.title));
      }
      emit(ProductLoaded(sorted));
    });
  }
  }
