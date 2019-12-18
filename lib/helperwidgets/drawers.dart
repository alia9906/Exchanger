import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Drawers {
  static Drawer getProfileDrawer(BuildContext c) {
    User user = Provider.of<User>(c);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: DeviceScreen.fivePercentWidth),
          child: FlatButton.icon(
            icon: Icon(
              Icons.exit_to_app,
              color: AppColors.ALADDIN_SUGAR,
            ),
            label: Text(
              'خارج شدن از حساب',
              style: TextStyle(color: AppColors.ALADDIN_SUGAR),
            ),
            onPressed: () {
              user.logOut();
            },
          ),
        ),
      ),
    );
  }
}
