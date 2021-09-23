import 'package:json_annotation/json_annotation.dart';

part 'purchase_request_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
@JsonSerializable()
class PurchaseRequestModel {
  String odataContext;
  List<PurchaseRequestValue> value;

  PurchaseRequestModel({required this.odataContext, required this.value});

  factory PurchaseRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseRequestModelToJson(this);
}

@JsonSerializable()
class PurchaseRequestTrack {
  String code;
  PurchaseRequestTrack({required this.code});

  factory PurchaseRequestTrack.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestTrackFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseRequestTrackToJson(this);
}

@JsonSerializable()
class PurchaseRequestValue {
  int id;
  int purchaseRequestTrackId;
  String deadline;
  bool isSelected = false;
  //sesim geliyor mu evet ne evet
  PurchaseRequestTrack purchaseRequestTrack;

  PurchaseRequestValue(
      {required this.id,
      required this.purchaseRequestTrackId,
      required this.deadline,
      required this.isSelected,
      required this.purchaseRequestTrack});

  factory PurchaseRequestValue.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestValueFromJson(json);

  Map<String, dynamic> toJson() => _$PurchaseRequestValueToJson(this);
}
