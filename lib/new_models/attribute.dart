import 'package:freezed_annotation/freezed_annotation.dart';

part 'attribute.freezed.dart';
part 'attribute.g.dart';

@freezed
class Attribute with _$Attribute {
  const factory Attribute({
    int? product_id,
    int? attribute_id,
    String? value,
    AttributeDetail? attribute,
  }) = _Attribute;

  factory Attribute.fromJson(Map<String, dynamic> json) => _$AttributeFromJson(json);
}

@freezed
class AttributeDetail with _$AttributeDetail {
  const factory AttributeDetail({
    String? name,
    String? admin_name,
    String? image_url,
  }) = _AttributeDetail;

  factory AttributeDetail.fromJson(Map<String, dynamic> json) => _$AttributeDetailFromJson(json);
}
