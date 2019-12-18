import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/scaffscreens/splash_screen.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchanger2/helperwidgets/sign_up_sign_in.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

enum CurrentPage { Welcome, SignIn, SignUp }

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool first = true;

  void _bringUpSignUpPage() {
    setState(() {
      _current = CurrentPage.SignUp;
    });
  }

  void _bringUpSignInPage() {
    setState(() {
      _current = CurrentPage.SignIn;
    });
  }

  CurrentPage _current = CurrentPage.Welcome;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    Widget welcomepage = Container(
      height: DeviceScreen.safeFullHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.708)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: _current == CurrentPage.Welcome
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: DeviceScreen.safeFullHeight * 0.6,
                  width: DeviceScreen.fullWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: DeviceScreen.fivePercentWidth),
                        child: RichText(
                          text: TextSpan(
                            text: '\nE',
                            style: TextStyle(
                                color: AppColors.WHITE,
                                fontFamily: 'bold',
                                fontSize: DeviceScreen.fivePercentWidth * 2),
                            children: [
                              TextSpan(
                                text: 'X',
                                style: TextStyle(
                                    color: AppColors.LIME, fontFamily: 'bold'),
                              ),
                              TextSpan(
                                text: 'CHANGER\n',
                                style: TextStyle(
                                    color: AppColors.WHITE, fontFamily: 'bold'),
                              ),
                              TextSpan(
                                text: 'Iran\'s E-Voucher Solutions\n\n\n',
                                style: TextStyle(
                                    color: AppColors.WHITE.withOpacity(0.87),
                                    fontFamily: 'bold',
                                    fontSize:
                                        DeviceScreen.fivePercentWidth * 0.945),
                              )
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: DeviceScreen.fivePercentWidth),
                        child: Text(
                          "Welcome, Partner",
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: DeviceScreen.fivePercentWidth * 1.35,
                              color: AppColors.WHITE),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            DeviceScreen.fivePercentWidth,
                            0,
                            DeviceScreen.fivePercentWidth * 2,
                            0),
                        child: Text(
                          'Exchange E-Voucher easily and safely, Cash in your E-Voucher and make profit',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'bold',
                              fontSize: DeviceScreen.fivePercentWidth * 0.65,
                              color: AppColors.WHITE.withOpacity(0.87)),
                        ),
                      ),
                    ],
                  ),
                ),
                FittedBox(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: DeviceScreen.fivePercentWidth * 0.5),
                        child: RaisedButton(
                          color: AppColors.LIME,
                          elevation: DeviceScreen.fivePercentWidth * 0.2,
                          child: Container(
                            child: Text('ایجاد حساب'),
                            width: DeviceScreen.fullWidth * 0.80,
                            height: DeviceScreen.safeFullHeight * 0.093,
                            alignment: Alignment.centerRight,
                          ),
                          onPressed: _bringUpSignUpPage,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0,
                            DeviceScreen.fivePercentWidth * 0.4,
                            0,
                            DeviceScreen.fivePercentWidth * 5),
                        child: RaisedButton(
                          color: AppColors.WHITE,
                          elevation: DeviceScreen.fivePercentWidth * 0.2,
                          child: Container(
                            child: Text('ورود'),
                            width: DeviceScreen.fullWidth * 0.80,
                            height: DeviceScreen.safeFullHeight * 0.093,
                            alignment: Alignment.centerRight,
                          ),
                          onPressed: _bringUpSignInPage,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          : _current == CurrentPage.SignUp
              ? Column(
                  children: [
                    Container(
                      height: DeviceScreen.safeFullHeight * 0.4,
                      width: DeviceScreen.fullWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: DeviceScreen.fivePercentWidth),
                            child: RichText(
                              text: TextSpan(
                                text: '\nE',
                                style: TextStyle(
                                    color: AppColors.WHITE,
                                    fontFamily: 'bold',
                                    fontSize:
                                        DeviceScreen.fivePercentWidth * 2),
                                children: [
                                  TextSpan(
                                    text: 'X',
                                    style: TextStyle(
                                        color: AppColors.LIME,
                                        fontFamily: 'bold'),
                                  ),
                                  TextSpan(
                                    text: 'CHANGER',
                                    style: TextStyle(
                                        color: AppColors.WHITE,
                                        fontFamily: 'bold'),
                                  ),
                                  TextSpan(
                                    text: '\nIran\'s E-Voucher Solutions\n\n',
                                    style: TextStyle(
                                        color:
                                            AppColors.WHITE.withOpacity(0.87),
                                        fontFamily: 'bold',
                                        fontSize:
                                            DeviceScreen.fivePercentWidth *
                                                0.945),
                                  )
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: DeviceScreen.fivePercentWidth),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize:
                                      DeviceScreen.fivePercentWidth * 1.35,
                                  color: AppColors.WHITE),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                DeviceScreen.fivePercentWidth,
                                0,
                                DeviceScreen.fivePercentWidth * 2,
                                0),
                            child: Text(
                              'Exchange E-Voucher easily and safely, Cash in your E-Voucher and make profit',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize:
                                      DeviceScreen.fivePercentWidth * 0.65,
                                  color: AppColors.WHITE.withOpacity(0.87)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SignInSignUpFragment(
                          Process.SignUp, _bringUpSignInPage),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Container(
                      height: DeviceScreen.safeFullHeight * 0.4,
                      width: DeviceScreen.fullWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                left: DeviceScreen.fivePercentWidth),
                            child: RichText(
                              text: TextSpan(
                                text: '\nE',
                                style: TextStyle(
                                    color: AppColors.WHITE,
                                    fontFamily: 'bold',
                                    fontSize:
                                        DeviceScreen.fivePercentWidth * 2),
                                children: [
                                  TextSpan(
                                    text: 'X',
                                    style: TextStyle(
                                        color: AppColors.LIME,
                                        fontFamily: 'bold'),
                                  ),
                                  TextSpan(
                                    text: 'CHANGER',
                                    style: TextStyle(
                                        color: AppColors.WHITE,
                                        fontFamily: 'bold'),
                                  ),
                                  TextSpan(
                                    text: '\nIran\'s E-Voucher Solutions\n\n',
                                    style: TextStyle(
                                        color:
                                            AppColors.WHITE.withOpacity(0.87),
                                        fontFamily: 'bold',
                                        fontSize:
                                            DeviceScreen.fivePercentWidth *
                                                0.945),
                                  )
                                ],
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: DeviceScreen.fivePercentWidth),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize:
                                      DeviceScreen.fivePercentWidth * 1.35,
                                  color: AppColors.WHITE),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                DeviceScreen.fivePercentWidth,
                                0,
                                DeviceScreen.fivePercentWidth * 2,
                                0),
                            child: Text(
                              'Exchange E-Voucher easily and safely, Cash in your E-Voucher and make profit',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontFamily: 'bold',
                                  fontSize:
                                      DeviceScreen.fivePercentWidth * 0.65,
                                  color: AppColors.WHITE.withOpacity(0.87)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SignInSignUpFragment(
                          Process.SignIn, _bringUpSignUpPage),
                    ),
                  ],
                ),
    );
    Future.delayed(Duration.zero, () {
      first = false;
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: first
              ? FutureBuilder(
                  future: user.init(),
                  builder: (_, snap) {
                    if (snap.connectionState == ConnectionState.done &&
                        snap.hasData) {
                      if (snap.data == "no token") {
                        return welcomepage;
                      }
                      return Container();
                    }
                    return SplashScreen();
                  },
                )
              : welcomepage,
        ),
      ),
    );
  }
}
