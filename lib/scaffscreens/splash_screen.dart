import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = true;
  bool continueAnimation = true;
  bool isRunning = false;
  Future<void> doAnimation() async {
    isRunning = true;
    int x = 100;
    await Future.delayed(Duration(milliseconds: x), () {
      if (continueAnimation)
        setState(() {
          visible = false;
        });
    });
    await Future.delayed(Duration(milliseconds: x), () {
      if (continueAnimation)
        setState(() {
          visible = true;
        });
    });
    await Future.delayed(Duration(milliseconds: x), () {
      if (continueAnimation)
        setState(() {
          visible = false;
        });
    });
    await Future.delayed(Duration(milliseconds: x), () {
      if (continueAnimation)
        setState(() {
          visible = true;
        });
    });
    await Future.delayed(Duration(milliseconds: 750));
    if (continueAnimation) doAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    continueAnimation = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isRunning) doAnimation();
    return Container(
      height: DeviceScreen.safeFullHeight,
      width: DeviceScreen.fullWidth,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          visible
              ? Container(
                  height: 300,
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: '\'',
                      style: TextStyle(
                          color: AppColors.ALADDIN_ZERESHKI,
                          fontFamily: 'bold',
                          fontSize: DeviceScreen.fivePercentWidth * 6),
                      children: [
                        TextSpan(
                          text: 'X',
                          style: TextStyle(
                              color: AppColors.LIME,
                              fontFamily: 'bold',
                              fontSize: DeviceScreen.fivePercentWidth * 6),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  height: 300,
                ),
          Text(
            'Please Wait',
            style: TextStyle(
                fontFamily: 'bold', color: AppColors.WHITE.withOpacity(0.9)),
          )
        ],
      ),
    );
  }
}
