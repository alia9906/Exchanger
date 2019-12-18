import 'dart:convert';

import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatItem extends StatelessWidget {
  dynamic _chatitem;
  ChatItem(this._chatitem);

  @override
  Widget build(BuildContext context) {
    print(_chatitem);

    var parsed = _chatitem;
    var parsedconv = (parsed as Map<dynamic, dynamic>);

    DateTime time = DateTime.tryParse(parsedconv['time']);
    String sender = parsedconv['sender'];
    String message = parsedconv['message'];
    bool isSeen = true;

    return Container(
      alignment:
          sender == "admin" ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
          width: DeviceScreen.fullWidth * 0.6,
          margin: EdgeInsets.symmetric(
              vertical: DeviceScreen.fivePercentWidth * 0.25,
              horizontal: DeviceScreen.fivePercentWidth * 0.4),
          padding: EdgeInsets.symmetric(
              vertical: DeviceScreen.fivePercentWidth * 0.5,
              horizontal: DeviceScreen.fivePercentWidth * 0.5),
          decoration: BoxDecoration(
            color: sender == "user" ? Colors.blue : Colors.green,
            borderRadius:
                BorderRadius.circular(DeviceScreen.fivePercentWidth * 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                child: Text(message),
                padding: EdgeInsets.all(DeviceScreen.fivePercentWidth * 0.5),
              ),
              Row(
                children: <Widget>[
                  Text(
                    DateFormat().add_Md().add_Hm().format(time),
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  sender == "admin"
                      ? Container()
                      : Icon(isSeen
                          ? Icons.check_circle
                          : Icons.check_circle_outline)
                ],
              ),
            ],
          )),
    );
  }
}
