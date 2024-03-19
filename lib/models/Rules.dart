import '../new_models/category.dart';
import 'Attribute.dart';

/// id : 144
/// collection_id : 241
/// category_id : "20838253"
/// attribute_id : 119
/// attribute_value : "White"
/// category : {"id":"20838253","name":"Crossbody & Shoulder Bags","parent_id":"57387491","created_at":"2023-07-28T18:07:42.447648Z","modified_at":"2023-08-20T12:33:08.352656Z"}
/// attribute : {"id":119,"name":"Color","admin_name":"Color","image_url":"","is_selectable":true,"attribute_values":[{"value":"Aqua","image_url":""},{"value":"Beige","image_url":""},{"value":"Black","image_url":""},{"value":"Blue","image_url":""},{"value":"Brown","image_url":""},{"value":"Chocolate","image_url":""},{"value":"Cyan","image_url":""},{"value":"Fuchsia","image_url":""},{"value":"Gold","image_url":""},{"value":"Gray","image_url":""},{"value":"Green","image_url":""},{"value":"Indigo","image_url":""},{"value":"Khaki","image_url":""},{"value":"Maroon","image_url":""},{"value":"Multi Color","image_url":""},{"value":"Navy","image_url":""},{"value":"Olive","image_url":""},{"value":"Orange","image_url":""},{"value":"Pink","image_url":""},{"value":"Purple","image_url":""},{"value":"Red","image_url":""},{"value":"Silver","image_url":""},{"value":"Teal","image_url":""},{"value":"White","image_url":""},{"value":"Yellow","image_url":""}]}
/// products : null

class Rules {
  Rules({
      num? id, 
      num? collectionId, 
      String? categoryId, 
      num? attributeId, 
      String? attributeValue, 
      Category? category, 
      Attribute? attribute, 
      dynamic products,}){
    _id = id;
    _collectionId = collectionId;
    _categoryId = categoryId;
    _attributeId = attributeId;
    _attributeValue = attributeValue;
    _category = category;
    _attribute = attribute;
    _products = products;
}

  Rules.fromJson(dynamic json) {
    _id = json['id'];
    _collectionId = json['collection_id'];
    _categoryId = json['category_id'];
    _attributeId = json['attribute_id'];
    _attributeValue = json['attribute_value'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _attribute = json['attribute'] != null ? Attribute.fromJson(json['attribute']) : null;
    _products = json['products'];
  }
  num? _id;
  num? _collectionId;
  String? _categoryId;
  num? _attributeId;
  String? _attributeValue;
  Category? _category;
  Attribute? _attribute;
  dynamic _products;
Rules copyWith({  num? id,
  num? collectionId,
  String? categoryId,
  num? attributeId,
  String? attributeValue,
  Category? category,
  Attribute? attribute,
  dynamic products,
}) => Rules(  id: id ?? _id,
  collectionId: collectionId ?? _collectionId,
  categoryId: categoryId ?? _categoryId,
  attributeId: attributeId ?? _attributeId,
  attributeValue: attributeValue ?? _attributeValue,
  category: category ?? _category,
  attribute: attribute ?? _attribute,
  products: products ?? _products,
);
  num? get id => _id;
  num? get collectionId => _collectionId;
  String? get categoryId => _categoryId;
  num? get attributeId => _attributeId;
  String? get attributeValue => _attributeValue;
  Category? get category => _category;
  Attribute? get attribute => _attribute;
  dynamic get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['collection_id'] = _collectionId;
    map['category_id'] = _categoryId;
    map['attribute_id'] = _attributeId;
    map['attribute_value'] = _attributeValue;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_attribute != null) {
      map['attribute'] = _attribute?.toJson();
    }
    map['products'] = _products;
    return map;
  }

}