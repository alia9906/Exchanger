import 'package:exchanger2/constants/routes.dart';
import 'package:exchanger2/helperwidgets/centerprogressbar.dart';
import 'package:exchanger2/helperwidgets/httpresponsedialog.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/scaffscreens/user_verification_screen.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:provider/provider.dart';

class CartChooser extends StatelessWidget {
  final String amount;
  CartChooser(this.amount);
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return AlertDialog(
      content: Container(
        height: DeviceScreen.safeFullHeight * 0.3,
        child: FutureBuilder(
          future: user.getCartsByNum(amount),
          builder: (_, snap) {
            if (snap.hasData && snap.connectionState == ConnectionState.done) {
              if (snap.data.length == 0) {
                return prefix0.FlatButton(
                  child: prefix0.Text(
                    'اضافه کردن کارت',
                    style: Styles.FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
                  ),
                  onPressed: () {
                    prefix0.Navigator.of(context).pop();
                    prefix0.Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamed(USER_VERIFY_PAGE, arguments: [
                      [true, false, false],
                      VerificationState.AddCard
                    ]);
                  },
                );
              }
              return ListView(
                children: [
                  ...((snap.data as List<dynamic>).map((e) {
                    return FlatButton(
                      child: Text(
                        e['display'],
                        style: Styles.FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
                      ),
                      onPressed: () {
                        prefix0.Navigator.of(context).pop();
                        prefix0.Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (_) => ResponseDialog(
                                user.redeemMoney(amount, e['value'])));
                      },
                    );
                  }).toList() as List<Widget>),
                  FlatButton(
                    child: prefix0.Text(
                      'اضافه کردن کارت',
                      style: Styles.FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
                    ),
                    onPressed: () {
                      prefix0.Navigator.of(context).pop();
                      prefix0.Navigator.of(context).pop();
                      Navigator.of(context)
                          .pushNamed(USER_VERIFY_PAGE, arguments: [
                        [true, false, false],
                        VerificationState.AddCard
                      ]);
                    },
                  )
                ],
              );
            }
            return CenterProgressBar();
          },
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
      ),
      actions: <Widget>[],
    );
  }
}
