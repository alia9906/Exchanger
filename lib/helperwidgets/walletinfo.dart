import 'package:exchanger2/helperwidgets/redeem_money_dialog.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:validators/validators.dart' as vl;

class WalletInfo extends StatelessWidget {
  final dynamic _data;
  WalletInfo(this._data);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: DeviceScreen.fivePercentWidth * 0.15,
      margin: EdgeInsets.symmetric(
          vertical: DeviceScreen.fivePercentWidth * 0.5,
          horizontal: DeviceScreen.fivePercentWidth),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
      ),
      child: Container(
        width: double.infinity,
        height: DeviceScreen.safeFullHeight * 0.28,
        alignment: Alignment.center,
        child: _data == null
            ? CircularProgressIndicator()
            : (!vl.isFloat(_data.toString()) || !vl.isNumeric(_data.toString()))
                ? Text("خطا در اتصال!")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'اعتبار حساب شما :‌ ',
                        style: Styles.HEADER,
                      ),
                      Text(
                        _data.toString() + " RIAL",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: DeviceScreen.fivePercentWidth * 1.7),
                      ),
                      FlatButton(
                        child: Text(
                          'برداشت از حساب',
                          style: TextStyle(color: AppColors.ALADDIN_PURPLE),
                        ),
                        onPressed: () {
                          if (int.parse(_data.toString()) < 10000) {
                            return Fluttertoast.showToast(
                              msg: 'حداقل برداشت 1 هزار تومان است!',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                            );
                          }
                          int max = int.parse(_data.toString());
                          showDialog(
                              context: context,
                              builder: (_) => RedeemMoneyDialog(max));
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
