import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/ProductsModel.dart';
import '../../../new_models/collection_item.dart';
import '../../../repositories/collection_repository.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());

  Future<void> fetchData(CollectionRepository? collectionRepository, int collectionId) async{
    emit(DetailLoadingState());
    try {
      final items = await collectionRepository?.fetchCollectionItems(collectionId);
      final collectionDetail = await collectionRepository?.fetchProductModel(collectionId);
      if (items != null) {
        emit(ProductListLoadedState(items, collectionDetail));
      }else {
        emit(DetailErrorState("The collection is null"));
      }
    }catch(error){
      emit(DetailErrorState(error.toString()));
    }
  }
}
