import 'dart:convert';

import 'package:http/http.dart';

class ResponseModel {
  final Map data;
  final int status;

  ResponseModel({required this.data, required this.status});

  factory ResponseModel.fromResponse(Response response) {
    return ResponseModel(
        status: response.statusCode, data: jsonDecode(response.body));
  }
}
