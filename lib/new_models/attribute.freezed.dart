// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Attribute _$AttributeFromJson(Map<String, dynamic> json) {
  return _Attribute.fromJson(json);
}

/// @nodoc
mixin _$Attribute {
  int? get product_id => throw _privateConstructorUsedError;
  int? get attribute_id => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  AttributeDetail? get attribute => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttributeCopyWith<Attribute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeCopyWith<$Res> {
  factory $AttributeCopyWith(Attribute value, $Res Function(Attribute) then) =
      _$AttributeCopyWithImpl<$Res, Attribute>;
  @useResult
  $Res call(
      {int? product_id,
      int? attribute_id,
      String? value,
      AttributeDetail? attribute});

  $AttributeDetailCopyWith<$Res>? get attribute;
}

/// @nodoc
class _$AttributeCopyWithImpl<$Res, $Val extends Attribute>
    implements $AttributeCopyWith<$Res> {
  _$AttributeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product_id = freezed,
    Object? attribute_id = freezed,
    Object? value = freezed,
    Object? attribute = freezed,
  }) {
    return _then(_value.copyWith(
      product_id: freezed == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as int?,
      attribute_id: freezed == attribute_id
          ? _value.attribute_id
          : attribute_id // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      attribute: freezed == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as AttributeDetail?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AttributeDetailCopyWith<$Res>? get attribute {
    if (_value.attribute == null) {
      return null;
    }

    return $AttributeDetailCopyWith<$Res>(_value.attribute!, (value) {
      return _then(_value.copyWith(attribute: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AttributeImplCopyWith<$Res>
    implements $AttributeCopyWith<$Res> {
  factory _$$AttributeImplCopyWith(
          _$AttributeImpl value, $Res Function(_$AttributeImpl) then) =
      __$$AttributeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? product_id,
      int? attribute_id,
      String? value,
      AttributeDetail? attribute});

  @override
  $AttributeDetailCopyWith<$Res>? get attribute;
}

/// @nodoc
class __$$AttributeImplCopyWithImpl<$Res>
    extends _$AttributeCopyWithImpl<$Res, _$AttributeImpl>
    implements _$$AttributeImplCopyWith<$Res> {
  __$$AttributeImplCopyWithImpl(
      _$AttributeImpl _value, $Res Function(_$AttributeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product_id = freezed,
    Object? attribute_id = freezed,
    Object? value = freezed,
    Object? attribute = freezed,
  }) {
    return _then(_$AttributeImpl(
      product_id: freezed == product_id
          ? _value.product_id
          : product_id // ignore: cast_nullable_to_non_nullable
              as int?,
      attribute_id: freezed == attribute_id
          ? _value.attribute_id
          : attribute_id // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      attribute: freezed == attribute
          ? _value.attribute
          : attribute // ignore: cast_nullable_to_non_nullable
              as AttributeDetail?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttributeImpl implements _Attribute {
  const _$AttributeImpl(
      {this.product_id, this.attribute_id, this.value, this.attribute});

  factory _$AttributeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttributeImplFromJson(json);

  @override
  final int? product_id;
  @override
  final int? attribute_id;
  @override
  final String? value;
  @override
  final AttributeDetail? attribute;

  @override
  String toString() {
    return 'Attribute(product_id: $product_id, attribute_id: $attribute_id, value: $value, attribute: $attribute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttributeImpl &&
            (identical(other.product_id, product_id) ||
                other.product_id == product_id) &&
            (identical(other.attribute_id, attribute_id) ||
                other.attribute_id == attribute_id) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.attribute, attribute) ||
                other.attribute == attribute));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, product_id, attribute_id, value, attribute);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttributeImplCopyWith<_$AttributeImpl> get copyWith =>
      __$$AttributeImplCopyWithImpl<_$AttributeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttributeImplToJson(
      this,
    );
  }
}

abstract class _Attribute implements Attribute {
  const factory _Attribute(
      {final int? product_id,
      final int? attribute_id,
      final String? value,
      final AttributeDetail? attribute}) = _$AttributeImpl;

  factory _Attribute.fromJson(Map<String, dynamic> json) =
      _$AttributeImpl.fromJson;

  @override
  int? get product_id;
  @override
  int? get attribute_id;
  @override
  String? get value;
  @override
  AttributeDetail? get attribute;
  @override
  @JsonKey(ignore: true)
  _$$AttributeImplCopyWith<_$AttributeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AttributeDetail _$AttributeDetailFromJson(Map<String, dynamic> json) {
  return _AttributeDetail.fromJson(json);
}

/// @nodoc
mixin _$AttributeDetail {
  String? get name => throw _privateConstructorUsedError;
  String? get admin_name => throw _privateConstructorUsedError;
  String? get image_url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttributeDetailCopyWith<AttributeDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeDetailCopyWith<$Res> {
  factory $AttributeDetailCopyWith(
          AttributeDetail value, $Res Function(AttributeDetail) then) =
      _$AttributeDetailCopyWithImpl<$Res, AttributeDetail>;
  @useResult
  $Res call({String? name, String? admin_name, String? image_url});
}

/// @nodoc
class _$AttributeDetailCopyWithImpl<$Res, $Val extends AttributeDetail>
    implements $AttributeDetailCopyWith<$Res> {
  _$AttributeDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? admin_name = freezed,
    Object? image_url = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      admin_name: freezed == admin_name
          ? _value.admin_name
          : admin_name // ignore: cast_nullable_to_non_nullable
              as String?,
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttributeDetailImplCopyWith<$Res>
    implements $AttributeDetailCopyWith<$Res> {
  factory _$$AttributeDetailImplCopyWith(_$AttributeDetailImpl value,
          $Res Function(_$AttributeDetailImpl) then) =
      __$$AttributeDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? admin_name, String? image_url});
}

/// @nodoc
class __$$AttributeDetailImplCopyWithImpl<$Res>
    extends _$AttributeDetailCopyWithImpl<$Res, _$AttributeDetailImpl>
    implements _$$AttributeDetailImplCopyWith<$Res> {
  __$$AttributeDetailImplCopyWithImpl(
      _$AttributeDetailImpl _value, $Res Function(_$AttributeDetailImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? admin_name = freezed,
    Object? image_url = freezed,
  }) {
    return _then(_$AttributeDetailImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      admin_name: freezed == admin_name
          ? _value.admin_name
          : admin_name // ignore: cast_nullable_to_non_nullable
              as String?,
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttributeDetailImpl implements _AttributeDetail {
  const _$AttributeDetailImpl({this.name, this.admin_name, this.image_url});

  factory _$AttributeDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttributeDetailImplFromJson(json);

  @override
  final String? name;
  @override
  final String? admin_name;
  @override
  final String? image_url;

  @override
  String toString() {
    return 'AttributeDetail(name: $name, admin_name: $admin_name, image_url: $image_url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttributeDetailImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.admin_name, admin_name) ||
                other.admin_name == admin_name) &&
            (identical(other.image_url, image_url) ||
                other.image_url == image_url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, admin_name, image_url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttributeDetailImplCopyWith<_$AttributeDetailImpl> get copyWith =>
      __$$AttributeDetailImplCopyWithImpl<_$AttributeDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttributeDetailImplToJson(
      this,
    );
  }
}

abstract class _AttributeDetail implements AttributeDetail {
  const factory _AttributeDetail(
      {final String? name,
      final String? admin_name,
      final String? image_url}) = _$AttributeDetailImpl;

  factory _AttributeDetail.fromJson(Map<String, dynamic> json) =
      _$AttributeDetailImpl.fromJson;

  @override
  String? get name;
  @override
  String? get admin_name;
  @override
  String? get image_url;
  @override
  @JsonKey(ignore: true)
  _$$AttributeDetailImplCopyWith<_$AttributeDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
