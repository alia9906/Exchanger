import 'dart:io';

import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/helperwidgets/error_snackbar.dart';
import 'package:exchanger2/helperwidgets/httpresponsedialog.dart';
import 'package:exchanger2/helperwidgets/image_picker.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum VerificationState { Edit, First, AddCard }

class UserVerificationScreen extends StatefulWidget {
  List<bool> _showwhich;

  @override
  _UserVerificationScreenState createState() => _UserVerificationScreenState();
}

class _UserVerificationScreenState extends State<UserVerificationScreen> {
  List<File> _files = [null, null, null];

  List<String> _numbers = [null, null, null];

  var _form_key_1 = GlobalKey<FormState>();

  var _state = VerificationState.First;

  void _onFileChosen(int id, File file) {
    _files[id] = file;
  }

  @override
  Widget build(BuildContext context) {
    var settings = ModalRoute.of(context).settings.arguments as List<Object>;
    widget._showwhich = settings[0];
    bool isCard = widget._showwhich[0] && !widget._showwhich[1] && !widget._showwhich[2];
    _state = settings[1];
    bool _isSending = false;
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
            !isCard ? 'احراز هویت' : 'افزودن کارت'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: DeviceScreen.safeFullHeight * 0.925,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                widget._showwhich[0]
                    ? Container(
                        height: DeviceScreen.safeFullHeight * 0.25,
                        child: Card(
                          margin: EdgeInsets.all(DeviceScreen.fivePercentWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('   کارت بانکی'),
                              Column(
                                children: <Widget>[
                                  ImagePickerWidget(0, _onFileChosen),
                                  FittedBox(
                                    child: FlatButton(
                                      child: Text(
                                        'وارد کردن مشخصات',
                                        style: Styles
                                            .FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('ثبت'),
                                                  onPressed: () {
                                                    if (_form_key_1.currentState
                                                        .validate()) {
                                                      _form_key_1.currentState
                                                          .save();
                                                      return true;
                                                    }
                                                  },
                                                ),
                                              ],
                                              content: Container(
                                                height: DeviceScreen
                                                        .safeFullHeight *
                                                    0.3,
                                                child: Form(
                                                  key: _form_key_1,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        onSaved: (val) {
                                                          _numbers[0] = val;
                                                        },
                                                        validator: CommonUtils
                                                            .bankCartNumberValidator,
                                                        initialValue:
                                                            _numbers[0],
                                                        decoration:
                                                            InputDecoration(
                                                                labelText:
                                                                    'شماره کارت'),
                                                      ),
                                                      TextFormField(
                                                        onSaved: (val) {
                                                          _numbers[1] = val;
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        validator: CommonUtils
                                                            .shebaValidator,
                                                        decoration: InputDecoration(
                                                            labelText: 'شماره شبا' +
                                                                (_state !=
                                                                        VerificationState
                                                                            .AddCard
                                                                    ? " (الزامی نیست)"
                                                                    : "")),
                                                        initialValue:
                                                            _numbers[1],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        DeviceScreen
                                                            .fivePercentWidth),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                widget._showwhich[1]
                    ? Container(
                        height: DeviceScreen.safeFullHeight * 0.25,
                        child: Card(
                          margin: EdgeInsets.all(DeviceScreen.fivePercentWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('   کارت ملی'),
                              Column(
                                children: <Widget>[
                                  ImagePickerWidget(1, _onFileChosen),
                                  FittedBox(
                                    child: FlatButton(
                                      child: Text(
                                        'وارد کردن مشخصات',
                                        style: Styles
                                            .FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return AlertDialog(
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text('ثبت'),
                                                  onPressed: () {
                                                    if (_form_key_1.currentState
                                                        .validate())
                                                      _form_key_1.currentState
                                                          .save();
                                                  },
                                                ),
                                              ],
                                              content: Container(
                                                height: DeviceScreen
                                                        .safeFullHeight *
                                                    0.2,
                                                child: Form(
                                                  key: _form_key_1,
                                                  child: Column(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        onSaved: (val) {
                                                          _numbers[2] = val;
                                                          Navigator.of(context)
                                                              .pop(true);
                                                        },
                                                        validator: CommonUtils
                                                            .bankCartNumberValidator,
                                                        decoration: InputDecoration(
                                                            labelText:
                                                                'شماره کارت ملی'),
                                                        initialValue:
                                                            _numbers[2],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        DeviceScreen
                                                            .fivePercentWidth),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(),
                widget._showwhich[2]
                    ? Container(
                        height: DeviceScreen.safeFullHeight * 0.25,
                        child: Card(
                          margin: EdgeInsets.all(DeviceScreen.fivePercentWidth),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('   عکس چهره'),
                              ImagePickerWidget(2, _onFileChosen)
                            ],
                          ),
                        ),
                      )
                    : Container(),
                _isSending
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        onPressed: () {
                          print(_state);
                          if (_state == VerificationState.Edit) {
                            _files = _files.map((f) {
                              print(f == null ? "null" : f.path);
                              if (f == null) return File('');
                              return f;
                            }).toList();
                            _numbers = _numbers.map((number) {
                              if (number == null) return '';
                              return number;
                            }).toList();
                          }
                          if (_state == VerificationState.AddCard) {
                            _files[1] = File('');
                            _files[2] = File('');
                            _numbers[2] = '';
                          }
                          if (_state == VerificationState.First) {
                            int index = 0;
                            widget._showwhich.forEach((s) {
                              if (!s) {
                                if (index == 0) {
                                  _files[0] = File('');
                                  _numbers[0] = '';
                                  _numbers[1] = '';
                                }
                                if (index == 1) {
                                  _files[1] = File('');
                                  _numbers[2] = '';
                                }
                                if (index == 2) {
                                  _files[2] = File('');
                                }
                              }
                              index++;
                            });
                          }
                          if (_files.any((file) => file == null) ||
                              _numbers.any((number) => number == null)) {
                            return showDialog(
                              context: context,
                              builder: (_) {
                                return ErrorDialog(
                                    'تمام فیلد ها را وارد کنید!');
                              },
                            );
                          }
                          showDialog(
                              context: context,
                              builder: (_) => ResponseDialog(user.varifyUser(
                                  _files,
                                  _numbers,
                                  ErrorHandlingType.Future,
                                  _state)));
                        },
                        child: Container(
                          width: double.infinity,
                          height: DeviceScreen.safeFullHeight * 0.075,
                          child: Text('ثبت'),
                          alignment: Alignment.center,
                        ),
                        elevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        color: AppColors.LIME,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
