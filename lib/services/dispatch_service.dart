import 'dart:convert';

import 'package:erp_mockup/environments/environment.dart';
import 'package:erp_mockup/models/dispatch_model/dispatch_model.dart';
import 'package:erp_mockup/models/new_dispatch_model/new_dispatch_model.dart';
import 'package:http/http.dart' as http;

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
