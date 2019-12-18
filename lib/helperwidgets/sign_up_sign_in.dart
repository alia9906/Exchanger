import 'package:exchanger2/helperwidgets/entersmscode.dart';
import 'package:exchanger2/helperwidgets/error_snackbar.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:provider/provider.dart';

class SignInSignUpFragment extends StatefulWidget {
  Process _process;
  Function _reverser;
  static final _form_state = GlobalKey<FormState>();

  SignInSignUpFragment(this._process, this._reverser);

  @override
  _SignInSignUpFragmentState createState() => _SignInSignUpFragmentState();
}

class _SignInSignUpFragmentState extends State<SignInSignUpFragment> {
  ProcessState _state = ProcessState.Form;

  List<String> _form_items = [];

  bool _isitoncodeauthentication = false;

  void _onEditPhoneNumber() {
    setState(() {
      _isitoncodeauthentication = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool signin = widget._process == Process.SignIn;
    User user = Provider.of<User>(context, listen: false);
    DeviceScreen(context);
    final EdgeInsetsGeometry form_padding = EdgeInsets.symmetric(
        vertical: DeviceScreen.fivePercentWidth * 0.5,
        horizontal: DeviceScreen.fivePercentWidth);
    return Center(
      child: Container(
        height: _isitoncodeauthentication
            ? DeviceScreen.fullHeight * 0.5
            : signin
                ? DeviceScreen.fullHeight * 0.5
                : DeviceScreen.fullHeight * 0.5,
        child: _isitoncodeauthentication
            ? SmsVerfier(_form_items[0],
                widget._process == Process.SignUp ? null : _onEditPhoneNumber)
            : Form(
                key: SignInSignUpFragment._form_state,
                child: Padding(
                  padding: form_padding,
                  child: signin
                      ? Column(
                          children: <Widget>[
                            Card(
                              child: Container(
                                height: DeviceScreen.safeFullHeight * 0.093,
                                padding: form_padding,
                                child: TextFormField(
                                  validator: CommonUtils.phoneNumberValidator,
                                  onSaved: (val) {
                                    _form_items.clear();
                                    _form_items.add(val);
                                    setState(() {
                                      _state = ProcessState.Loading;
                                    });
                                    user
                                        .verifyAccountByPhoneNumber(
                                            val, ErrorHandlingType.Future)
                                        .then((_) {
                                      setState(() {
                                        _isitoncodeauthentication = true;
                                        _state = ProcessState.Form;
                                      });
                                    }).catchError((err) {
                                      CommonUtils.showSnackBarWithError(
                                          err.toString(), context);
                                      setState(() {
                                        _state = ProcessState.Form;
                                      });
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'شماره همراه',
                                  ),
                                  enabled: _state != ProcessState.Loading,
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                                ),
                              ),
                            ),
                            
                            Container(
                                alignment: Alignment.center,
                                child: _state == ProcessState.Form
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                DeviceScreen.fivePercentWidth *
                                                    0.5),
                                        child: RaisedButton(
                                          color: AppColors.LIME,
                                          elevation:
                                              DeviceScreen.fivePercentWidth *
                                                  0.2,
                                          child: Container(
                                            child: Text('ارسال پیامک'),
                                            width:
                                                DeviceScreen.fullWidth * 0.80,
                                            height:
                                                DeviceScreen.safeFullHeight *
                                                    0.093,
                                            alignment: Alignment.centerRight,
                                          ),
                                          onPressed:
                                              _state == ProcessState.Loading
                                                  ? null
                                                  : () {
                                                      if (SignInSignUpFragment
                                                          ._form_state
                                                          .currentState
                                                          .validate()) {
                                                        SignInSignUpFragment
                                                            ._form_state
                                                            .currentState
                                                            .save();
                                                      }
                                                    },
                                        ),
                                      )
                                    : CircularProgressIndicator(),
                              ),
                           
                            FlatButton(
                              child: RichText(
                                text: TextSpan(
                                    text: 'حساب کاربری ایجاد نکرده اید ؟ ',
                                    children: [
                                      TextSpan(
                                          text: 'ایجاد حساب',
                                          style: TextStyle(
                                              fontFamily: 'main',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.WHITE))
                                    ]),
                              ),
                              onPressed: () {
                                widget._reverser();
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            Card(
                              child: Container(
                                height: DeviceScreen.safeFullHeight * 0.093,
                                padding: form_padding,
                                child: TextFormField(
                                  validator: CommonUtils.phoneNumberValidator,
                                  onSaved: (val) {
                                    _form_items.clear();
                                    _form_items.add(val);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'شماره همراه',
                                  ),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true, signed: false),
                                ),
                              ),
                            ),
                            Container(
                              width: DeviceScreen.fullWidth,
                              height: DeviceScreen.safeFullHeight * 0.12,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Card(
                                      child: Container(
                                        height:
                                            DeviceScreen.safeFullHeight * 0.093,
                                        padding: form_padding,
                                        child: TextFormField(
                                          validator:
                                              CommonUtils.plainStringValidator,
                                          onSaved: (val) {
                                            _form_items.add(val);
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'نام',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Card(
                                      child: Container(
                                        height:
                                            DeviceScreen.safeFullHeight * 0.093,
                                        padding: form_padding,
                                        child: TextFormField(
                                          validator:
                                              CommonUtils.plainStringValidator,
                                          onSaved: (val) {
                                            _form_items.add(val);
                                            user
                                                .createAccount(_form_items,
                                                    ErrorHandlingType.Future)
                                                .then((val) {
                                              setState(() {
                                                _isitoncodeauthentication =
                                                    true;
                                              });
                                            }).catchError((e) {
                                              Scaffold.of(context).showSnackBar(
                                                  ErrorSnackBar(e.toString()));
                                              setState(() {
                                                _state = ProcessState.Form;
                                              });
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'نام خانوادگی',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Container(
                                
                                child: _state == ProcessState.Form
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                DeviceScreen.fivePercentWidth *
                                                    0.5),
                                        child: RaisedButton(
                                          color: AppColors.LIME,
                                          elevation:
                                              DeviceScreen.fivePercentWidth *
                                                  0.2,
                                          child: Container(
                                            child: Text('ایجاد حساب'),
                                            width:
                                                DeviceScreen.fullWidth * 0.80,
                                            height:
                                                DeviceScreen.safeFullHeight *
                                                    0.093,
                                            alignment: Alignment.centerRight,
                                          ),
                                          onPressed: () {
                                            if (SignInSignUpFragment
                                                ._form_state.currentState
                                                .validate()) {
                                              SignInSignUpFragment
                                                  ._form_state.currentState
                                                  .save();
                                              setState(() {
                                                _state = ProcessState.Loading;
                                              });
                                            }
                                          },
                                        ),
                                      )
                                    : CircularProgressIndicator(),
                              ),
                            ),
                            FlatButton(
                              child: RichText(
                                text: TextSpan(
                                    text: 'قبلا حساب ایجاد کرده اید ؟ ',
                                    children: [
                                      TextSpan(
                                          text: 'وارد شوید',
                                          style: TextStyle(
                                              fontFamily: 'main',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.WHITE))
                                    ]),
                              ),
                              onPressed: () {
                                widget._reverser();
                              },
                            ),
                          ],
                        ),
                ),
              ),
      ),
    );
  }
}

enum Process { SignIn, SignUp }
enum ProcessState { Form, Loading, Error, Complete }
