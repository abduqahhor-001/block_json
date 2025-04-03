import '../entities/product_entity.dart';
import '../../data/datasources/product_remote_data_source.dart';

class GetAllProductsUseCase {
  final ProductRemoteDataSource dataSource;

  GetAllProductsUseCase(this.dataSource);

  Future<List<ProductEntity>> call() async {
    final products = await dataSource.getAllProducts();
    return products.map((model) =>
        ProductEntity(
          id: model.id,
          title: model.title,
          description: model.description,
          price: model.price,
          thumbnail: model.thumbnail, category: '',
        )).toList();
  }
  }
