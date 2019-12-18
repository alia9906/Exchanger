import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncreaseCredit extends StatelessWidget {
  final TextEditingController tec = TextEditingController();

  void ic(BuildContext context, User user) {
    if (CommonUtils.creditValidator(tec.text) == null) {
      showDialog(
          context: context,
          builder: (_) =>
              ErrorDialog("لطفا منتظر بمانید تا به درگاه منتقل شوید."));
      user.increaseWallet(int.parse(tec.text)).then((_) {
      }).catchError((err) {
        showDialog(
            context: context, builder: (_) => ErrorDialog(err.toString()));
      });
    } else {
      showDialog(
          context: context,
          builder: (_) => ErrorDialog(CommonUtils.creditValidator(tec.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('افزایش'),
          onPressed: () => ic(context, user),
        ),
      ],
      content: Container(
        height: DeviceScreen.safeFullHeight * 0.2,
        child: TextField(
          controller: tec,
          decoration: InputDecoration(labelText: 'مقدار به ریال'),
          onSubmitted: (_) => ic(context, user),
        ),
      ),
    );
  }
}
