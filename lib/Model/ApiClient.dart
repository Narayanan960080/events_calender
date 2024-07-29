import 'dart:convert';
import 'dart:developer';
import 'dart:io';



import 'package:dio/dio.dart';
import 'package:dio/io.dart';

import 'ApiException.dart';
import 'ServerURL.dart';

class ApiClient {

  final Dio dio = Dio();

  Future<dynamic> fetchDataWithoutEncryption(
      String url, Map<String, dynamic> params) async {
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return null;
    };
    var body = json.encode(params);
    Map<String, dynamic>? headers;

    try {
      var response =
          await dio.post(url, data: params, options: Options(headers: headers));
      printLog(list: [
        '\x1B[32m$url\x1B[0m',
        jsonEncode(params),
        body,
        '\x1B[33m${response.toString()}\x1B[0m'
      ]);

      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } catch (err) {
      // auditLog(url, err.toString(), {}, params);
    }
  }

  Future<dynamic> fetchGetData(String url, Map<String, dynamic> params) async {
    var body = json.encode(params);
    print('\x1B[33m$body\x1B[0m');
    print('\x1B[33m$url\x1B[0m');
    try {
      var response = await dio.get(url, data: body);
      print('\x1B[32m${response.data}\x1B[0m');
      return returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }


  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response.data;
        return json.encode(responseJson);
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.toString());
      case 404:
        throw UnauthorisedException(response.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }

  void printLog({required List<String> list}) {
    for (var logData in list) {
      log(logData);
    }
  }
}


