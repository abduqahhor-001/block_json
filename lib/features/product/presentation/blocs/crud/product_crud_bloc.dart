import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/datasources/product_remote_data_source.dart';
import '../../../data/models/product_model.dart';

part 'product_crud_event.dart';
part 'product_crud_state.dart';

class ProductCrudBloc extends Bloc<ProductCrudEvent, ProductCrudState> {
  final ProductRemoteDataSource remoteDataSource;

  ProductCrudBloc({required this.remoteDataSource}) : super(ProductCrudInitial()) {
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductCrudState> emit) async {
    emit(ProductCrudLoading());
    try {
      final product = await remoteDataSource.addProduct(event.data);
      emit(ProductCrudSuccess(product));
    } catch (e) {
      emit(ProductCrudFailure("Failed to add product: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductCrudState> emit) async {
    emit(ProductCrudLoading());
    try {
      final product = await remoteDataSource.updateProduct(event.id, event.data);
      emit(ProductCrudSuccess(product));
    } catch (e) {
      emit(ProductCrudFailure("Failed to update product: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductCrudState> emit) async {
    emit(ProductCrudLoading());
    try {
      final product = await remoteDataSource.deleteProduct(event.id);
      if (product.title.isNotEmpty) {
        emit(ProductCrudSuccess(product));
      } else {
        emit(ProductCrudFailure("Delete failed"));
      }
    } catch (e) {
      emit(ProductCrudFailure("Failed to delete product: ${e.toString()}"));
    }
  }
}
