import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/ProductsModel.dart';
import '../../../repositories/collection_repository.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());

  Future<void> fetchData(CollectionRepository? collectionRepository, int collectionId) async{
    emit(DetailLoadingState());
    try {
      final products = await collectionRepository?.fetchProductModel(collectionId);
      if (products != null) {
        emit(ProductListLoadedState(products));
      }else {
        emit(DetailErrorState("The collection is null"));
      }
    }catch(error){
      emit(DetailErrorState(error.toString()));
    }
  }
}
