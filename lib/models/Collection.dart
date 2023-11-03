import 'Rules.dart';
import 'Items.dart';
import 'Tags.dart';

class Collection {
  num? id;
  String? title;
  String? description;
  String? image;
  List<Rules>? rules;
  List<Items>? items;

  Collection({
    this.id,
    this.title,
    this.description,
    this.image,
    this.rules,
    this.items,
  });

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    if (json['rules'] != null) {
      rules = List<Rules>.from(json['rules'].map((v) => Rules.fromJson(v)));
    }
    if (json['items'] != null) {
      items = List<Items>.from(json['items'].map((v) => Items.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };

    if (rules != null) {
      map['rules'] = rules!.map((v) => v.toJson()).toList();
    }
    if (items != null) {
      map['items'] = items!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
