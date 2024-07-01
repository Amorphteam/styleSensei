// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CollectionItem _$CollectionItemFromJson(Map<String, dynamic> json) {
  return _CollectionItem.fromJson(json);
}

/// @nodoc
mixin _$CollectionItem {
  String? get category_id => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  List<Product>? get products => throw _privateConstructorUsedError;
  Map<String, int>? get match_count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollectionItemCopyWith<CollectionItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionItemCopyWith<$Res> {
  factory $CollectionItemCopyWith(
          CollectionItem value, $Res Function(CollectionItem) then) =
      _$CollectionItemCopyWithImpl<$Res, CollectionItem>;
  @useResult
  $Res call(
      {String? category_id,
      Category? category,
      List<Product>? products,
      Map<String, int>? match_count});

  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$CollectionItemCopyWithImpl<$Res, $Val extends CollectionItem>
    implements $CollectionItemCopyWith<$Res> {
  _$CollectionItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category_id = freezed,
    Object? category = freezed,
    Object? products = freezed,
    Object? match_count = freezed,
  }) {
    return _then(_value.copyWith(
      category_id: freezed == category_id
          ? _value.category_id
          : category_id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      products: freezed == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      match_count: freezed == match_count
          ? _value.match_count
          : match_count // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
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
abstract class _$$CollectionItemImplCopyWith<$Res>
    implements $CollectionItemCopyWith<$Res> {
  factory _$$CollectionItemImplCopyWith(_$CollectionItemImpl value,
          $Res Function(_$CollectionItemImpl) then) =
      __$$CollectionItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? category_id,
      Category? category,
      List<Product>? products,
      Map<String, int>? match_count});

  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$CollectionItemImplCopyWithImpl<$Res>
    extends _$CollectionItemCopyWithImpl<$Res, _$CollectionItemImpl>
    implements _$$CollectionItemImplCopyWith<$Res> {
  __$$CollectionItemImplCopyWithImpl(
      _$CollectionItemImpl _value, $Res Function(_$CollectionItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category_id = freezed,
    Object? category = freezed,
    Object? products = freezed,
    Object? match_count = freezed,
  }) {
    return _then(_$CollectionItemImpl(
      category_id: freezed == category_id
          ? _value.category_id
          : category_id // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      products: freezed == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>?,
      match_count: freezed == match_count
          ? _value._match_count
          : match_count // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CollectionItemImpl implements _CollectionItem {
  const _$CollectionItemImpl(
      {this.category_id,
      this.category,
      final List<Product>? products,
      final Map<String, int>? match_count})
      : _products = products,
        _match_count = match_count;

  factory _$CollectionItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CollectionItemImplFromJson(json);

  @override
  final String? category_id;
  @override
  final Category? category;
  final List<Product>? _products;
  @override
  List<Product>? get products {
    final value = _products;
    if (value == null) return null;
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, int>? _match_count;
  @override
  Map<String, int>? get match_count {
    final value = _match_count;
    if (value == null) return null;
    if (_match_count is EqualUnmodifiableMapView) return _match_count;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'CollectionItem(category_id: $category_id, category: $category, products: $products, match_count: $match_count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CollectionItemImpl &&
            (identical(other.category_id, category_id) ||
                other.category_id == category_id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._products, _products) &&
            const DeepCollectionEquality()
                .equals(other._match_count, _match_count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      category_id,
      category,
      const DeepCollectionEquality().hash(_products),
      const DeepCollectionEquality().hash(_match_count));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CollectionItemImplCopyWith<_$CollectionItemImpl> get copyWith =>
      __$$CollectionItemImplCopyWithImpl<_$CollectionItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CollectionItemImplToJson(
      this,
    );
  }
}

abstract class _CollectionItem implements CollectionItem {
  const factory _CollectionItem(
      {final String? category_id,
      final Category? category,
      final List<Product>? products,
      final Map<String, int>? match_count}) = _$CollectionItemImpl;

  factory _CollectionItem.fromJson(Map<String, dynamic> json) =
      _$CollectionItemImpl.fromJson;

  @override
  String? get category_id;
  @override
  Category? get category;
  @override
  List<Product>? get products;
  @override
  Map<String, int>? get match_count;
  @override
  @JsonKey(ignore: true)
  _$$CollectionItemImplCopyWith<_$CollectionItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
