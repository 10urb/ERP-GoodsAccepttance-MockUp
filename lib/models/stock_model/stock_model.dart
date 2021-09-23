import 'package:json_annotation/json_annotation.dart';

part 'stock_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
//flutter packages pub run build_runner build --delete-conflicting-outputs //if have exit code 78
@JsonSerializable()
class StockModel {
  StockModel({
    this.odataContext,
    this.value,
  });

  String? odataContext;
  List<StockValue>? value;
  factory StockModel.fromJson(Map<String, dynamic> json) =>
      _$StockModelFromJson(json);
  Map<String, dynamic> toJson() => _$StockModelToJson(this);
}

@JsonSerializable()
class StockValue {
  StockValue({
    this.id,
    this.name,
  });

  int? id;
  String? name;
  factory StockValue.fromJson(Map<String, dynamic> json) =>
      _$StockValueFromJson(json);
  Map<String, dynamic> toJson() => _$StockValueToJson(this);
}
