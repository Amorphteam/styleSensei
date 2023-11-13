part of 'saved_cubit.dart';

@immutable
abstract class SavedState {}

class SavedInitial extends SavedState {}
class SavedLoadingState extends SavedState {}
class SavedErrorState extends SavedState {
  final String error;

  SavedErrorState(this.error);
}

class ProductListLoadedState extends SavedState {
  final ProductsTemp? products;

  ProductListLoadedState(this.products);
}
