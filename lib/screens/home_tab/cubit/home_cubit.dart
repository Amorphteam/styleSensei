import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:style_sensei/models/Collection_model.dart';
import 'package:style_sensei/repositories/collection_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  Future<void> fetchData(CollectionRepository? collectionRepository, List<int> collectionTags) async{
    emit(HomeLoadingState());
    try {
      final collection = await collectionRepository?.fetchCollectionModel(collectionTags);
      if (collection != null) {
        emit(CollectionListLoadedState(collection));
      }else {
        emit(HomeErrorState("The collection is null"));
      }
    }catch(error){
      emit(HomeErrorState(error.toString()));
    }
  }
}
