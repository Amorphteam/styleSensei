// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute_for_rules.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttributeForRules _$AttributeForRulesFromJson(Map<String, dynamic> json) {
  return _AttributeForRules.fromJson(json);
}

/// @nodoc
mixin _$AttributeForRules {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get admin_name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttributeForRulesCopyWith<AttributeForRules> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttributeForRulesCopyWith<$Res> {
  factory $AttributeForRulesCopyWith(
          AttributeForRules value, $Res Function(AttributeForRules) then) =
      _$AttributeForRulesCopyWithImpl<$Res, AttributeForRules>;
  @useResult
  $Res call({int? id, String? name, String? admin_name});
}

/// @nodoc
class _$AttributeForRulesCopyWithImpl<$Res, $Val extends AttributeForRules>
    implements $AttributeForRulesCopyWith<$Res> {
  _$AttributeForRulesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? admin_name = freezed,
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
      admin_name: freezed == admin_name
          ? _value.admin_name
          : admin_name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttributeForRulesImplCopyWith<$Res>
    implements $AttributeForRulesCopyWith<$Res> {
  factory _$$AttributeForRulesImplCopyWith(_$AttributeForRulesImpl value,
          $Res Function(_$AttributeForRulesImpl) then) =
      __$$AttributeForRulesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? admin_name});
}

/// @nodoc
class __$$AttributeForRulesImplCopyWithImpl<$Res>
    extends _$AttributeForRulesCopyWithImpl<$Res, _$AttributeForRulesImpl>
    implements _$$AttributeForRulesImplCopyWith<$Res> {
  __$$AttributeForRulesImplCopyWithImpl(_$AttributeForRulesImpl _value,
      $Res Function(_$AttributeForRulesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? admin_name = freezed,
  }) {
    return _then(_$AttributeForRulesImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      admin_name: freezed == admin_name
          ? _value.admin_name
          : admin_name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttributeForRulesImpl implements _AttributeForRules {
  const _$AttributeForRulesImpl({this.id, this.name, this.admin_name});

  factory _$AttributeForRulesImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttributeForRulesImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? admin_name;

  @override
  String toString() {
    return 'AttributeForRules(id: $id, name: $name, admin_name: $admin_name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttributeForRulesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.admin_name, admin_name) ||
                other.admin_name == admin_name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, admin_name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AttributeForRulesImplCopyWith<_$AttributeForRulesImpl> get copyWith =>
      __$$AttributeForRulesImplCopyWithImpl<_$AttributeForRulesImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttributeForRulesImplToJson(
      this,
    );
  }
}

abstract class _AttributeForRules implements AttributeForRules {
  const factory _AttributeForRules(
      {final int? id,
      final String? name,
      final String? admin_name}) = _$AttributeForRulesImpl;

  factory _AttributeForRules.fromJson(Map<String, dynamic> json) =
      _$AttributeForRulesImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get admin_name;
  @override
  @JsonKey(ignore: true)
  _$$AttributeForRulesImplCopyWith<_$AttributeForRulesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
