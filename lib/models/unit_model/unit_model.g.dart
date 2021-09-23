// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitModel _$UnitModelFromJson(Map<String, dynamic> json) => UnitModel(
      odataContext: json['odataContext'] as String?,
      value: (json['value'] as List<dynamic>?)
          ?.map((e) => UnitValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UnitModelToJson(UnitModel instance) => <String, dynamic>{
      'odataContext': instance.odataContext,
      'value': instance.value,
    };

UnitValue _$UnitValueFromJson(Map<String, dynamic> json) => UnitValue(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$UnitValueToJson(UnitValue instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
