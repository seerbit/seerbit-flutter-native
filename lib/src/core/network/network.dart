import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:seerbit_flutter_native/src/models/custom_response_model.dart';

class Network {
  final http.Client? _client;
  // final Api baseApi = const Api.dev();

  const Network([this._client]);

  Future<http.Response> post(String url,
      {String? token,
      Map? body,
      Map<String, String>? headers,
      bool useBaseUrl = false}) async {
    http.Client client = _client ?? http.Client();

    try {
      log(body.toString());
      log(headers.toString());
      http.Response response = await client
          .post(Uri.parse(url),
              headers: headers ?? _generateHeaders(token),
              body: jsonEncode(body))
          .timeout(const Duration(seconds: 35),
              onTimeout: () => Future.delayed(
                  const Duration(seconds: 1),
                  () => throw (CustomResponse(
                      false, 'Check your internet connection 🥲'))));
      log(response.body.toString());
      if ([201, 200, 202].contains(response.statusCode)) {
        return response;
      } else {
        log("Something happened here 1 ${response.statusCode}");
        return Future.error(response);
      }
    } on SocketException {
      log("Something happened here");
      throw (CustomResponse(false, 'Check your internet connection 🥲'));
    } on TimeoutException {
      log("Something happened here");
      throw (CustomResponse(false, 'Check your internet connection 🥲'));
    } catch (e) {
      log("Something happened here");
      throw (Exception(e.toString()));
    }
  }

  Future<http.Response> get(String url,
      {String? token, Map<String, String>? headers}) async {
    http.Client client = _client ?? http.Client();
    log(url);
    log(headers.toString());
    log(_generateHeaders(token).toString());
    try {
      http.Response response = await client
          .get(Uri.parse(url), headers: headers ?? _generateHeaders(token))
          .timeout(const Duration(seconds: 60),
              onTimeout: () => Future.delayed(
                  const Duration(seconds: 1),
                  () => throw (CustomResponse(
                      false, 'Check your internet connection 🥲'))));

      log(response.body.toString());

      if ([201, 200].contains(response.statusCode)) return response;

      throw (CustomResponse(false, jsonDecode(response.body)['message']));
    } on SocketException {
      throw (CustomResponse(false, 'Network time out'));
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<http.Response> patch(String url, {String? token, Map? body}) async {
    http.Client client = _client ?? http.Client();

    try {
      http.Response response = await client
          .patch(Uri.parse(url),
              headers: _generateHeaders(token), body: jsonEncode(body))
          .timeout(const Duration(seconds: 60));
      log(url);
      log(body.toString());
      log(response.toString());
      if ([201, 200].contains(response.statusCode)) return response;
      throw (CustomResponse(false, jsonDecode(response.body)['message']));
    } on SocketException {
      throw (CustomResponse(false, 'Network time out'));
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }

  Future<http.Response> delete(String url, {String? token, Map? body}) async {
    http.Client client = _client ?? http.Client();
    try {
      http.Response response = await client
          .delete(Uri.parse(url),
              headers: _generateHeaders(token), body: jsonEncode(body))
          .timeout(const Duration(seconds: 60));
      log(body.toString());
      log(response.body.toString());
      if ([201, 200].contains(response.statusCode)) return response;
      throw (CustomResponse(false, jsonDecode(response.body)['message']));
    } on SocketException {
      throw (CustomResponse(false, 'Network time out'));
    } catch (e) {
      throw (Exception(e.toString()));
    }
  }
}

///Generates headers given a Bearer token
Map<String, String> _generateHeaders(String? token) {
  return {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization':
        'Bearer 68826aea9005de7812429b7983838b06e2c7fffbb3d9487f33bc51c943a3a499'
  };
}
