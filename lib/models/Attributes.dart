import 'Attribute.dart';

/// product_id : 656
/// attribute_id : 119
/// value : "white"
/// attribute : {"name":"Color","admin_name":"Color","image_url":""}

class Attributes {
  Attributes({
      num? productId, 
      num? attributeId, 
      String? value, 
      Attribute? attribute,}){
    _productId = productId;
    _attributeId = attributeId;
    _value = value;
    _attribute = attribute;
}

  Attributes.fromJson(dynamic json) {
    _productId = json['product_id'];
    _attributeId = json['attribute_id'];
    _value = json['value'];
    _attribute = json['attribute'] != null ? Attribute.fromJson(json['attribute']) : null;
  }
  num? _productId;
  num? _attributeId;
  String? _value;
  Attribute? _attribute;
Attributes copyWith({  num? productId,
  num? attributeId,
  String? value,
  Attribute? attribute,
}) => Attributes(  productId: productId ?? _productId,
  attributeId: attributeId ?? _attributeId,
  value: value ?? _value,
  attribute: attribute ?? _attribute,
);
  num? get productId => _productId;
  num? get attributeId => _attributeId;
  String? get value => _value;
  Attribute? get attribute => _attribute;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['attribute_id'] = _attributeId;
    map['value'] = _value;
    if (_attribute != null) {
      map['attribute'] = _attribute?.toJson();
    }
    return map;
  }

}