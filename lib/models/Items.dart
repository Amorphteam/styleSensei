import 'package:style_sensei/models/Products.dart';

import 'Category.dart';

/// category_id : "20838253"
/// category : {"id":"20838253","name":"Crossbody & Shoulder Bags","parent_id":"57387491","created_at":"2023-07-28T18:07:42.447648Z","modified_at":"2023-08-20T12:33:08.352656Z"}
/// products : null

class Items {
  Items({
      String? categoryId, 
      Category? category, 
      List<Products>? products,}){
    _categoryId = categoryId;
    _category = category;
    _products = products;
}

  Items.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['products'] != null) {
      if (json['products'] is List) {
        _products = (json['products'] as List).map((item) => Products.fromJson(item)).toList();
      } else {
        // Handle the case where 'products' is not a List<Products>.
        // You can set it to an empty list or handle it as appropriate for your use case.
        _products = [];
      }
    } else {
      _products = null;
    }
  }

  String? _categoryId;
  Category? _category;
  List<Products>? _products;
Items copyWith({  String? categoryId,
  Category? category,
  List<Products>? products,
}) => Items(  categoryId: categoryId ?? _categoryId,
  category: category ?? _category,
  products: products ?? _products,
);
  String? get categoryId => _categoryId;
  Category? get category => _category;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['products'] = _products;
    return map;
  }

}