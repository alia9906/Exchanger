import 'package:exchanger2/constants/data.dart';
import 'package:exchanger2/constants/routes.dart';
import 'package:exchanger2/helperwidgets/activity_item.dart';
import 'package:exchanger2/helperwidgets/sell_dialog.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/scaffscreens/user_verification_screen.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/helperwidgets/increase_credit.dart' as ic;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityFragment extends StatelessWidget {
  void _onTapItem(String label, BuildContext context) {
    if (label == 'گفتگو ') {
      Navigator.of(context).pushNamed(USER_CHAT_WITH_ADMIN);
      return;
    }
    if (label == 'فروش ') {
      showDialog(
          context: context,
          builder: (_) {
            return SellDialog();
          });
      return;
    }
    if (label == 'افزایش اعتبار ') {
      showDialog(
          context: context,
          builder: (_) {
            return ic.IncreaseCredit();
          });
      return;
    }
    if (label == 'افزودن کارت ') {
      Navigator.of(context)
          .pushNamed(USER_VERIFY_PAGE, arguments: [[true, false, false] , VerificationState.First]);
      return;
    }
    if (label == 'خرید ') {
      Navigator.of(context).pushNamed(BUY_SCREEN);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return (user.isUserAuthenticated && user.isUserVerified)
        ? SafeArea(
            child: Container(
            height: DeviceScreen.safeFullHeight,
            child: GridView(
              padding: EdgeInsets.symmetric(
                  vertical: DeviceScreen.fivePercentHeight * 0.85,
                  horizontal: DeviceScreen.fivePercentWidth * 0.85),
              children: ACTIVTIES.map((item) {
                return ActivityItem(
                    item['color'], item['iconData'], item['label'], _onTapItem);
              }).toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: DeviceScreen.fullWidth * 0.8,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: DeviceScreen.fivePercentWidth,
                mainAxisSpacing: DeviceScreen.fivePercentHeight,
              ),
            ),
          ))
        : Container(
          height: DeviceScreen.safeFullHeight,
            child: Center(
              child: Text('ابتدا باید احراز هویت شوید!'),
            ),
          );
  }
}
