import '../entities/product_entity.dart';
import '../../data/datasources/product_remote_data_source.dart';

class GetProductDetailUseCase {
  final ProductRemoteDataSource dataSource;

  GetProductDetailUseCase(this.dataSource);

  Future<ProductEntity> call(int id) async {
    final model = await dataSource.getProductById(id);
    return ProductEntity(
      id: model.id,
      title: model.title,
      description: model.description,
      price: model.price,
      thumbnail: model.thumbnail,
      category: model.category,
    );
  }
}
