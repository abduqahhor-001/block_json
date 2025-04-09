part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {}
class LoadProductsByCategoryEvent extends ProductEvent {
  final String category;

  const LoadProductsByCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}
class SearchProductsEvent extends ProductEvent {
  final String query;

  const SearchProductsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class SortProductsEvent extends ProductEvent {
  final String sortBy;
  final String order;

  const SortProductsEvent({required this.sortBy, required this.order});
  @override
  List<Object?> get props => [sortBy, order];
}
