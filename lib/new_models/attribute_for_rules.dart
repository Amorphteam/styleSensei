import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute_for_rules.freezed.dart';
part 'attribute_for_rules.g.dart';

@freezed
class AttributeForRules with _$AttributeForRules {
  const factory AttributeForRules({
    int? id,
    String? name,
    String? admin_name,
  }) = _AttributeForRules;

  factory AttributeForRules.fromJson(Map<String, dynamic> json) => _$AttributeForRulesFromJson(json);
}

