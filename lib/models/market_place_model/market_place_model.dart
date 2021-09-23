import 'package:json_annotation/json_annotation.dart';

part 'market_place_model.g.dart';

@JsonSerializable()
class MarketPlaceModel {
  MarketPlaceModel({
    this.odataContext,
    this.marketPlaceValue,
  });

  String? odataContext;
  List<MarketPlaceValue>? marketPlaceValue;
  factory MarketPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$MarketPlaceModelFromJson(json);
  Map<String, dynamic> toJson() => _$MarketPlaceModelToJson(this);
}

@JsonSerializable()
class MarketPlaceValue {
  MarketPlaceValue({
    this.lowestPrice,
    this.requestDate,
    this.stockMarketplacePrice,
  });

  double? lowestPrice;
  DateTime? requestDate;
  StockMarketplacePrice? stockMarketplacePrice;

  factory MarketPlaceValue.fromJson(Map<String, dynamic> json) =>
      _$MarketPlaceValueFromJson(json);
  Map<String, dynamic> toJson() => _$MarketPlaceValueToJson(this);
}

@JsonSerializable()
class StockMarketplacePrice {
  StockMarketplacePrice({
    this.stockId,
    this.stockMarketplaceGroupDiscount,
  });

  int? stockId;
  StockMarketplaceGroupDiscount? stockMarketplaceGroupDiscount;

  factory StockMarketplacePrice.fromJson(Map<String, dynamic> json) =>
      _$StockMarketplacePriceFromJson(json);
  Map<String, dynamic> toJson() => _$StockMarketplacePriceToJson(this);
}

@JsonSerializable()
class StockMarketplaceGroupDiscount {
  StockMarketplaceGroupDiscount({
    this.isConstantPrice,
    this.constantPrice,
    this.discount1,
    this.discount2,
    this.discount3,
    this.discount4,
  });

  bool? isConstantPrice;
  int? constantPrice;
  int? discount1;
  int? discount2;
  int? discount3;
  int? discount4;

  factory StockMarketplaceGroupDiscount.fromJson(Map<String, dynamic> json) =>
      _$StockMarketplaceGroupDiscountFromJson(json);
  Map<String, dynamic> toJson() => _$StockMarketplaceGroupDiscountToJson(this);
}
