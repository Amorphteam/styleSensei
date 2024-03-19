import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/Attribute.dart';
import 'category.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    int? id,
    String? name,
    String? arabic_name,
    String? description,
    String? arabic_description,
    String? category_id,
    int? crawler_id,
    String? pictures,
    String? corresponding_url,
    bool? is_from_bc,
    String? created_at,
    String? modified_at,
    Category? category,
    List<Attribute>? attributes,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
