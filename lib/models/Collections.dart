class Collections {
  final int id;
  final String title;
  final String image;
  final String createdAt;
  final String modifiedAt;

  Collections({
    required this.id,
    required this.title,
    required this.image,
    required this.createdAt,
    required this.modifiedAt,
  });

  Collections.fromJson(dynamic json)
      : id = json['id'],
        title = json['title'],
        image = json['image'],
        createdAt = json['created_at'],
        modifiedAt = json['modified_at'];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    return map;
  }
}
