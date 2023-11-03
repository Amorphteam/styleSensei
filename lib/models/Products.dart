import 'Category.dart';
import 'Attributes.dart';

/// id : 656
/// name : ""
/// description : ""
/// category_id : "56026842"
/// crawler_id : 87253
/// pictures : "https://pa.namshicdn.com/product/18/106981955PM/v5/1-zoom-desktop.jpg,https://pa.namshicdn.com/product/18/106981955PM/v5/2-zoom-desktop.jpg,https://pa.namshicdn.com/product/18/106981955PM/v5/3-zoom-desktop.jpg,https://pa.namshicdn.com/product/18/106981955PM/v5/4-zoom-desktop.jpg,https://pa.namshicdn.com/product/18/106981955PM/v5/5-zoom-desktop.jpg"
/// created_at : "2023-10-31T06:55:05.28842Z"
/// modified_at : "2023-10-31T06:55:05.28842Z"
/// category : {"id":"56026842","name":"Athletic Shoes & Sneakers","parent_id":"63455158","created_at":"2023-08-20T12:30:09.164034Z","modified_at":"2023-10-22T10:34:24.061664Z","parent":{"id":"63455158","name":"Shoes","parent_id":"","created_at":"2023-07-28T18:04:26.859227Z","modified_at":"2023-08-20T12:25:35.715756Z"}}
/// attributes : [{"product_id":656,"attribute_id":119,"value":"white","attribute":{"name":"Color","admin_name":"Color","image_url":""}},{"product_id":656,"attribute_id":116,"value":"Sneaker","attribute":{"name":"Athletic Shoes & Sneakers Types","admin_name":"Athletic Shoes & Sneakers Types","image_url":""}},{"product_id":656,"attribute_id":114,"value":"Flat Heel","attribute":{"name":"Shoes Heel","admin_name":"Main Shoes","image_url":""}}]

class Products {
  Products({
      num? id, 
      String? name, 
      String? description, 
      String? categoryId, 
      num? crawlerId, 
      String? pictures, 
      String? createdAt, 
      String? modifiedAt, 
      Category? category, 
      List<Attributes>? attributes,}){
    _id = id;
    _name = name;
    _description = description;
    _categoryId = categoryId;
    _crawlerId = crawlerId;
    _pictures = pictures;
    _createdAt = createdAt;
    _modifiedAt = modifiedAt;
    _category = category;
    _attributes = attributes;
}

  Products.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _categoryId = json['category_id'];
    _crawlerId = json['crawler_id'];
    _pictures = json['pictures'];
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['attributes'] != null) {
      _attributes = [];
      json['attributes'].forEach((v) {
        _attributes?.add(Attributes.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  String? _description;
  String? _categoryId;
  num? _crawlerId;
  String? _pictures;
  String? _createdAt;
  String? _modifiedAt;
  Category? _category;
  List<Attributes>? _attributes;
Products copyWith({  num? id,
  String? name,
  String? description,
  String? categoryId,
  num? crawlerId,
  String? pictures,
  String? createdAt,
  String? modifiedAt,
  Category? category,
  List<Attributes>? attributes,
}) => Products(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  categoryId: categoryId ?? _categoryId,
  crawlerId: crawlerId ?? _crawlerId,
  pictures: pictures ?? _pictures,
  createdAt: createdAt ?? _createdAt,
  modifiedAt: modifiedAt ?? _modifiedAt,
  category: category ?? _category,
  attributes: attributes ?? _attributes,
);
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get categoryId => _categoryId;
  num? get crawlerId => _crawlerId;
  String? get pictures => _pictures;
  String? get createdAt => _createdAt;
  String? get modifiedAt => _modifiedAt;
  Category? get category => _category;
  List<Attributes>? get attributes => _attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['category_id'] = _categoryId;
    map['crawler_id'] = _crawlerId;
    map['pictures'] = _pictures;
    map['created_at'] = _createdAt;
    map['modified_at'] = _modifiedAt;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_attributes != null) {
      map['attributes'] = _attributes?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}