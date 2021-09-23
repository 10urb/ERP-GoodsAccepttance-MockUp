import 'package:erp-mockup___erp/helpers/locale_manager.dart';

class Environment {
  static String tokenValue =
      LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
  Environment();

  static const baseUrl = 'baseapiurl';
  static var apiHeader = {
    "api-version": "1.0",
    "content-type": "application/json; charset=utf-8",
    "Authorization": "Bearer $tokenValue"
  };

  static var apiHeaderFormData = {
    "api-version": "1.0",
    "content-type": "multipart/form-data",
    "Authorization": "Bearer $tokenValue",
  };

  static const chunkMetaData = {
    "FileName": "samplepp.PNG",
    "Index": 1,
    "TotalCount": 2,
    "FileSize": 90237,
    "FileType": "image/png",
    "FileGuid": "1991ea78-8a8b-9e5b-11f5-dee9e85d282d"
  };

//Color codes
  static const borderSideColor = 0xFF6299AA;
  static const labelStyleColor = 0xFF1299ff;
}
