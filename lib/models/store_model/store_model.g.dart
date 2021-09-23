// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreModel _$StoreModelFromJson(Map<String, dynamic> json) => StoreModel(
      odataContext: json['odataContext'] as String?,
      value: (json['value'] as List<dynamic>?)
          ?.map((e) => StoreValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreModelToJson(StoreModel instance) =>
    <String, dynamic>{
      'odataContext': instance.odataContext,
      'value': instance.value,
    };

StoreValue _$StoreValueFromJson(Map<String, dynamic> json) => StoreValue(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StoreValueToJson(StoreValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
