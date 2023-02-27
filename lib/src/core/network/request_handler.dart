import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:seerbit_flutter_native/src/models/response_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RequestHandler {
  final Future<ResponseModel> Function() request;
  final bool removeFocus, showProgress;
  final ValueSetter<ResponseModel> onSuccess;
  final ValueSetter<ResponseModel> onError, onNetworkError;
  final Function()? onRequestStart, onRequestEnd;

  RequestHandler({
    required this.request,
    required this.onSuccess,
    required this.onError,
    required this.onNetworkError,
    this.showProgress = false,
    this.removeFocus = true,
    this.onRequestStart,
    this.onRequestEnd,
  });

  Future<void> sendRequest() async {
    if (removeFocus) FocusManager.instance.primaryFocus?.unfocus();

    try {
      onRequestStart?.call();
      ResponseModel result = await request.call();

      onSuccess(result);
    } on SocketException {
      onNetworkError(ResponseModel(
          data: {"message": "Check your internet connection"}, status: 400));
    } on TimeoutException {
      onNetworkError(ResponseModel(
          data: {"message": "Connection timed out"}, status: 400));
    } on HandshakeException {
      onNetworkError(ResponseModel(
          data: {"message": "Unable to connect to the internet"}, status: 400));
    } catch (e) {
      // log("An error occured");
      // log(e.toString());
      if (e.runtimeType == Response) {
        onError(ResponseModel(
            data: jsonDecode((e as Response).body), status: (e).statusCode));
        return;
      }
      onError(ResponseModel(
          data: {"message": "Check your internet connection"}, status: 400));
      onRequestEnd?.call();
    } finally {
      log("Network Call Terminated >>> Request Ended::");
      // onRequestEnd?.call();
    }
    onRequestEnd?.call();
  }
}
