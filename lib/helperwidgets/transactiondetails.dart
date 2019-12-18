import 'package:exchanger2/model/transaction.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class TransactionDetails extends StatelessWidget {
  TransactionItem _item;

  TransactionDetails(this._item);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: DeviceScreen.safeFullHeight * 0.5,
        child: ListView(
          children: <Widget>[
            ListTile(
              title: FittedBox(
                  child: Text((_item.status == Status.Sell ? "فروش" : "خرید ") +
                      " " +
                      (_item.payment == Payment.Perfect
                          ? "Perfect"
                          : "Premium"))),
              subtitle: Text(
                ("قیمت :‌ ${(CommonUtils.createReadablePrice(_item.amount))}USD"),
                style: Theme.of(context).textTheme.body1,
              ),
              trailing: FittedBox(
                  child: Container(
                      width: DeviceScreen.fullWidth * 0.25,
                      child: Text(
                          DateFormat().add_yMd().add_Hm().format(_item.time)))),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                    new ClipboardData(text: _item.activationcode));
                Fluttertoast.showToast(
                    msg: "Activation code کپی شد !",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: RichText(
                text: TextSpan(
                    text: 'Activation Code : (برای کپی کردن کلیک کنید)\n',
                    style: TextStyle(
                        fontFamily: 'main',
                        fontSize: DeviceScreen.fivePercentWidth,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: _item.activationcode,
                        style: TextStyle(
                            fontFamily: 'main',
                            fontSize: DeviceScreen.fivePercentWidth,
                            color: Colors.blue),
                      )
                    ]),
              ),
            ),
            InkWell(
              onTap: () {
                Clipboard.setData(
                    new ClipboardData(text: _item.transactionnumber));
                Fluttertoast.showToast(
                    msg: "Voucer code کپی شد !",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.blue,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: RichText(
                text: TextSpan(
                    text: 'Voucher Code : (برای کپی کردن کلیک کنید)\n',
                    style: TextStyle(
                        fontFamily: 'main',
                        fontSize: DeviceScreen.fivePercentWidth,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text: _item.transactionnumber,
                        style: TextStyle(
                            fontFamily: 'main',
                            fontSize: DeviceScreen.fivePercentWidth,
                            color: Colors.blue),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
      ),
    );
  }
}
