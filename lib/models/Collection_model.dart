import 'Collections.dart';

class CollectionModel {
  final List<Collections> collections;

  CollectionModel({
    required this.collections,
  });

  factory CollectionModel.fromJson(dynamic json) {
    List<Collections> collectionsList = [];

    if (json['collections'] != null) {
      json['collections'].forEach((v) {
        collectionsList.add(Collections.fromJson(v));
      });
    }

    return CollectionModel(collections: collectionsList);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (collections != null) {
      map['collections'] = collections.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
