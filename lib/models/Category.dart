/// id : "20838253"
/// name : "Crossbody & Shoulder Bags"
/// parent_id : "57387491"
/// created_at : "2023-07-28T18:07:42.447648Z"
/// modified_at : "2023-08-20T12:33:08.352656Z"

class Category {
  Category({
      String? id, 
      String? name, 
      String? parentId, 
      String? createdAt, 
      String? modifiedAt,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _createdAt = createdAt;
    _modifiedAt = modifiedAt;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
  }
  String? _id;
  String? _name;
  String? _parentId;
  String? _createdAt;
  String? _modifiedAt;
Category copyWith({  String? id,
  String? name,
  String? parentId,
  String? createdAt,
  String? modifiedAt,
}) => Category(  id: id ?? _id,
  name: name ?? _name,
  parentId: parentId ?? _parentId,
  createdAt: createdAt ?? _createdAt,
  modifiedAt: modifiedAt ?? _modifiedAt,
);
  String? get id => _id;
  String? get name => _name;
  String? get parentId => _parentId;
  String? get createdAt => _createdAt;
  String? get modifiedAt => _modifiedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['created_at'] = _createdAt;
    map['modified_at'] = _modifiedAt;
    return map;
  }

}