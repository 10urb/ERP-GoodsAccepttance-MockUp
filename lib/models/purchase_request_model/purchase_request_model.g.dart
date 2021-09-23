// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseRequestModel _$PurchaseRequestModelFromJson(
        Map<String, dynamic> json) =>
    PurchaseRequestModel(
      odataContext: json['odataContext'] as String,
      value: (json['value'] as List<dynamic>)
          .map((e) => PurchaseRequestValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseRequestModelToJson(
        PurchaseRequestModel instance) =>
    <String, dynamic>{
      'odataContext': instance.odataContext,
      'value': instance.value,
    };

PurchaseRequestTrack _$PurchaseRequestTrackFromJson(
        Map<String, dynamic> json) =>
    PurchaseRequestTrack(
      code: json['code'] as String,
    );

Map<String, dynamic> _$PurchaseRequestTrackToJson(
        PurchaseRequestTrack instance) =>
    <String, dynamic>{
      'code': instance.code,
    };

PurchaseRequestValue _$PurchaseRequestValueFromJson(
        Map<String, dynamic> json) =>
    PurchaseRequestValue(
      id: json['id'] as int,
      purchaseRequestTrackId: json['purchaseRequestTrackId'] as int,
      deadline: json['deadline'] as String,
      isSelected: json['isSelected'] as bool,
      purchaseRequestTrack: PurchaseRequestTrack.fromJson(
          json['purchaseRequestTrack'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurchaseRequestValueToJson(
        PurchaseRequestValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purchaseRequestTrackId': instance.purchaseRequestTrackId,
      'deadline': instance.deadline,
      'isSelected': instance.isSelected,
      'purchaseRequestTrack': instance.purchaseRequestTrack,
    };
