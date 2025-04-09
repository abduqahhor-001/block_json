import '../entities/product_entity.dart';
import '../../data/datasources/product_remote_data_source.dart';

class GetAllProductsUseCase {
  final ProductRemoteDataSource dataSource;

  GetAllProductsUseCase(this.dataSource);

  Future<List<ProductEntity>> call() async {
    final models = await dataSource.getAllProducts();
    return models.map((model) => model.toEntity()).toList();
  }
}
