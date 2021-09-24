import 'package:erp_mockup/environments/environment.dart';
import 'package:http/http.dart' as http;

class RegisterService {
  RegisterService();
  Future<http.Response> getRegisters() async {
    var uri = Environment.baseUrl +
        "Sicil?%24&%24select=id%2Cad%2Csoyad%2Cunvan%2CsicilKod&%24filter=((contains(tolower(ad)%2C%27%27))%20or%20(contains(tolower(soyad)%2C%27%27))%20or%20(contains(tolower(unvan)%2C%27%27))%20or%20(contains(tolower(sicilKod)%2C%27%27)))%20and%20(isCari%20eq%20true)";
    return await http.get(Uri.parse(uri), headers: Environment.apiHeader);
  }

  Future<http.Response> getRegisterWithId(int registerId) async {
    var uri = Environment.baseUrl +
        "Sicil($registerId)?%24select=id%2Cad%2Csoyad%2Cunvan%2CsicilKod";
    return await http.get(Uri.parse(uri), headers: Environment.apiHeader);
  }
}
