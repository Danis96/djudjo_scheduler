// import 'dart:convert';
// import 'dart:io';
//
// import 'package:djudjo_scheduler/app/database/database_helper.dart';
// import 'package:djudjo_scheduler/app/locator.dart';
// import 'package:djudjo_scheduler/app/repositories/navigation_repo.dart';
// import 'package:djudjo_scheduler/app/utils/shared_prefs.dart';
// import 'package:djudjo_scheduler/config/constants.dart';
// import 'package:djudjo_scheduler/storageManager/storage_manager.dart';
// import 'package:http/http.dart' as http;
//
// import '../config/flavor_config.dart';
// import 'api_exceptions.dart';
//
// class HTTPClient {
//   static final HTTPClient _singleton = HTTPClient();
//
//   static HTTPClient get instance => _singleton;
//
//   final NavigationRepo _navigationService = locator<NavigationRepo>();
//   StorageManager storageManager = StorageManager();
//
//   Future<void> logout() async {
//     if (Platform.isIOS) {
//       Constants.platform.invokeMethod<void>('setShowNotifications', <String, dynamic>{
//         'showNotifications': false,
//       });
//     }
//     final DatabaseHelper databaseHelper = DatabaseHelper();
//     await databaseHelper.deleteDb(await databaseHelper.database);
//     StorageManager().deleteAll().then((dynamic value) {
//       SharedPref().setLanguage('en');
//       // todo
//       // _navigationService.navigateAndRemove(Welcome);
//     });
//   }
//
//   Future<dynamic> fetchData(String url, Map<String, String> headersType, {Map<String, String>? params}) async {
//     dynamic responseJson;
//
//     final String uri = FlavorConfig.instance.values.baseUrl + url + ((params != null) ? queryParameters(params) : '');
//     print('URLGET: ${uri}');
//     print(uri);
//     try {
//       final http.Response response = await http.get(Uri.parse(uri), headers: headersType);
//       //print(response.body.toString());
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> deleteData(String url, Map<String, String> headersType, {Map<String, String>? params}) async {
//     dynamic responseJson;
//
//     final String uri = FlavorConfig.instance.values.baseUrl + url + ((params != null) ? queryParameters(params) : '');
//     try {
//       final http.Response response = await http.delete(Uri.parse(uri), headers: headersType);
//       // print(response.body.toString());
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       throw FetchDataException('No Internet Connection');
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> postData(String url, dynamic body, Map<String, String> headerType) async {
//     final String apiBase = FlavorConfig.instance.values.baseUrl;
//     print('URLPOST: ${apiBase + url}');
//     dynamic responseJson;
//     try {
//       final http.Response response = await http.post(Uri.parse(apiBase + url), body: jsonEncode(body), headers: headerType);
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       throw InternetException('No internet connection');
//     } on Exception catch (_) {
//       rethrow;
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> putData(String url, dynamic body, Map<String, String> headerType) async {
//     final String apiBase = FlavorConfig.instance.values.baseUrl;
//     print('URLPUT: ${apiBase + url}');
//     dynamic responseJson;
//     try {
//       final http.Response response = await http.put(Uri.parse(apiBase + url), body: jsonEncode(body), headers: headerType);
//       responseJson = _returnResponse(response);
//     } on SocketException {
//       throw InternetException('No internet connection');
//     } on Exception catch (_) {
//       rethrow;
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> postMultipartData(String url, Map<String, String> body, Map<String, String> headerType) async {
//     //print(body.toString());
//     final String apiBase = FlavorConfig.instance.values.baseUrl;
//     dynamic responseJson;
//     try {
//       final Uri uri = Uri.parse(apiBase + url);
//       final http.MultipartRequest request = http.MultipartRequest('POST', uri)..fields.addAll(body);
//       final http.StreamedResponse response = await request.send();
//       final http.Response parserResponse = await http.Response.fromStream(response);
//       responseJson = _returnResponse(parserResponse);
//     } on SocketException {
//       throw InternetException('No internet connection');
//     } on Exception catch (_) {
//       rethrow;
//     }
//     return responseJson;
//   }
//
//   Future<dynamic> postMultipartImage(String url, Map<String, String> headerType, String imageFile) async {
//     print(imageFile);
//     final String apiBase = FlavorConfig.instance.values.baseUrl;
//     dynamic responseJson;
//     try {
//       final Uri uri = Uri.parse(apiBase + url);
//       final http.MultipartRequest request = http.MultipartRequest('POST', uri)
//         ..files.add(await http.MultipartFile.fromPath('image', imageFile));
//       request.headers.addAll(headerType);
//       final http.StreamedResponse response = await request.send();
//       final http.Response parserResponse = await http.Response.fromStream(response);
//       responseJson = _returnResponse(parserResponse);
//       //print(responseJson);
//     } on SocketException {
//       throw InternetException('No internet connection');
//     } on Exception catch (_) {
//       rethrow;
//     }
//     return responseJson;
//   }
//
//   String queryParameters(Map<String, String> params) {
//     if (params != null) {
//       final Uri jsonString = Uri(queryParameters: params);
//       return '?${jsonString.query}';
//     }
//     return '';
//   }
//
//   dynamic _returnResponse(http.Response response) async {
//     print(response.statusCode.toString());
//     final bool logged = await storageManager.getValue(StorageManager.USER_DATA_KEY).then(
//       (String value) {
//         return value != null && value != '';
//       },
//     );
//     switch (response.statusCode) {
//       case 200:
//         try {
//           final dynamic responseJson = json.decode(utf8.decode(response.bodyBytes));
//           return responseJson ?? '';
//         } catch (e) {
//           return;
//         }
//         break;
//       case 201:
//         final dynamic responseJson = json.decode(response.body.toString());
//         return responseJson;
//       case 400:
//         final dynamic responseJson = json.decode(response.body.toString());
//         throw BadRequestValidationException.fromJson(responseJson);
//       case 401:
//         if (logged) {
//           logout();
//           print('Logout: ${response.body.toString()}');
//           return null;
//         } else {
//           final dynamic responseJson = json.decode(response.body.toString());
//           throw BadRequestValidationException.fromJson(responseJson, code: response.statusCode);
//         }
//         break;
//       case 403:
//         throw UnauthorisedException(response.body.toString());
//       case 500:
//       default:
//         throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
//     }
//   }
// }
