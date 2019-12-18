import 'package:exchanger2/constants/routes.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:exchanger2/scaffscreens/SELL_SCREEN.DART';

class SellDialog extends StatefulWidget {
  @override
  _SellDialogState createState() => _SellDialogState();
}

class _SellDialogState extends State<SellDialog> {
  TextEditingController tec = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
      ),
      content: Container(
        height: DeviceScreen.safeFullHeight * 0.2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton(
              child: Text(
                'فروش PremiumVoucher',
                style: Styles.FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(SELL_SCREEN , arguments: SellType.Premium);
              },
            ),
            FlatButton(
              child: Text(
                'فروش PerfectMoney',
                style: Styles.FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
              ),
              onPressed: (){
                Navigator.of(context).pushNamed(SELL_SCREEN , arguments: SellType.Perfect );
              },
            )
          ],
        ),
      ),
    );
  }
}
