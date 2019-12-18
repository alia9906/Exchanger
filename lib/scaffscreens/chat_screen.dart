import 'package:exchanger2/helperwidgets/chatitem.dart';
import 'package:exchanger2/providers/chat.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController tec = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<Chat>(context, listen: false).createChannel();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Chat.continueChannel = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Consumer<Chat>(builder: (
              _,
              chat,
              ch,
            ) {
              return ListView.builder(
                itemBuilder: (_, i) {
                  return ChatItem(chat.currentMessages[i]);
                },
                itemCount: chat.currentMessages.length,
              );
            }),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: AppColors.LIME,
                  textDirection: TextDirection.ltr,
                ),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (tec.text.length > 0) {
                    String message = tec.text;
                    Chat.sendMessage(message);
                    tec.text = "";
                  }
                },
              ),
              Card(
                child: Container(
                  width: DeviceScreen.fullWidth * 0.8,
                  padding: EdgeInsets.symmetric(
                      vertical: DeviceScreen.fivePercentWidth * 0.25,
                      horizontal: DeviceScreen.fivePercentWidth),
                      height: DeviceScreen.safeFullHeight * 0.093,
                  child: TextField(
                    controller: tec,
                    autocorrect: true,
                    decoration: InputDecoration(labelText: 'payam'),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
