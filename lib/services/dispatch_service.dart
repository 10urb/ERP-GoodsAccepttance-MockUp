import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:erp-mockup___erp/environments/environment.dart';
import 'package:erp-mockup___erp/models/dispatch_model/dispatch_model.dart';
import 'package:erp-mockup___erp/models/new_dispatch_model/new_dispatch_model.dart';

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
