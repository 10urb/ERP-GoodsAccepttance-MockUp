import 'package:json_annotation/json_annotation.dart';
part 'store_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
//flutter packages pub run build_runner build --delete-conflicting-outputs //if have exit code 78
@JsonSerializable()
class StoreModel {
  StoreModel({
    this.odataContext,
    this.value,
  });

  String? odataContext;
  List<StoreValue>? value;
  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);
  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}

@JsonSerializable()
class StoreValue {
  StoreValue({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory StoreValue.fromJson(Map<String, dynamic> json) =>
      _$StoreValueFromJson(json);

  Map<String, dynamic> toJson() => _$StoreValueToJson(this);
}
