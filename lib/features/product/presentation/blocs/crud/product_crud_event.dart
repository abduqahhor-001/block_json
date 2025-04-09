part of 'product_crud_bloc.dart';

abstract class ProductCrudEvent extends Equatable {
  const ProductCrudEvent();

  @override
  List<Object?> get props => [];
}

class AddProductEvent extends ProductCrudEvent {
  final Map<String, dynamic> data;

  const AddProductEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateProductEvent extends ProductCrudEvent {
  final int id;
  final Map<String, dynamic> data;

  const UpdateProductEvent({required this.id, required this.data});

  @override
  List<Object?> get props => [id, data];
}

class DeleteProductEvent extends ProductCrudEvent {
  final int id;

  const DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}
