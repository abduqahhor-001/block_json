import '../entities/product_entity.dart';
import '../product_repository.dart';

class AddProductUseCase {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  Future<ProductEntity> call(Map<String, dynamic> data) {
    return repository.addProduct(data);
  }
}
