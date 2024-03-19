// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttributeImpl _$$AttributeImplFromJson(Map<String, dynamic> json) =>
    _$AttributeImpl(
      product_id: json['product_id'] as int?,
      attribute_id: json['attribute_id'] as int?,
      value: json['value'] as String?,
      attribute: json['attribute'] == null
          ? null
          : AttributeDetail.fromJson(json['attribute'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AttributeImplToJson(_$AttributeImpl instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'attribute_id': instance.attribute_id,
      'value': instance.value,
      'attribute': instance.attribute,
    };

_$AttributeDetailImpl _$$AttributeDetailImplFromJson(
        Map<String, dynamic> json) =>
    _$AttributeDetailImpl(
      name: json['name'] as String?,
      admin_name: json['admin_name'] as String?,
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$$AttributeDetailImplToJson(
        _$AttributeDetailImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'admin_name': instance.admin_name,
      'image_url': instance.image_url,
    };
