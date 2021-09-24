import 'package:erp_mockup/environments/environment.dart';
import 'package:http/http.dart' as http;

class MarketPlaceService {
  Future<http.Response> getMarketPrice() async {
    var uri = Environment.baseUrl +
        "StockMarketplacePriceLog?%24select=lowestPrice%2CrequestDate&%24expand=stockMarketplacePrice(%24select%3DstockId%3B%24expand%3DstockMarketplaceGroupDiscount(%24select%3DisConstantPrice%2CconstantPrice%2Cdiscount_1%2Cdiscount_2%2Cdiscount_3%2Cdiscount_4))&%24filter=((requestDate%20gt%202021-09-13T02%3A59%3A59.990Z)%20and%20(requestDate%20lt%202021-09-14T02%3A59%3A59.990Z))%20and%20(dataStatus%20eq%20%27Activated%27)%20and%20(stockMarketplacePriceSource%20eq%20%27AntalyaHal%27)";
    return await http.get(Uri.parse(uri), headers: Environment.apiHeader);
  }
}
