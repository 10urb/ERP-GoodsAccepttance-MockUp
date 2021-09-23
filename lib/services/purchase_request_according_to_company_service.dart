import 'package:http/http.dart' as http;
import 'package:insoftpro_sueno_erp/environments/environment.dart';

class PurchaseRequestAccordingToCompanyService {
  int? companyId;
  int? receiptNumber;

  PurchaseRequestAccordingToCompanyService.getPurchaseRequestAccordingToCompany(
      {this.companyId, this.receiptNumber});

  PurchaseRequestAccordingToCompanyService();

  Future<http.Response> getPurchaseRequestAccordingToCompany() {
    var url = Environment.baseUrl +
        'PurchaseRequestCompany?%24orderby=deadline%20desc&%24top=50&%24select=id%2CpurchaseRequestTrackId%2Cdeadline&%24expand=purchaseRequestTrack(%24select%3Dcode)&%24filter=(dataStatus%20eq%20%27Activated%27)%20and%20(companyId%20eq%20$companyId)%20and%20(purchaseRequestTrack%2FdataStatus%20eq%20%27Activated%27)%20and%20(purchaseRequestCompanyOffers%2Fany(b%3Ab%2FisAccepted%20eq%20true%20and%20b%2FdataStatus%20eq%20%27Activated%27%20and%20b%2FpurchaseRequestStock%2FpurchaseRequestTrackId%20gt%200%20and%20b%2FpurchaseRequestStock%2FpurchaseRequestTrack%2FlastMovement%2FpurchaseRequestStepId%20ne%20%27GoodsAcceptence%27)%20eq%20true)&%24count=true';
    return http.get(Uri.parse(url), headers: Environment.apiHeader);
  }

  Future<http.Response> getPurchaseRequestDetail() async {
    var url = Environment.baseUrl +
        "PurchaseRequestCompanyOffer?%24select=id%2Cprice%2Camount%2CacceptedAmount%2Cnote&%24expand=purchaseRequestStock(%24expand%3Dstock(%24select%3Dname)%2Cunit(%24select%3Dname))&%24filter=(purchaseRequestCompanyId%20eq%20$receiptNumber)%20and%20(isAccepted%20eq%20true)%20and%20(dataStatus%20eq%20%27Activated%27)";
    return await http.get(Uri.parse(url), headers: Environment.apiHeader);
  }
}
