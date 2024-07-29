import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:style_sensei/models/ProductsModel.dart';
import 'package:style_sensei/new_models/collection_item.dart';
import 'package:style_sensei/repositories/collection_repository.dart';
import 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(const DetailState.initial());

  ProductsModel? _cachedCollectionDetail;
  List<CollectionItem>? _cachedItems;

  Future<void> fetchCollectionDetail(CollectionRepository collectionRepository, int collectionId) async {
    if (_cachedCollectionDetail != null) {
      emit(DetailState.loadedDetail(_cachedCollectionDetail!));
      return;
    }

    emit(const DetailState.loadingDetail());
    try {
      final collectionDetail = await collectionRepository.fetchProductModel(collectionId);
      _cachedCollectionDetail = collectionDetail;
      emit(DetailState.loadedDetail(collectionDetail));
    } catch (error) {
      emit(DetailState.error(error.toString()));
    }
  }

  Future<void> fetchCollectionItems(CollectionRepository collectionRepository, int collectionId) async {
    if (_cachedItems != null) {
      emit(DetailState.loadedItems(_cachedItems!, _cachedCollectionDetail));
      return;
    }

    emit(const DetailState.loadingItems());
    try {
      final items = await collectionRepository.fetchCollectionItems(collectionId);
      _cachedItems = items;
      emit(DetailState.loadedItems(items, _cachedCollectionDetail));
    } catch (error) {
      emit(DetailState.error(error.toString()));
    }
  }
}
