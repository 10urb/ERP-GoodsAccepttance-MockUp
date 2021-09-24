import 'package:erp_mockup/environments/environment.dart';
import 'package:http/http.dart' as http;

class SearchService {
  late String companyName;
  SearchService();

  SearchService.serachWithCompanyName({required this.companyName});

  Future<http.Response> getSearchExpectedCompaniesWithName() async {
    var url = Environment.baseUrl +
        "PurchaseRequestCompany/GetWaitedCompanies?%24top=15&%24select=id%2Cunvan&%24filter=(startsWith(tolower(unvan)%2C%27$companyName%27))";

    return await http.get(Uri.parse(url), headers: Environment.apiHeader);
  }
}
