import 'package:json_annotation/json_annotation.dart';
part 'currency_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
@JsonSerializable()
class CurrencyModel {
  CurrencyModel({
    this.odataContext,
    this.currencyValue,
  });

  String? odataContext;
  List<CurrencyValue>? currencyValue;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) =>
      _$CurrencyModelFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyModelToJson(this);
}

@JsonSerializable()
class CurrencyValue {
  CurrencyValue({
    this.id,
    this.sembol,
    this.kod,
  });

  int? id;
  String? sembol;
  String? kod;
  factory CurrencyValue.fromJson(Map<String, dynamic> json) =>
      _$CurrencyValueFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyValueToJson(this);
}
