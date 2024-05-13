import 'package:style_sensei/new_models/collection_item.dart';
import 'Rules.dart';

class Collection {
  num? id;
  String? title;
  String? description;
  String? image;
  List<Rules>? rules;
  List<CollectionItem>? items;
  Map<String, dynamic>? tags;

  Collection({
    this.id,
    this.title,
    this.description,
    this.image,
    this.rules,
    this.items,
    this.tags,
  });

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];

    // Handle 'rules' which is a list of Rules objects
    if (json['rules'] != null) {
      rules = List<Rules>.from(json['rules'].map((v) => Rules.fromJson(v)));
    }

    // Handle 'items' which is a list of CollectionItem objects
    if (json['items'] != null) {
      items = List<CollectionItem>.from(json['items'].map((v) => CollectionItem.fromJson(v)));
    }

    // Correctly handle 'tags' as a Map
    tags = json['tags'] != null ? Map<String, dynamic>.from(json['tags']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {
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
    if (tags != null) {
      map['tags'] = tags;  // Directly assign the Map
    }
    return map;
  }
}
