// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:erp_mockup/environments/environment.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<http.Response> postLogin(String email, String password) {
    return http.post(Uri.parse(Environment.baseUrl + 'User/Authenticate'),
        headers: Environment.apiHeader,
        body: jsonEncode({"email": email, "password": password}));
  }
}
