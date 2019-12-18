import 'dart:convert';

import 'package:exchanger2/constants/endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Chat with ChangeNotifier {
  static String _token;

  static bool continueChannel = false;

  Chat(String token) {
    _token = token;
    if (continueChannel) {
      createChannel();
    }
  }

  List<dynamic> _currenMessages = [];

  List<dynamic> get currentMessages {
    return [..._currenMessages];
  }

  Future<dynamic> createChannel() async {
    continueChannel = true;
    return _keepChannel(null, null);
  }

  Future<dynamic> _keepChannel(List<dynamic> prev, DateTime last) async {
    if (!continueChannel) {
      return null;
    }
    if (prev != null && last != null) {
      _currenMessages.clear();
      _currenMessages.addAll(prev);
      notifyListeners();
    }
    List<dynamic> nreprev = [];
    DateTime newlast;
    await Future.delayed(Duration(seconds: last == null ? 0 : 5), () async {
      await http.get(CHATGET, headers: {'x-auth-token': _token}).then((data) {
        print(data.body);
        var body = json.decode(data.body) as List<dynamic>;
        print(body);
        body.forEach((message) {
          var conv = message as Map<dynamic, dynamic>;

          if (true) {
            newlast = DateTime.tryParse(conv['time']);
            nreprev.add(message);
          }
        });
      });
      return null;
    });
    notifyListeners();
    return _keepChannel(
        nreprev == null ? [] : nreprev, newlast == null ? last : newlast);
  }

  static Future<dynamic> sendMessage(String message) async {
    if (_token == null) return Future.error("no token");
    return await http.post(CHATPOST,
        headers: {'x-auth-token': _token},
        body: {'message': message}).catchError((err) => err);
  }
}
