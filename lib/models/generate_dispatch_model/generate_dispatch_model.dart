import 'package:json_annotation/json_annotation.dart';

part 'generate_dispatch_model.g.dart';

//flutter pub run build_runner build / model creater one time
//flutter pub run build_runner watch / model creater and editor, momentary/ontime
@JsonSerializable()
class GenerateDispatchModel {
  Val? val;
  List<Items>? items;
  GenerateDispatchModel({this.val, this.items});

  factory GenerateDispatchModel.fromJson(Map<String, dynamic> json) =>
      _$GenerateDispatchModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenerateDispatchModelToJson(this);
}

@JsonSerializable()
class Val {
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
  int? status;
  bool? isBillControlFinish;
  dynamic companyCurrent;
  dynamic currency;
  dynamic sonOnayHareket;
  dynamic onayHarekets;
  dynamic faturaKontrolHarekets;
  dynamic dispatchItems;
  dynamic createdUserId;
  dynamic lastUpdatedUserId;
  String? dataStatus;
  DateTime? createdAt;
  dynamic lastUpdatedAt;
  dynamic createdUser;
  dynamic lastUpdatedUser;

  Val({
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
    this.onayHarekets,
    this.faturaKontrolHarekets,
    this.dispatchItems,
    this.createdUserId,
    this.lastUpdatedUserId,
    this.dataStatus,
    this.createdAt,
    this.lastUpdatedAt,
    this.createdUser,
    this.lastUpdatedUser,
  });

  factory Val.fromJson(Map<String, dynamic> json) => _$ValFromJson(json);
  Map<String, dynamic> toJson() => _$ValToJson(this);
}

@JsonSerializable()
class Items {
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
  dynamic marka;
  bool? isSelected = false;
  bool? isSelectedForDelete = false;

  Items(
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
      this.isSelected,
      this.isSelectedForDelete});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);
  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
