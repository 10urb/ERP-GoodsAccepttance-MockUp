// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      odataContext: json['odataContext'] as String?,
      registerResponseValue: (json['value'] as List<dynamic>?)
          ?.map(
              (e) => RegisterResponseValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'odataContext': instance.odataContext,
      'value': instance.registerResponseValue,
    };

RegisterResponseValue _$RegisterResponseValueFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseValue(
      id: json['id'] as int?,
      ad: json['ad'] as String?,
      soyad: json['soyad'] as String?,
      unvan: json['unvan'] as String?,
      sicilKod: json['sicilKod'] as String?,
    );

Map<String, dynamic> _$RegisterResponseValueToJson(
        RegisterResponseValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ad': instance.ad,
      'soyad': instance.soyad,
      'unvan': instance.unvan,
      'sicilKod': instance.sicilKod,
    };
