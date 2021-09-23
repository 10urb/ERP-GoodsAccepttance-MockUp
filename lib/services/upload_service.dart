import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:insoftpro_sueno_erp/environments/environment.dart';

import 'package:async/async.dart';
import 'dart:convert';

class UploadService {
  Future<dio.Response> postImage(XFile photoFile) async {
    String test =
        "{\"FileName\":\"samplepp.PNG\",\"Index\":1,\"TotalCount\":2,\"FileSize\":90237,\"FileType\":\"image/png\",\"FileGuid\":\"1991ea78-8a8b-9e5b-11f5-dee9e85d282d\"}";
    String fileName = photoFile.path.split('/').last;
    var apiHeaderFormData = {
      "api-version": "1.0",
      "Content-Type": "multipart/form-data",
      'Content-Lenght': File(photoFile.path).lengthSync().toString(),
      "Authorization": "Bearer ${Environment.tokenValue}",
    };
    print("APİ HEADER" + apiHeaderFormData.toString());
    dio.FormData formData = dio.FormData.fromMap({
      "file":
          await dio.MultipartFile.fromFile(photoFile.path, filename: fileName),
      "chunkMetadata": test
    });
    var response = await dio.Dio().post(
        "http://erp.sueno.com.tr/api/docs/documents/upload",
        data: formData,
        options: dio.Options(headers: apiHeaderFormData));

    return response;
  }

  Future postImage2(XFile imageFile) async {
    var stream = http.ByteStream(Stream.castFrom(imageFile.openRead()));
    // get file length
    var length = await imageFile.length(); //imageFile is your image file
    Map<String, String> headers = {
      "Accept": "application/json",
      "Authorization": "Bearer " + Environment.tokenValue
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(Environment.baseUrl + "docs/documents/upload");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = http.MultipartFile('profile_pic', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields['loginId'] = '12';
    request.fields['firstName'] = 'abc';
    // request.fields['lastName'] = 'efg';

    // send
    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    print(response.contentLength);
    print(response.stream);
    print(response.headers);
    print(response.statusCode);

    return response;
  }

  Future postImage3(XFile imageFile) async {}
}
