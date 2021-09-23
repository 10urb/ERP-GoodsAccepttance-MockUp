import 'package:json_annotation/json_annotation.dart';
part 'unit_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
//flutter packages pub run build_runner build --delete-conflicting-outputs //if have exit code 78
@JsonSerializable()
class UnitModel {
  UnitModel({
    this.odataContext,
    this.value,
  });

  String? odataContext;
  List<UnitValue>? value;
  factory UnitModel.fromJson(Map<String, dynamic> json) =>
      _$UnitModelFromJson(json);
  Map<String, dynamic> toJson() => _$UnitModelToJson(this);
}

@JsonSerializable()
class UnitValue {
  UnitValue({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory UnitValue.fromJson(Map<String, dynamic> json) =>
      _$UnitValueFromJson(json);

  Map<String, dynamic> toJson() => _$UnitValueToJson(this);
}
