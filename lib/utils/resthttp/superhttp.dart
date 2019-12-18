import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:exchanger2/utils/resthttp/constants.dart';
import 'package:exchanger2/utils/resthttp/model/clienterror.dart';
import 'package:exchanger2/utils/resthttp/model/valorerror.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

void initilize(){
  
}

Future<ResponseOrError> get(String url,
    {Map<String, String> headers}) async {
  dynamic error;
  dynamic resorerror =
      await _get(url, headers: headers)
          .catchError((err) {
    error = err;
    return null;
  });
  try {
    error as ResponseOrError;
    resorerror as ResponseOrError;
    if (error != null) {
      return Future.error(error as ResponseOrError);
    } else {
      return Future.value(resorerror as ResponseOrError);
    }
  } catch (e) {
    return _futureOnError(NetworkError(UNKNOWN_ERROR_HEADER));
  }
}
Future<ResponseOrError> post(String url,
    {Map<String, String> headers, Encoding encoding, dynamic body}) async {
  dynamic error;
  dynamic resorerror =
      await _post(url, headers: headers, encoding: encoding, body: body)
          .catchError((err) {
    error = err;
    return null;
  });
  try {
    error as ResponseOrError;
    resorerror as ResponseOrError;
    if (error != null) {
      return Future.error(error as ResponseOrError);
    } else {
      return Future.value(resorerror as ResponseOrError);
    }
  } catch (e) {
    return _futureOnError(NetworkError(UNKNOWN_ERROR_HEADER));
  }
}

Future<ResponseOrError> _get(String url, {Map<String, String> headers}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    dynamic error;
    http.Response response;
    response =
        await http.get(url, headers: headers).catchError((e) => error = e);

    if (error == null) {
      return _futureOnResponse(response);
    } else {
      return _futureOnError(NetworkError(UNKNOWN_ERROR_HEADER));
    }
  } else {
    return _futureOnError(NetworkError(NO_CONNECTIVITY_HEADER));
  }
}

Future<ResponseOrError> _post(String url,
    {Map<String, String> headers, Encoding encoding, dynamic body}) async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    dynamic error;
    http.Response response = await http
        .post(url, headers: headers, body: body, encoding: encoding)
        .catchError((e) => error = e);

    if (error == null) {
      return _futureOnResponse(response);
    } else {
      return _futureOnError(NetworkError(UNKNOWN_ERROR_HEADER));
    }
  } else {
    return _futureOnError(NetworkError(NO_CONNECTIVITY_HEADER));
  }
}

Future<ResponseOrError> _futureOnError(dynamic error) {
  ResponseOrError resorerr = ResponseOrError();
  resorerr.error = error;
  return Future.error(resorerr);
}

Future<ResponseOrError> _futureOnResponse(http.Response response) {
  ResponseOrError resorerr = ResponseOrError();
  resorerr.response = response;
  return Future.value(resorerr);
}
