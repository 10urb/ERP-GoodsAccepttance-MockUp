import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  RegisterResponseModel({
    this.odataContext,
    this.registerResponseValue,
  });

  String? odataContext;
  List<RegisterResponseValue>? registerResponseValue;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

@JsonSerializable()
class RegisterResponseValue {
  RegisterResponseValue({
    this.id,
    this.ad,
    this.soyad,
    this.unvan,
    this.sicilKod,
  });

  int? id;
  String? ad;
  String? soyad;
  String? unvan;
  String? sicilKod;

  factory RegisterResponseValue.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseValueFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseValueToJson(this);
}
