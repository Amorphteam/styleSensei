import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:style_sensei/models/ProductsModel.dart';
import 'package:style_sensei/new_models/collection_item.dart';

part 'detail_state.freezed.dart';

@freezed
abstract class DetailState with _$DetailState {
  const factory DetailState.initial() = _Initial;
  const factory DetailState.loadingDetail() = _LoadingDetail;
  const factory DetailState.loadingItems() = _LoadingItems;
  const factory DetailState.loadedDetail(ProductsModel collectionDetail) = _LoadedDetail;
  const factory DetailState.loadedItems(List<CollectionItem> items) = _LoadedItems;
  const factory DetailState.error(String message) = _Error;
}
