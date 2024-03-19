// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Product _$ProductFromJson(Map<String, dynamic> json) {
  return _Product.fromJson(json);
}

/// @nodoc
mixin _$Product {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get arabic_name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get arabic_description => throw _privateConstructorUsedError;
  String? get category_id => throw _privateConstructorUsedError;
  int? get crawler_id => throw _privateConstructorUsedError;
  String? get pictures => throw _privateConstructorUsedError;
  String? get corresponding_url => throw _privateConstructorUsedError;
  bool? get is_from_bc => throw _privateConstructorUsedError;
  String? get created_at => throw _privateConstructorUsedError;
  String? get modified_at => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  List<Attribute>? get attributes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {int? id,
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
      List<Attribute>? attributes});

  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? arabic_name = freezed,
    Object? description = freezed,
    Object? arabic_description = freezed,
    Object? category_id = freezed,
    Object? crawler_id = freezed,
    Object? pictures = freezed,
    Object? corresponding_url = freezed,
    Object? is_from_bc = freezed,
    Object? created_at = freezed,
    Object? modified_at = freezed,
    Object? category = freezed,
    Object? attributes = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      arabic_name: freezed == arabic_name
          ? _value.arabic_name
          : arabic_name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      arabic_description: freezed == arabic_description
          ? _value.arabic_description
          : arabic_description // ignore: cast_nullable_to_non_nullable
              as String?,
      category_id: freezed == category_id
          ? _value.category_id
          : category_id // ignore: cast_nullable_to_non_nullable
              as String?,
      crawler_id: freezed == crawler_id
          ? _value.crawler_id
          : crawler_id // ignore: cast_nullable_to_non_nullable
              as int?,
      pictures: freezed == pictures
          ? _value.pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as String?,
      corresponding_url: freezed == corresponding_url
          ? _value.corresponding_url
          : corresponding_url // ignore: cast_nullable_to_non_nullable
              as String?,
      is_from_bc: freezed == is_from_bc
          ? _value.is_from_bc
          : is_from_bc // ignore: cast_nullable_to_non_nullable
              as bool?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      modified_at: freezed == modified_at
          ? _value.modified_at
          : modified_at // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      attributes: freezed == attributes
          ? _value.attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<Attribute>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProductImplCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$ProductImplCopyWith(
          _$ProductImpl value, $Res Function(_$ProductImpl) then) =
      __$$ProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      List<Attribute>? attributes});

  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$ProductImplCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$ProductImpl>
    implements _$$ProductImplCopyWith<$Res> {
  __$$ProductImplCopyWithImpl(
      _$ProductImpl _value, $Res Function(_$ProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? arabic_name = freezed,
    Object? description = freezed,
    Object? arabic_description = freezed,
    Object? category_id = freezed,
    Object? crawler_id = freezed,
    Object? pictures = freezed,
    Object? corresponding_url = freezed,
    Object? is_from_bc = freezed,
    Object? created_at = freezed,
    Object? modified_at = freezed,
    Object? category = freezed,
    Object? attributes = freezed,
  }) {
    return _then(_$ProductImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      arabic_name: freezed == arabic_name
          ? _value.arabic_name
          : arabic_name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      arabic_description: freezed == arabic_description
          ? _value.arabic_description
          : arabic_description // ignore: cast_nullable_to_non_nullable
              as String?,
      category_id: freezed == category_id
          ? _value.category_id
          : category_id // ignore: cast_nullable_to_non_nullable
              as String?,
      crawler_id: freezed == crawler_id
          ? _value.crawler_id
          : crawler_id // ignore: cast_nullable_to_non_nullable
              as int?,
      pictures: freezed == pictures
          ? _value.pictures
          : pictures // ignore: cast_nullable_to_non_nullable
              as String?,
      corresponding_url: freezed == corresponding_url
          ? _value.corresponding_url
          : corresponding_url // ignore: cast_nullable_to_non_nullable
              as String?,
      is_from_bc: freezed == is_from_bc
          ? _value.is_from_bc
          : is_from_bc // ignore: cast_nullable_to_non_nullable
              as bool?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as String?,
      modified_at: freezed == modified_at
          ? _value.modified_at
          : modified_at // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      attributes: freezed == attributes
          ? _value._attributes
          : attributes // ignore: cast_nullable_to_non_nullable
              as List<Attribute>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductImpl implements _Product {
  const _$ProductImpl(
      {this.id,
      this.name,
      this.arabic_name,
      this.description,
      this.arabic_description,
      this.category_id,
      this.crawler_id,
      this.pictures,
      this.corresponding_url,
      this.is_from_bc,
      this.created_at,
      this.modified_at,
      this.category,
      final List<Attribute>? attributes})
      : _attributes = attributes;

  factory _$ProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? arabic_name;
  @override
  final String? description;
  @override
  final String? arabic_description;
  @override
  final String? category_id;
  @override
  final int? crawler_id;
  @override
  final String? pictures;
  @override
  final String? corresponding_url;
  @override
  final bool? is_from_bc;
  @override
  final String? created_at;
  @override
  final String? modified_at;
  @override
  final Category? category;
  final List<Attribute>? _attributes;
  @override
  List<Attribute>? get attributes {
    final value = _attributes;
    if (value == null) return null;
    if (_attributes is EqualUnmodifiableListView) return _attributes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, arabic_name: $arabic_name, description: $description, arabic_description: $arabic_description, category_id: $category_id, crawler_id: $crawler_id, pictures: $pictures, corresponding_url: $corresponding_url, is_from_bc: $is_from_bc, created_at: $created_at, modified_at: $modified_at, category: $category, attributes: $attributes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.arabic_name, arabic_name) ||
                other.arabic_name == arabic_name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.arabic_description, arabic_description) ||
                other.arabic_description == arabic_description) &&
            (identical(other.category_id, category_id) ||
                other.category_id == category_id) &&
            (identical(other.crawler_id, crawler_id) ||
                other.crawler_id == crawler_id) &&
            (identical(other.pictures, pictures) ||
                other.pictures == pictures) &&
            (identical(other.corresponding_url, corresponding_url) ||
                other.corresponding_url == corresponding_url) &&
            (identical(other.is_from_bc, is_from_bc) ||
                other.is_from_bc == is_from_bc) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.modified_at, modified_at) ||
                other.modified_at == modified_at) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._attributes, _attributes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      arabic_name,
      description,
      arabic_description,
      category_id,
      crawler_id,
      pictures,
      corresponding_url,
      is_from_bc,
      created_at,
      modified_at,
      category,
      const DeepCollectionEquality().hash(_attributes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      __$$ProductImplCopyWithImpl<_$ProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductImplToJson(
      this,
    );
  }
}

abstract class _Product implements Product {
  const factory _Product(
      {final int? id,
      final String? name,
      final String? arabic_name,
      final String? description,
      final String? arabic_description,
      final String? category_id,
      final int? crawler_id,
      final String? pictures,
      final String? corresponding_url,
      final bool? is_from_bc,
      final String? created_at,
      final String? modified_at,
      final Category? category,
      final List<Attribute>? attributes}) = _$ProductImpl;

  factory _Product.fromJson(Map<String, dynamic> json) = _$ProductImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get arabic_name;
  @override
  String? get description;
  @override
  String? get arabic_description;
  @override
  String? get category_id;
  @override
  int? get crawler_id;
  @override
  String? get pictures;
  @override
  String? get corresponding_url;
  @override
  bool? get is_from_bc;
  @override
  String? get created_at;
  @override
  String? get modified_at;
  @override
  Category? get category;
  @override
  List<Attribute>? get attributes;
  @override
  @JsonKey(ignore: true)
  _$$ProductImplCopyWith<_$ProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
