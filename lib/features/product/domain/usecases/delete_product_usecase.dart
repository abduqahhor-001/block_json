import '../entities/product_entity.dart';
import '../product_repository.dart';

class DeleteProductUseCase {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  Future<ProductEntity> call(int id) {
    return repository.deleteProduct(id);
  }
}
