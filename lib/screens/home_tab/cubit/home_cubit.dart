import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:style_sensei/models/Collection_model.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'package:style_sensei/utils/untitled.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());


  Future<void> fetchData(CollectionRepository? collectionRepository, {List<List<int>>? tags = null}) async{
    emit(HomeLoadingState());
    List<List<int>> collectionTags = tags ?? [];
    try {
      if (collectionTags.isEmpty) {
        collectionTags = await getSelectedIds();
      }
      collectionTags.removeWhere((tags) => tags.isEmpty);
      emit(SelectedTagLoadedState(collectionTags));
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
