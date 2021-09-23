import 'package:json_annotation/json_annotation.dart';

part 'dispatch_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime

@JsonSerializable()
class DispatchModel {
  Dispatch? dispatch;
  List<DispatchItems>? dispatchItems;
  List<PurchaseRequestKey>? purchaseRequestKeys;
  DispatchModel({this.dispatch, this.dispatchItems, this.purchaseRequestKeys});

  factory DispatchModel.fromJson(Map<String, dynamic> json) =>
      _$DispatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$DispatchModelToJson(this);
}

@JsonSerializable()
class Dispatch {
  int? id;
  int? companyCurrentId;
  int? currencyId;
  dynamic currencyRate;
  String? dispatchTypeId;
  String? serial;
  dynamic detail;
  bool? isDone;
  int? sequence;
  dynamic file;
  bool? isBilled;
  DateTime? updateDate;
  DateTime? shipmentDate;
  String? status;
  bool? isBillControlFinish;
  dynamic companyCurrent;
  dynamic currency;
  dynamic sonOnayHareket;
  dynamic createdUserId;
  dynamic lastUpdatedUserId;
  String? dataStatus;
  DateTime? createdAt;
  dynamic lastUpdatedAt;
  dynamic createdUser;
  dynamic lastUpdatedUser;

  Dispatch({
    this.id,
    this.companyCurrentId,
    this.currencyId,
    this.currencyRate,
    this.dispatchTypeId,
    this.serial,
    this.detail,
    this.isDone,
    this.sequence,
    this.file,
    this.isBilled,
    this.updateDate,
    this.shipmentDate,
    this.status,
    this.isBillControlFinish,
    this.companyCurrent,
    this.currency,
    this.sonOnayHareket,
    this.createdUserId,
    this.lastUpdatedUserId,
    this.dataStatus,
    this.createdAt,
    this.lastUpdatedAt,
    this.createdUser,
    this.lastUpdatedUser,
  });

  factory Dispatch.fromJson(Map<String, dynamic> json) =>
      _$DispatchFromJson(json);

  Map<String, dynamic> toJson() => _$DispatchToJson(this);
}

@JsonSerializable()
class DispatchItems {
  String? receiptNumber;
  String? trackCode;
  int? purchaseRequestId;
  int? purchaseRequestStockId;
  double? acceptedAmount;
  double? totalAmount;
  double? amount;
  double? price;
  String? stockName;
  String? unitName;
  String? storeName;
  int? stockId;
  int? unitId;
  int? storeId;
  String? requesterUser;
  double? taxRate;
  String? aciklama;
  String? marka;
  bool? isSelected;
  DispatchItems(
      {this.receiptNumber,
      this.trackCode,
      this.purchaseRequestId,
      this.purchaseRequestStockId,
      this.acceptedAmount,
      this.totalAmount,
      this.amount,
      this.price,
      this.stockName,
      this.unitName,
      this.storeName,
      this.stockId,
      this.unitId,
      this.storeId,
      this.requesterUser,
      this.taxRate,
      this.aciklama,
      this.marka,
      this.isSelected});

  factory DispatchItems.fromJson(Map<String, dynamic> json) =>
      _$DispatchItemsFromJson(json);

  Map<String, dynamic> toJson() => _$DispatchItemsToJson(this);
}

@JsonSerializable()
class PurchaseRequestKey {
  List<int> value;

  PurchaseRequestKey({required this.value});
  factory PurchaseRequestKey.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestKeyFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseRequestKeyToJson(this);
}
