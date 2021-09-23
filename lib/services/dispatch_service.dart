import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:insoftpro_sueno_erp/environments/environment.dart';
import 'package:insoftpro_sueno_erp/models/dispatch_model/dispatch_model.dart';
import 'package:insoftpro_sueno_erp/models/new_dispatch_model/new_dispatch_model.dart';

class DispatchService {
  List<int>? receiptNumbers;

  DispatchService({this.receiptNumbers});

  Future<http.Response> postGenerateDispatch() {
    var toJson = PurchaseRequestKey(value: receiptNumbers!).toJson();

    var url = Environment.baseUrl + "Dispatch/GenerateDispatchFromRequest";

    return http.post(Uri.parse(url),
        headers: Environment.apiHeader, body: jsonEncode(toJson));
  }

  Future<http.Response> postSaveDispatchFromRequest(
      NewDispatchModel newDispatchModel) {
    var url = Environment.baseUrl + "Dispatch/SaveDispatchFromRequest";
    var tojson = jsonEncode(newDispatchModel.toJson());
    return http.post(Uri.parse(url),
        headers: Environment.apiHeader, body: tojson);
  }
}
