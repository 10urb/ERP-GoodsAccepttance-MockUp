// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dispatch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DispatchModel _$DispatchModelFromJson(Map<String, dynamic> json) =>
    DispatchModel(
      dispatch: json['dispatch'] == null
          ? null
          : Dispatch.fromJson(json['dispatch'] as Map<String, dynamic>),
      dispatchItems: (json['items'] as List<dynamic>?)
          ?.map((e) => DispatchItems.fromJson(e as Map<String, dynamic>))
          .toList(),
      purchaseRequestKeys: (json['purchaseRequestKeys'] as List<dynamic>?)
          ?.map((e) => PurchaseRequestKey.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DispatchModelToJson(DispatchModel instance) =>
    <String, dynamic>{
      'dispatch': instance.dispatch,
      'items': instance.dispatchItems,
      'purchaseRequestKeys': instance.purchaseRequestKeys,
    };

Dispatch _$DispatchFromJson(Map<String, dynamic> json) => Dispatch(
      id: json['id'] as int?,
      companyCurrentId: json['companyCurrentId'] as int?,
      currencyId: json['currencyId'] as int?,
      currencyRate: json['currencyRate'],
      dispatchTypeId: json['dispatchTypeId'] as String?,
      serial: json['serial'] as String?,
      detail: json['detail'],
      isDone: json['isDone'] as bool?,
      sequence: json['sequence'] as int?,
      file: json['file'],
      isBilled: json['isBilled'] as bool?,
      updateDate: json['updateDate'] == null
          ? null
          : DateTime.parse(json['updateDate'] as String),
      shipmentDate: json['shipmentDate'] == null
          ? null
          : DateTime.parse(json['shipmentDate'] as String),
      status: json['status'] as String?,
      isBillControlFinish: json['isBillControlFinish'] as bool?,
      companyCurrent: json['companyCurrent'],
      currency: json['currency'],
      sonOnayHareket: json['sonOnayHareket'],
      createdUserId: json['createdUserId'],
      lastUpdatedUserId: json['lastUpdatedUserId'],
      dataStatus: json['dataStatus'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      lastUpdatedAt: json['lastUpdatedAt'],
      createdUser: json['createdUser'],
      lastUpdatedUser: json['lastUpdatedUser'],
    );

Map<String, dynamic> _$DispatchToJson(Dispatch instance) => <String, dynamic>{
      'id': instance.id,
      'companyCurrentId': instance.companyCurrentId,
      'currencyId': instance.currencyId,
      'currencyRate': instance.currencyRate,
      'dispatchTypeId': instance.dispatchTypeId,
      'serial': instance.serial,
      'detail': instance.detail,
      'isDone': instance.isDone,
      'sequence': instance.sequence,
      'file': instance.file,
      'isBilled': instance.isBilled,
      'updateDate': instance.updateDate?.toIso8601String(),
      'shipmentDate': instance.shipmentDate?.toIso8601String(),
      'status': instance.status,
      'isBillControlFinish': instance.isBillControlFinish,
      'companyCurrent': instance.companyCurrent,
      'currency': instance.currency,
      'sonOnayHareket': instance.sonOnayHareket,
      'createdUserId': instance.createdUserId,
      'lastUpdatedUserId': instance.lastUpdatedUserId,
      'dataStatus': instance.dataStatus,
      'createdAt': instance.createdAt?.toIso8601String(),
      'lastUpdatedAt': instance.lastUpdatedAt,
      'createdUser': instance.createdUser,
      'lastUpdatedUser': instance.lastUpdatedUser,
    };

DispatchItems _$DispatchItemsFromJson(Map<String, dynamic> json) =>
    DispatchItems(
      receiptNumber: json['receiptNumber'] as String?,
      trackCode: json['trackCode'] as String?,
      purchaseRequestId: json['purchaseRequestId'] as int?,
      purchaseRequestStockId: json['purchaseRequestStockId'] as int?,
      acceptedAmount: json['acceptedAmount'] as double?,
      totalAmount: json['totalAmount'] as double?,
      amount: json['amount'] as double?,
      price: (json['price'] as num?)?.toDouble(),
      stockName: json['stockName'] as String?,
      unitName: json['unitName'] as String?,
      storeName: json['storeName'] as String?,
      stockId: json['stockId'] as int?,
      unitId: json['unitId'] as int?,
      storeId: json['storeId'] as int?,
      requesterUser: json['requesterUser'] as String?,
      taxRate: (json['taxRate'] as num?)?.toDouble(),
      aciklama: json['aciklama'] as String?,
      marka: json['marka'] as String?,
      isSelected: json['isSelected'] as bool?,
    );

Map<String, dynamic> _$DispatchItemsToJson(DispatchItems instance) =>
    <String, dynamic>{
      'receiptNumber': instance.receiptNumber,
      'trackCode': instance.trackCode,
      'purchaseRequestId': instance.purchaseRequestId,
      'purchaseRequestStockId': instance.purchaseRequestStockId,
      'acceptedAmount': instance.acceptedAmount,
      'totalAmount': instance.totalAmount,
      'amount': instance.amount,
      'price': instance.price,
      'stockName': instance.stockName,
      'unitName': instance.unitName,
      'storeName': instance.storeName,
      'stockId': instance.stockId,
      'unitId': instance.unitId,
      'storeId': instance.storeId,
      'requesterUser': instance.requesterUser,
      'taxRate': instance.taxRate,
      'aciklama': instance.aciklama,
      'marka': instance.marka,
      'isSelected': instance.isSelected,
    };

PurchaseRequestKey _$PurchaseRequestKeyFromJson(Map<String, dynamic> json) =>
    PurchaseRequestKey(
      value: (json['value'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$PurchaseRequestKeyToJson(PurchaseRequestKey instance) =>
    <String, dynamic>{
      'value': instance.value,
    };
