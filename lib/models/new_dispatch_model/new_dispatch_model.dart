import 'package:json_annotation/json_annotation.dart';

part 'new_dispatch_model.g.dart';

@JsonSerializable()
class NewDispatchModel {
  NewDispatchModel({
    this.dispatch,
    this.newDispatchItem,
    this.purchaseRequestKeys,
  });

  NewDispatch? dispatch;
  List<NewDispatchItem>? newDispatchItem;
  List<int>? purchaseRequestKeys;

  factory NewDispatchModel.fromJson(Map<String, dynamic> json) =>
      _$NewDispatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewDispatchModelToJson(this);
}

@JsonSerializable()
class NewDispatch {
  NewDispatch({
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

  factory NewDispatch.fromJson(Map<String, dynamic> json) =>
      _$NewDispatchFromJson(json);

  Map<String, dynamic> toJson() => _$NewDispatchToJson(this);
}

@JsonSerializable()
class NewDispatchItem {
  NewDispatchItem({
    this.receiptNumber,
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
  });

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

  factory NewDispatchItem.fromJson(Map<String, dynamic> json) =>
      _$NewDispatchItemFromJson(json);

  Map<String, dynamic> toJson() => _$NewDispatchItemToJson(this);
}
