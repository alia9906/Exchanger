import 'package:exchanger2/scaffscreens/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchanger2/scaffscreens/main.dart' as prefix0;
import 'package:exchanger2/scaffscreens/welcome.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:provider/provider.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    DeviceScreen(context);
    Styles(context);
    User user = Provider.of<User>(context);
    return (user.isUserAuthenticated && user.isLoaded) ? prefix0.Main() : WelcomeScreen();
  }
}
