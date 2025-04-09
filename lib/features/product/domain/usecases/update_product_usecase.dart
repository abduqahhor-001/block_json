import '../entities/product_entity.dart';
import '../product_repository.dart';

class UpdateProductUseCase {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  Future<ProductEntity> call(int id, Map<String, dynamic> data) {
    return repository.updateProduct(id, data);
  }
}
