// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      arabic_name: json['arabic_name'] as String?,
      description: json['description'] as String?,
      arabic_description: json['arabic_description'] as String?,
      category_id: json['category_id'] as String?,
      crawler_id: json['crawler_id'] as int?,
      pictures: json['pictures'] as String?,
      corresponding_url: json['corresponding_url'] as String?,
      is_from_bc: json['is_from_bc'] as bool?,
      created_at: json['created_at'] as String?,
      modified_at: json['modified_at'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      attributes: (json['attributes'] as List<dynamic>?)
          ?.map(Attribute.fromJson)
          .toList(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'arabic_name': instance.arabic_name,
      'description': instance.description,
      'arabic_description': instance.arabic_description,
      'category_id': instance.category_id,
      'crawler_id': instance.crawler_id,
      'pictures': instance.pictures,
      'corresponding_url': instance.corresponding_url,
      'is_from_bc': instance.is_from_bc,
      'created_at': instance.created_at,
      'modified_at': instance.modified_at,
      'category': instance.category,
      'attributes': instance.attributes,
    };
