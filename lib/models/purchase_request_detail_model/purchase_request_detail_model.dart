import 'package:json_annotation/json_annotation.dart';

part 'purchase_request_detail_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
@JsonSerializable()
class PurchaseRequestDetail {
  PurchaseRequestDetail({
    this.odataContext,
    this.purchaseRequestDetailValue,
  });

  String? odataContext;
  List<PurchaseRequestDetailValue>? purchaseRequestDetailValue;

  factory PurchaseRequestDetail.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseRequestDetailToJson(this);
}

@JsonSerializable()
class PurchaseRequestDetailValue {
  PurchaseRequestDetailValue({
    this.id,
    this.price,
    this.amount,
    this.acceptedAmount,
    this.note,
    this.purchaseRequestStock,
  });

  int? id;
  dynamic price;
  dynamic amount;
  dynamic acceptedAmount;
  String? note;
  PurchaseRequestStock? purchaseRequestStock;

  factory PurchaseRequestDetailValue.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestDetailValueFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseRequestDetailValueToJson(this);
}

@JsonSerializable()
class PurchaseRequestStock {
  PurchaseRequestStock({
    this.id,
    this.approvalStatusId,
    this.purchaseRequestId,
    this.responsibleUserId,
    this.stockId,
    this.unitId,
    this.purchaseRequestTrackId,
    this.acceptedCompanyOfferId,
    this.name,
    this.image,
    this.link,
    this.requestedAmount,
    this.approvedAmount,
    this.description,
    this.resultDescription,
    this.createdUserId,
    this.lastUpdatedUserId,
    this.dataStatus,
    this.createdAt,
    this.lastUpdatedAt,
    this.stock,
    this.unit,
  });

  int? id;
  String? approvalStatusId;
  int? purchaseRequestId;
  dynamic responsibleUserId;
  int? stockId;
  int? unitId;
  int? purchaseRequestTrackId;
  int? acceptedCompanyOfferId;
  dynamic name;
  dynamic image;
  dynamic link;
  double? requestedAmount;
  double? approvedAmount;
  String? description;
  dynamic resultDescription;
  int? createdUserId;
  int? lastUpdatedUserId;
  String? dataStatus;
  String? createdAt;
  String? lastUpdatedAt;
  Stock? stock;
  Stock? unit;

  factory PurchaseRequestStock.fromJson(Map<String, dynamic> json) =>
      _$PurchaseRequestStockFromJson(json);
  Map<String, dynamic> toJson() => _$PurchaseRequestStockToJson(this);
}

@JsonSerializable()
class Stock {
  Stock({
    this.name,
  });

  String? name;

  factory Stock.fromJson(Map<String, dynamic> json) => _$StockFromJson(json);
  Map<String, dynamic> toJson() => _$StockToJson(this);
}
