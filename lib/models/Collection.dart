import 'Rules.dart';
import 'Items.dart';

class Collection {
  num? id;
  String? title;
  String? description;
  String? image;

  Collection({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  Collection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
    };
    return map;
  }
}
