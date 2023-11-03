import 'AttributeValues.dart';

/// id : 119
/// name : "Color"
/// admin_name : "Color"
/// image_url : ""
/// is_selectable : true
/// attribute_values : [{"value":"Aqua","image_url":""},{"value":"Beige","image_url":""},{"value":"Black","image_url":""},{"value":"Blue","image_url":""},{"value":"Brown","image_url":""},{"value":"Chocolate","image_url":""},{"value":"Cyan","image_url":""},{"value":"Fuchsia","image_url":""},{"value":"Gold","image_url":""},{"value":"Gray","image_url":""},{"value":"Green","image_url":""},{"value":"Indigo","image_url":""},{"value":"Khaki","image_url":""},{"value":"Maroon","image_url":""},{"value":"Multi Color","image_url":""},{"value":"Navy","image_url":""},{"value":"Olive","image_url":""},{"value":"Orange","image_url":""},{"value":"Pink","image_url":""},{"value":"Purple","image_url":""},{"value":"Red","image_url":""},{"value":"Silver","image_url":""},{"value":"Teal","image_url":""},{"value":"White","image_url":""},{"value":"Yellow","image_url":""}]

class Attribute {
  Attribute({
      num? id, 
      String? name, 
      String? adminName, 
      String? imageUrl, 
      bool? isSelectable, 
      List<AttributeValues>? attributeValues,}){
    _id = id;
    _name = name;
    _adminName = adminName;
    _imageUrl = imageUrl;
    _isSelectable = isSelectable;
    _attributeValues = attributeValues;
}

  Attribute.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _adminName = json['admin_name'];
    _imageUrl = json['image_url'];
    _isSelectable = json['is_selectable'];
    if (json['attribute_values'] != null) {
      _attributeValues = [];
      json['attribute_values'].forEach((v) {
        _attributeValues?.add(AttributeValues.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  String? _adminName;
  String? _imageUrl;
  bool? _isSelectable;
  List<AttributeValues>? _attributeValues;
Attribute copyWith({  num? id,
  String? name,
  String? adminName,
  String? imageUrl,
  bool? isSelectable,
  List<AttributeValues>? attributeValues,
}) => Attribute(  id: id ?? _id,
  name: name ?? _name,
  adminName: adminName ?? _adminName,
  imageUrl: imageUrl ?? _imageUrl,
  isSelectable: isSelectable ?? _isSelectable,
  attributeValues: attributeValues ?? _attributeValues,
);
  num? get id => _id;
  String? get name => _name;
  String? get adminName => _adminName;
  String? get imageUrl => _imageUrl;
  bool? get isSelectable => _isSelectable;
  List<AttributeValues>? get attributeValues => _attributeValues;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['admin_name'] = _adminName;
    map['image_url'] = _imageUrl;
    map['is_selectable'] = _isSelectable;
    if (_attributeValues != null) {
      map['attribute_values'] = _attributeValues?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}