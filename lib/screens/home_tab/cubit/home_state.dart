part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeError extends HomeState {
  final Exception error;

  HomeError(this.error);
}

class CollectionListLoaded extends HomeState {

}
