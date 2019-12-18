import 'package:exchanger2/helperwidgets/error_snackbar.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmsVerfier extends StatefulWidget {
  final String _phonenumber;
  final Function _onEditNumber;

  SmsVerfier(this._phonenumber, this._onEditNumber);

  @override
  _SmsVerfierState createState() => _SmsVerfierState();
}

class _SmsVerfierState extends State<SmsVerfier> {
  bool _isSending = false;
  bool _isLoading = false;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Column(children: [
      Card(
        margin: EdgeInsets.symmetric(
            vertical: DeviceScreen.fivePercentWidth * 0.5,
            horizontal: DeviceScreen.fivePercentWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: DeviceScreen.fivePercentWidth * 0.5),
              child: FittedBox(
                child: Text(
                  'پیامک به شماره ${widget._phonenumber} ارسال شد.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: DeviceScreen.fivePercentWidth * 0.5,
            ),
            Container(
              height: DeviceScreen.safeFullHeight * 0.14,
              padding: EdgeInsets.symmetric(
                  vertical: DeviceScreen.fivePercentWidth * 0.5,
                  horizontal: DeviceScreen.fivePercentWidth),
              child: TextFormField(
                enabled: !_isSending,
                readOnly: _isSending,
                maxLength: 6,
                controller: _controller,
                decoration: InputDecoration(
                    labelText:
                        _isSending ? 'ارزیابی کد ...' : 'کد را وارد کنید'),
                onFieldSubmitted: (val) {
                  setState(() {
                    _isSending = true;
                  });
                  user.sendSmsCode(val, ErrorHandlingType.Future).catchError(
                    (err) {
                      Scaffold.of(context)
                          .showSnackBar(ErrorSnackBar('کد اشتباه است!'));
                      _controller.text = "";
                      setState(() {
                        _isSending = false;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      _isSending
          ? CircularProgressIndicator()
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: DeviceScreen.fivePercentWidth * 0.5),
              child: RaisedButton(
                color: AppColors.LIME,
                elevation: DeviceScreen.fivePercentWidth * 0.2,
                child: Container(
                  child: Text('ورود به حساب'),
                  width: DeviceScreen.fullWidth * 0.80,
                  height: DeviceScreen.safeFullHeight * 0.093,
                  alignment: Alignment.centerRight,
                ),
                onPressed: () {
                  if (_controller.text.length < 6) {
                    _controller.text = "";
                    return Scaffold.of(context)
                        .showSnackBar(ErrorSnackBar('کد اشتباه است!'));
                  }
                  setState(() {
                    _isSending = true;
                  });
                  user
                      .sendSmsCode(_controller.text, ErrorHandlingType.Future)
                      .catchError(
                    (err) {
                      print("Error" + err.toString());
                      Scaffold.of(context)
                          .showSnackBar(ErrorSnackBar('کد اشتباه است!'));
                      _controller.text = "";
                      setState(() {
                        _isSending = false;
                      });
                    },
                  );
                },
              ),
            ),
           SizedBox(height: DeviceScreen.fivePercentWidth,),
      widget._onEditNumber == null
          ? Container()
          : FlatButton(
              child: RichText(
                text: TextSpan(
                    text: 'شماره را اشتباه وارد کرده اید ؟ ',
                    children: [
                      TextSpan(
                          text: 'اصلاح شماره',
                          style: TextStyle(
                              fontFamily: 'main',
                              fontWeight: FontWeight.bold,
                              color: AppColors.WHITE))
                    ]),
              ),
              onPressed: widget._onEditNumber,
            ),
      FlatButton(
        child: !_isLoading
            ? RichText(
                text: TextSpan(
                    text: 'پیامک ارسال نشده است ؟ ',
                    children: [
                      TextSpan(
                          text: 'ارسال مجدد',
                          style: TextStyle(
                              fontFamily: 'main',
                              fontWeight: FontWeight.bold,
                              color: AppColors.WHITE))
                    ]),
              )
            : CircularProgressIndicator(),
        onPressed: _isLoading
            ? () {}
            : () {
                setState(() {
                  _isLoading = true;
                });
                user
                    .verifyAccountByPhoneNumber(
                        widget._phonenumber, ErrorHandlingType.Future)
                    .then(
                  (val) {
                    Scaffold.of(context).showSnackBar(ErrorSnackBar(
                        'کد به شماره ${widget._phonenumber} ارسال شد.'));
                    setState(() {
                      _isLoading = false;
                    });
                  },
                ).catchError((e) {
                  Scaffold.of(context)
                      .showSnackBar(ErrorSnackBar(e.toString()));
                  setState(() {
                    _isLoading = false;
                  });
                });
              },
      ),
    ]);
  }
}
