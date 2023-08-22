part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoadingState extends HomeState {}
class HomeErrorState extends HomeState {
  final String error;

  HomeErrorState(this.error);
}

class CollectionListLoadedState extends HomeState {
  final CollectionModel collectionModel;

  CollectionListLoadedState(this.collectionModel);
}
