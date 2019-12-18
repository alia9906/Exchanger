import 'package:exchanger2/helperwidgets/httpresponsedialog.dart';
import 'package:exchanger2/helperwidgets/show_all_carts_dialog.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

class RedeemMoneyDialog extends StatefulWidget {
  int max;
  RedeemMoneyDialog(this.max);

  @override
  _RedeemMoneyDialogState createState() => _RedeemMoneyDialogState();
}

class _RedeemMoneyDialogState extends State<RedeemMoneyDialog> {
  TextEditingController tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return AlertDialog(
      actions: <Widget>[
        FlatButton(
          child: Text('برداشت'),
          onPressed: () {
            if (!isInt(tec.text)) {
              Fluttertoast.showToast(
                msg: 'لطفاعدد وارد کنید',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );
              tec.text = "";
              return;
            }
            if (int.parse(tec.text) < 10000) {
              Fluttertoast.showToast(
                msg: 'حداقل مقدار 10,000 ریال است!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );

              tec.text = "";
              return;
            }
            if (int.parse(tec.text) > widget.max) {
              Fluttertoast.showToast(
                msg: 'حداکثر مقدار ${widget.max} ریال است!',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.red,
                textColor: Colors.white,
              );

              tec.text = "";
              return;
            }
            showDialog(
                context: context,
                builder: (_)=>CartChooser(tec.text));
          },
        ),
      ],
      content: Container(
        height: DeviceScreen.safeFullHeight * 0.3,
        child: TextField(
          controller: tec,
          decoration: InputDecoration(labelText: 'مقدار برداشت به ریال'),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
      ),
    );
  }
}
