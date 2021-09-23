import 'package:http/http.dart' as http;
import 'package:erp-mockup___erp/environments/environment.dart';

class CurrencyService {
  CurrencyService();

  Future<http.Response> getCurrencies() async {
    var uri = Environment.baseUrl + "DovizTip()?%24select=id%2Csembol%2Ckod";
    return await http.get(Uri.parse(uri), headers: Environment.apiHeader);
  }

  Future<http.Response> getCurrencyWithId(int currencyId) async {
    var uri = Environment.baseUrl +
        "DovizTip($currencyId)?%24select=id%2Csembol%2Ckod";
    return await http.get(Uri.parse(uri), headers: Environment.apiHeader);
  }
}
