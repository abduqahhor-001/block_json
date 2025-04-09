import '../../domain/entities/product_entity.dart';
import '../../domain/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<ProductEntity> addProduct(Map<String, dynamic> data) async {
    final model = await remoteDataSource.addProduct(data);
    return model.toEntity();
  }

  @override
  Future<ProductEntity> updateProduct(int id, Map<String, dynamic> data) async {
    final model = await remoteDataSource.updateProduct(id, data);
    return model.toEntity();
  }

  @override
  Future<ProductEntity> deleteProduct(int id) async {
    final model = await remoteDataSource.deleteProduct(id);
    return model.toEntity();
  }
}
