import 'entities/product_entity.dart';

abstract class ProductRepository {
  Future<ProductEntity> addProduct(Map<String, dynamic> data);
  Future<ProductEntity> updateProduct(int id, Map<String, dynamic> data);
  Future<ProductEntity> deleteProduct(int id);
}
