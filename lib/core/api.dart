// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:complecionista/config/app_flavor.dart';
import 'package:complecionista/config/app_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

const DEFAULT_TIMEOUT_TIME = Duration(minutes: 1);
const REFRESHTOKEN_TIMEOUT_TIME = Duration(seconds: 15);
const int DEFAULT_QTD_TRIES = 1;
const STATUS_CODE_SUCCESS = [200, 201, 204];

enum RequestMethod {
  GET,
  POST,
  PUT,
  DELETE,
}

class Api {
  AppPreferences preferences = Modular.get<AppPreferences>();
  static String? token;
  static Map<String, String> urls = {};
  static String apiKey = '';

  Api();

  initApi() async {
    urls = await Modular.get<AppFlavor>().getUrlBase();
    token = await preferences.getToken();
  }

  Future<dynamic> getApi(String apiName, String endpoint, {bool useAuth = true}) async {
    if (useAuth) {
      if (token == null) throw Exception('Authentication not performed yet.');
      var json = await tryToMakeRequest(RequestMethod.GET, urls[apiName]! + endpoint);
      return json;
    } else {
      var json = await tryToMakeRequest(RequestMethod.GET, urls[apiName]! + endpoint, headers: getDefaultHeaders(withToken: false));
      return json;
    }
  }

  Future<dynamic> postApi(String apiName, String endpoint, Map<String, dynamic> data, {bool useAuth = true, Map<String, String>? headers}) async {
    if (useAuth) {
      if (token == null) throw Exception('Authentication not performed yet.');
      var json = await tryToMakeRequest(RequestMethod.POST, urls[apiName]! + endpoint, body: data);
      return json;
    } else {
      var json = await tryToMakeRequest(RequestMethod.POST, urls[apiName]! + endpoint, body: data, headers: headers ?? getDefaultHeaders(withToken: false));
      return json;
    }
  }

  Future<dynamic> putApi(String apiName, String endpoint, Map<String, dynamic> data) async {
    if (token == null) throw Exception('Authentication not performed yet.');
    var json = await tryToMakeRequest(RequestMethod.PUT, urls[apiName]! + endpoint, body: data);
    return json;
  }

  Future<dynamic> deleteApi(String apiName, String endpoint, Map<String, dynamic> data) async {
    if (token == null) throw Exception('Authentication not performed yet.');
    var json = await tryToMakeRequest(RequestMethod.DELETE, urls[apiName]! + endpoint, body: data);
    return json;
  }

  static Future<dynamic> tryToMakeRequest(
    RequestMethod method,
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    Response? resp;
    for (var i = 0; i < DEFAULT_QTD_TRIES; i++) {
      try {
        resp = await makeRequest(method, url, headers: headers, body: body).timeout(DEFAULT_TIMEOUT_TIME);
        if (!STATUS_CODE_SUCCESS.contains(resp.statusCode)) {
          log(resp.statusCode.toString());
          log(resp.statusMessage.toString());
          break;
        } else {
          break;
        }
      } on TimeoutException catch (_) {
        // A timeout occurred.
        resp = _onTimeout();
      } on SocketException catch (_) {
        // Other exception
        _onInternetFailed();
      }
      if (resp != null) break;
    }

    if (resp == null) return null;
    try {
      return resp;
    } catch (e) {
      return null;
    }
  }

  static Future<Response> makeRequest(
    RequestMethod method,
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    log('$method - $url');
    headers ??= getDefaultHeaders();
    Dio client = Modular.get<Dio>();
    Response resp;
    try {
      switch (method) {
        case RequestMethod.GET:
          resp = await client.get(url, options: Options(headers: headers));
          break;
        case RequestMethod.POST:
          resp = await client.post(url, options: Options(headers: headers), data: body);
          break;
        case RequestMethod.DELETE:
          resp = await client.delete(url, options: Options(headers: headers));
          break;
        case RequestMethod.PUT:
          resp = await client.put(url, options: Options(headers: headers), data: body);
          break;
        default:
          throw const SocketException('METHOD NOT SUPPORTED');
      }
    } on DioError catch (e) {
      String message = '';
      var data = {};
      if (e.response != null) {
        data = e.response!.data is String
            ? e.response!.data.isNotEmpty
                ? {"message": e.response!.data}
                : {}
            : e.response!.data ?? {};
        switch (e.response?.statusCode) {
          case 400:
            message = e.response?.statusMessage ?? 'Erro inesperado';
            break;
          case 401:
            message = e.response?.statusMessage ?? 'Sem autorização';
            break;
          case 404:
            message = e.response?.statusMessage ?? 'Não encontrado';
            break;
          case 408:
            message = e.response?.statusMessage ?? 'Timeout';
            break;
          case 409:
            message = e.response?.statusMessage ?? 'Conflict';
            break;
          case 500:
            message = e.response?.statusMessage ?? 'Internal Error';
            break;
          case 503:
            message = e.response?.statusMessage ?? 'Service Unavailable';
            break;
          case 504:
            message = e.response?.statusMessage ?? 'Gateway Timeout';
            break;
          default:
            message = e.response?.statusMessage ?? 'Unkown';
            break;
        }
      } else {
        message = 'Unkown';
      }
      resp = Response(
        statusMessage: message,
        statusCode: e.response?.statusCode,
        data: data,
        headers: e.response?.headers,
        requestOptions: RequestOptions(path: ''),
      );
      sendLogError(resp);
    }
    return resp;
  }

  static sendLogError(Response resp) {
    // TODO: add send log error
  }

  static Map<String, String> getDefaultHeaders({bool withToken = true}) {
    if (withToken) {
      return {
        'Authorization': 'Bearer $token',
        'Content-Type': "application/json; charset=utf-8",
        'accept': 'application/json, text/plain, */*',
      };
    } else {
      return {
        'Content-Type': "application/json; charset=utf-8",
        'accept': 'application/json, text/plain, */*',
      };
    }
  }

  static _onTimeout() {
    log('TIMEOUT!');
    return Response(
      statusMessage: 'Timeout',
      statusCode: 408,
      requestOptions: RequestOptions(path: ''),
    );
  }

  static _onInternetFailed() {
    log("CONNECTION FAILED!");
  }
}
