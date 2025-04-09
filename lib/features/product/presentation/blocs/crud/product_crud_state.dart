part of 'product_crud_bloc.dart';

abstract class ProductCrudState extends Equatable {
  const ProductCrudState();

  @override
  List<Object?> get props => [];
}

class ProductCrudInitial extends ProductCrudState {}

class ProductCrudLoading extends ProductCrudState {}

class ProductCrudSuccess extends ProductCrudState {
  final ProductModel product;

  const ProductCrudSuccess(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductCrudFailure extends ProductCrudState {
  final String error;

  const ProductCrudFailure(this.error);

  @override
  List<Object?> get props => [error];
}
