import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:style_sensei/models/Products.dart';
import 'package:style_sensei/models/ProtuctsTemp.dart';

import '../../../models/ProductsModel.dart';
import '../../../repositories/collection_repository.dart';

part 'saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  SavedCubit() : super(SavedInitial());

  Future<void> fetchData(CollectionRepository? collectionRepository, List<int> bookmarkIds) async{
    emit(SavedLoadingState());
    try {
      final products = await collectionRepository?.fetchProductModelByIds(bookmarkIds);
      if (products != null) {
        emit(ProductListLoadedState(products));
      }else {
        emit(SavedErrorState("The collection is null"));
      }
    }catch(error){
      emit(SavedErrorState(error.toString()));
    }
  }
}
