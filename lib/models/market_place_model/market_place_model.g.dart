// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketPlaceModel _$MarketPlaceModelFromJson(Map<String, dynamic> json) =>
    MarketPlaceModel(
      odataContext: json['odataContext'] as String?,
      marketPlaceValue: (json['value'] as List<dynamic>?)
          ?.map((e) => MarketPlaceValue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MarketPlaceModelToJson(MarketPlaceModel instance) =>
    <String, dynamic>{
      'odataContext': instance.odataContext,
      'value': instance.marketPlaceValue,
    };

MarketPlaceValue _$MarketPlaceValueFromJson(Map<String, dynamic> json) =>
    MarketPlaceValue(
      lowestPrice: (json['lowestPrice'] as num?)?.toDouble(),
      requestDate: json['requestDate'] == null
          ? null
          : DateTime.parse(json['requestDate'] as String),
      stockMarketplacePrice: json['stockMarketplacePrice'] == null
          ? null
          : StockMarketplacePrice.fromJson(
              json['stockMarketplacePrice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MarketPlaceValueToJson(MarketPlaceValue instance) =>
    <String, dynamic>{
      'lowestPrice': instance.lowestPrice,
      'requestDate': instance.requestDate?.toIso8601String(),
      'stockMarketplacePrice': instance.stockMarketplacePrice,
    };

StockMarketplacePrice _$StockMarketplacePriceFromJson(
        Map<String, dynamic> json) =>
    StockMarketplacePrice(
      stockId: json['stockId'] as int?,
      stockMarketplaceGroupDiscount: json['stockMarketplaceGroupDiscount'] ==
              null
          ? null
          : StockMarketplaceGroupDiscount.fromJson(
              json['stockMarketplaceGroupDiscount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StockMarketplacePriceToJson(
        StockMarketplacePrice instance) =>
    <String, dynamic>{
      'stockId': instance.stockId,
      'stockMarketplaceGroupDiscount': instance.stockMarketplaceGroupDiscount,
    };

StockMarketplaceGroupDiscount _$StockMarketplaceGroupDiscountFromJson(
        Map<String, dynamic> json) =>
    StockMarketplaceGroupDiscount(
      isConstantPrice: json['isConstantPrice'] as bool?,
      constantPrice: json['constantPrice'] as int?,
      discount1: json['discount_1'] as int?,
      discount2: json['discount_2'] as int?,
      discount3: json['discount_3'] as int?,
      discount4: json['discount_4'] as int?,
    );

Map<String, dynamic> _$StockMarketplaceGroupDiscountToJson(
        StockMarketplaceGroupDiscount instance) =>
    <String, dynamic>{
      'isConstantPrice': instance.isConstantPrice,
      'constantPrice': instance.constantPrice,
      'discount1': instance.discount1,
      'discount2': instance.discount2,
      'discount3': instance.discount3,
      'discount4': instance.discount4,
    };
