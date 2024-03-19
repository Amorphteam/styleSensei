// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      parent_id: json['parent_id'] as String?,
      created_at: json['created_at'] as String?,
      modified_at: json['modified_at'] as String?,
      parent: json['parent'] == null
          ? null
          : Category.fromJson(json['parent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent_id': instance.parent_id,
      'created_at': instance.created_at,
      'modified_at': instance.modified_at,
      'parent': instance.parent,
    };
