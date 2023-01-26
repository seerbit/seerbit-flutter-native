import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class RequestHandler {
  final Function() request;
  final bool removeFocus, showProgress;
  final ValueSetter<Map> onSuccess;
  final ValueSetter<Map> onError, onNetworkError;
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
      // if (showProgress) Modals().progressToast();
      onRequestStart?.call();
      Map result = await request.call();
      onSuccess(result);
    } on SocketException {
      onNetworkError({"message": "Check your internet connection"});
    } on TimeoutException {
      onNetworkError({"message": "Check your internet connection"});
    } on HandshakeException {
      onNetworkError({"message": "Check your internet connection"});
    } catch (e) {
      log(e.toString());
      onError({"message": "An unexpected error occured"});
      onRequestEnd?.call();
    } finally {
      log("Network Call Terminated >>> Request Ended::");
      // onRequestEnd?.call();
    }
    onRequestEnd?.call();
  }
}
