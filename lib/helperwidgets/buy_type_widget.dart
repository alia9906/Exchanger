import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/helperwidgets/httpresponsedialog.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/providers/user.dart' as prefix0;
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class BuyTypeWidget extends StatefulWidget {
  double _premiumCount, _regularCount;

  prefix0.BuyType get buytype {
    if (_premiumCount != 0.0) {
      return prefix0.BuyType.Premium;
    }
    if (_regularCount != 0.0) {
      return prefix0.BuyType.Perfect;
    }
    return null;
  }

  double get amount {
    if (buytype == prefix0.BuyType.Premium) {
      return _premiumCount;
    } else {
      return _regularCount;
    }
  }

  BuyTypeWidget(this._premiumCount, this._regularCount);

  @override
  _BuyTypeWidgetState createState() => _BuyTypeWidgetState();
}

class _BuyTypeWidgetState extends State<BuyTypeWidget> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    if (widget._premiumCount == 0 && widget._regularCount == 0) {
      return ErrorDialog('حداقل یک مورد انتخاب کنید.');
    }
    return FutureBuilder(
      future: user.getBuyTypes(widget._regularCount, widget._premiumCount),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snap.connectionState == ConnectionState.done) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(DeviceScreen.fivePercentWidth),
            ),
            content: Container(
              height: DeviceScreen.safeFullHeight * 0.3,
              child: snap.data == null
                  ? Container(
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        snap.data[0]
                            ? FlatButton(
                                child: Text('‍پرداخت با اعتبار'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ResponseDialog(
                                            user.buy(widget.buytype,
                                                widget.amount, 1),
                                            onValue: (val) {
                                              if(!(val as String).contains(
                                                          "Voucher Code: ")){
                                                            return;
                                                          }
                                              Clipboard.setData(new ClipboardData(
                                                  text: (val as String).split(
                                                          "Voucher Code: ")[
                                                      1]));
                                              Fluttertoast.showToast(
                                                  msg: "کد ووچر در کلیپ بورد کپی شد.",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIos: 1,
                                                  backgroundColor: Colors.blue,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                          ));
                                },
                              )
                            : Container(
                                height: 0.0,
                                width: 0.0,
                              ),
                        snap.data[1]
                            ? FlatButton(
                                child: Text('شارژ حساب و پرداخت'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ResponseDialog(
                                            user.buy(widget.buytype,
                                                widget.amount, 2),
                                            onValue: (val) {
                                              if(!(val as String).contains(
                                                          "Voucher Code: ")){
                                                            return;
                                                          }
                                              Clipboard.setData(new ClipboardData(
                                                  text: (val as String).split(
                                                          "Voucher Code: ")[
                                                      1]));
                                              Fluttertoast.showToast(
                                                  msg: "کد ووچر در کلیپ بورد کپی شد.",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIos: 1,
                                                  backgroundColor: Colors.blue,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                          ));
                                },
                              )
                            : Container(
                                height: 0.0,
                                width: 0.0,
                              ),
                        snap.data[2]
                            ? FlatButton(
                                child: Text('پرداخت کامل با بانک'),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ResponseDialog(
                                            user.buy(widget.buytype,
                                                widget.amount, 3),
                                            onValue: (val) {
                                              if(!(val as String).contains(
                                                          "Voucher Code: ")){
                                                            return;
                                                          }
                                              Clipboard.setData(new ClipboardData(
                                                  text: (val as String).split(
                                                          "Voucher Code: ")[
                                                      1]));
                                              Fluttertoast.showToast(
                                                  msg: "کد ووچر در کلیپ بورد کپی شد.",
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.CENTER,
                                                  timeInSecForIos: 1,
                                                  backgroundColor: Colors.blue,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            },
                                          ));
                                },
                              )
                            : Container(
                                height: 0.0,
                                width: 0.0,
                              ),
                      ],
                    ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
