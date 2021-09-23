// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyModel _$CurrencyModelFromJson(Map<String, dynamic> json) =>
    CurrencyModel(
      odataContext: json['odataContext'] as String?,
      currencyValue: (json['value'] as List<dynamic>?)
          ?.map((e) => CurrencyValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrencyModelToJson(CurrencyModel instance) =>
    <String, dynamic>{
      'odataContext': instance.odataContext,
      'value': instance.currencyValue,
    };

CurrencyValue _$CurrencyValueFromJson(Map<String, dynamic> json) =>
    CurrencyValue(
      id: json['id'] as int?,
      sembol: json['sembol'] as String?,
      kod: json['kod'] as String?,
    );

Map<String, dynamic> _$CurrencyValueToJson(CurrencyValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sembol': instance.sembol,
      'kod': instance.kod,
    };
