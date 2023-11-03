part of 'detail_cubit.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}
class DetailLoadingState extends DetailState {}
class DetailErrorState extends DetailState {
  final String error;

  DetailErrorState(this.error);
}

class ProductListLoadedState extends DetailState {
  final ProductsModel productModel;

  ProductListLoadedState(this.productModel);
}
