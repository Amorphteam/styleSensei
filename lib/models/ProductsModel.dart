import 'Collection.dart';

class ProductsModel {
  ProductsModel({
      Collection? collection,}){
    _collection = collection;
}

  ProductsModel.fromJson(dynamic json) {
    _collection = json['collection'] != null ? Collection.fromJson(json['collection']) : null;
  }
  Collection? _collection;
ProductsModel copyWith({  Collection? collection,
}) => ProductsModel(  collection: collection ?? _collection,
);
  Collection? get collection => _collection;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_collection != null) {
      map['collection'] = _collection?.toJson();
    }
    return map;
  }

}