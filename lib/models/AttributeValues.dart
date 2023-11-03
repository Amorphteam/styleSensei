/// value : "Aqua"
/// image_url : ""

class AttributeValues {
  AttributeValues({
      String? value, 
      String? imageUrl,}){
    _value = value;
    _imageUrl = imageUrl;
}

  AttributeValues.fromJson(dynamic json) {
    _value = json['value'];
    _imageUrl = json['image_url'];
  }
  String? _value;
  String? _imageUrl;
AttributeValues copyWith({  String? value,
  String? imageUrl,
}) => AttributeValues(  value: value ?? _value,
  imageUrl: imageUrl ?? _imageUrl,
);
  String? get value => _value;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    map['image_url'] = _imageUrl;
    return map;
  }

}