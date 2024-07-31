import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/models/ProductsModel.dart';
import 'package:style_sensei/new_models/collection_item.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import '../../../utils/cache_manager.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(const DetailState.initial());

  Future<void> fetchCollectionDetail(CollectionRepository collectionRepository, int collectionId) async {
    final cachedCollectionDetail = await CacheManager.getCollectionDetail(collectionId);
    if (cachedCollectionDetail != null) {
      emit(DetailState.loadedDetail(cachedCollectionDetail));
      return;
    }

    emit(const DetailState.loadingDetail());
    try {
      final collectionDetail = await collectionRepository.fetchProductModel(collectionId);
      await CacheManager.saveCollectionDetail(collectionId, collectionDetail);
      emit(DetailState.loadedDetail(collectionDetail));
    } catch (error) {
      emit(DetailState.error(error.toString()));
    }
  }

  Future<void> fetchCollectionItems(CollectionRepository collectionRepository, int collectionId) async {
    final cachedItems = await CacheManager.getCollectionItems(collectionId);
    if (cachedItems != null) {
      emit(DetailState.loadedItems(cachedItems, await CacheManager.getCollectionDetail(collectionId)));
      return;
    }

    emit(const DetailState.loadingItems());
    try {
      final items = await collectionRepository.fetchCollectionItems(collectionId);
      await CacheManager.saveCollectionItems(collectionId, items);
      emit(DetailState.loadedItems(items, await CacheManager.getCollectionDetail(collectionId)));
    } catch (error) {
      emit(DetailState.error(error.toString()));
    }
  }
}
