// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CollectionItemImpl _$$CollectionItemImplFromJson(Map<String, dynamic> json) =>
    _$CollectionItemImpl(
      category_id: json['category_id'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CollectionItemImplToJson(
        _$CollectionItemImpl instance) =>
    <String, dynamic>{
      'category_id': instance.category_id,
      'category': instance.category,
      'products': instance.products,
    };
