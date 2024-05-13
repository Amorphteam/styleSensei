/// Color Tone : ["Dark"]
/// Hijab : ["False"]
/// Occasions : ["Weekend"]
/// Style Name : ["Minimal","Wintage"]
/// Weather Condition : ["Spring","Summer"]

class Tags {
  Tags({
      List<String>? colorTone, 
      List<String>? hijab, 
      List<String>? occasions, 
      List<String>? styleName, 
      List<String>? weatherCondition,
      List<String>? workAttire}){
    _colorTone = colorTone;
    _hijab = hijab;
    _occasions = occasions;
    _styleName = styleName;
    _weatherCondition = weatherCondition;
    _workAttire = workAttire;
}

  Tags.fromJson(dynamic json) {
    _colorTone = json['Color Tone'] != null ? json['Color Tone'].cast<String>() : [];
    _hijab = json['Hijab'] != null ? json['Hijab'].cast<String>() : [];
    _occasions = json['Occasions'] != null ? json['Occasions'].cast<String>() : [];
    _styleName = json['Style Name'] != null ? json['Style Name'].cast<String>() : [];
    _weatherCondition = json['Weather Condition'] != null ? json['Weather Condition'].cast<String>() : [];
    _workAttire = json['Work Attire'] != null ? json['Work Attire'].cast<String>() : [];
  }
  List<String>? _colorTone;
  List<String>? _hijab;
  List<String>? _occasions;
  List<String>? _styleName;
  List<String>? _weatherCondition;
  List<String>? _workAttire;
Tags copyWith({  List<String>? colorTone,
  List<String>? hijab,
  List<String>? occasions,
  List<String>? styleName,
  List<String>? weatherCondition,
  List<String>? workAttire
}) => Tags(  colorTone: colorTone ?? _colorTone,
  hijab: hijab ?? _hijab,
  occasions: occasions ?? _occasions,
  styleName: styleName ?? _styleName,
  weatherCondition: weatherCondition ?? _weatherCondition,
  workAttire: workAttire ?? _workAttire
);
  List<String>? get colorTone => _colorTone;
  List<String>? get hijab => _hijab;
  List<String>? get occasions => _occasions;
  List<String>? get styleName => _styleName;
  List<String>? get weatherCondition => _weatherCondition;
  List<String>? get workAttire => _workAttire;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Color Tone'] = _colorTone;
    map['Hijab'] = _hijab;
    map['Occasions'] = _occasions;
    map['Style Name'] = _styleName;
    map['Weather Condition'] = _weatherCondition;
    map['Work Attire'] = _workAttire;
    return map;
  }

}