import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:style_sensei/new_models/product.dart';

import 'category.dart';

part 'collection_item.freezed.dart';
part 'collection_item.g.dart';

@freezed
class CollectionItem with _$CollectionItem {
  const factory CollectionItem({
    String? category_id,
    Category? category,
    List<Product>? products,
  }) = _CollectionItem;

  factory CollectionItem.fromJson(Map<String, dynamic> json) => _$CollectionItemFromJson(json);
}
