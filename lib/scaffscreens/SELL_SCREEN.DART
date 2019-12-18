import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  @override
  _SellScreenState createState() => _SellScreenState();
}

enum SellType { Premium, Perfect }

class _SellScreenState extends State<SellScreen> {
  var _form = GlobalKey<FormState>();
  bool _isLoading = false;
  SellType _sellType;

  @override
  Widget build(BuildContext context) {
    _sellType = ModalRoute.of(context).settings.arguments;
    User user = Provider.of<User>(context, listen: false);
    String _act, _code;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: DeviceScreen.safeFullHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: DeviceScreen.fivePercentWidth,
                      vertical: DeviceScreen.fivePercentWidth),
                  height: DeviceScreen.safeFullHeight * 0.5,
                  child: Form(
                    key: _form,
                    child: _sellType == SellType.Perfect
                        ? Column(
                            children: <Widget>[
                              Card(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    labelText: "Activation Code",
                                  ),
                                  validator: (val) {},
                                  onSaved: (val) {
                                    _act = val;
                                  },
                                ),
                              ),
                              Card(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: "Voucher Code"),
                                  validator: (val) {},
                                  onSaved: (val) {
                                    _code = val;
                                    user
                                        .sell(SellType.Perfect, _act, _code)
                                        .then((res) {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ErrorDialog("موفقیت آمیز بود!"));
                                    }).catchError((err) {
                                      setState(() {
                                        _isLoading = false;
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                ErrorDialog(err.toString()));
                                      });
                                    });
                                  },
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Card(
                                                              child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: "Voucher Code"),
                                  validator: (val) {},
                                  onSaved: (val) {
                                    _code = val;
                                    print(_act);
                                    user
                                        .sell(SellType.Premium, _act, _code)
                                        .then((res) {
                                      showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ErrorDialog("موفقیت آمیز بود!"));
                                    }).catchError((err) {
                                      setState(() {
                                        _isLoading = false;
                                        showDialog(
                                            context: context,
                                            builder: (_) =>
                                                ErrorDialog(err.toString()));
                                      });
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                RaisedButton(
                  color: AppColors.LIME,
                  child: Container(
                    width: double.infinity,
                    height: DeviceScreen.safeFullHeight * 0.085,
                    child:
                        _isLoading ? CircularProgressIndicator() : Text('ثبت'),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    _form.currentState.save();
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
