import 'package:exchanger2/helperwidgets/buy_type_widget.dart';
import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/helperwidgets/error_snackbar.dart';
import 'package:exchanger2/helperwidgets/set_count_dialog.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:provider/provider.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/material.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  double _premiumCount = 0;
  double _regularCount = 0;
  int _premiumcost = 0;
  int _regulacost = 0;
  double _max = -1;

  double get _totalCost {
    return _premiumCount * _premiumcost + _regularCount * _regulacost;
  }

  void _setPremium(String text) {
    setState(() {
      _premiumCount = double.parse(text);
      _regularCount = 0.0;
    });
  }

  void _setRegular(String text) {
    setState(() {
      _regularCount = double.parse(text);
      _premiumCount = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: DeviceScreen.safeFullHeight,
          width: DeviceScreen.fullWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FutureBuilder(
                future: user.getPrices(),
                builder: (_, snap) {
                  if (snap.connectionState == ConnectionState.done) {
                    if (snap.hasData) {
                      _premiumcost =
                          int.tryParse(snap.data['premiumVoucherPrice']);
                      _regulacost =
                          int.tryParse(snap.data['perfectMoneyPrice']);
                      _max = double.tryParse(snap.data['limit']);
                    }
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        SetCountDialog(_setPremium, _max));
                              },
                              leading: CircleAvatar(
                                child: Image.asset(
                                  'assets/images/all/premiumvouchers.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              title: Text('Premium Vouchers'),
                              subtitle: Text(
                                  '${CommonUtils.createReadablePrice(_premiumcost.toString())} ریال'),
                              trailing: Text("$_premiumCount \$"),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        SetCountDialog(_setRegular, _max));
                              },
                              leading: CircleAvatar(
                                child: Image.asset(
                                  'assets/images/all/perfectmoney.png',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              trailing: Text("$_regularCount \$"),
                              subtitle: Text(
                                  '${CommonUtils.createReadablePrice(_regulacost.toString())} ریال'),
                              title: Text('Perfect Money'),
                            ),
                          ),
                        ],
                      ),
                      height: DeviceScreen.safeFullHeight * 0.35,
                      padding: EdgeInsets.symmetric(
                          horizontal: DeviceScreen.fivePercentWidth),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              Container(
                width: double.infinity,
                color: Theme.of(context).cursorColor,
                height: DeviceScreen.fullWidth * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      splashColor: Theme.of(context).canvasColor,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: DeviceScreen.fivePercentWidth * 0.5),
                        height: DeviceScreen.safeFullHeight * 0.06,
                        width: DeviceScreen.fullWidth * 0.7,
                        color: AppColors.LIME,
                        child: FittedBox(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.payment, color: Colors.black),
                              SizedBox(
                                width: DeviceScreen.fivePercentWidth * 0.5,
                              ),
                              Text(
                                'پرداخت نهایی :  ${CommonUtils.createReadablePrice(_totalCost.toString())} ریال',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                BuyTypeWidget(_premiumCount, _regularCount));
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'حذف همه',
                        style: TextStyle(color:Colors.yellowAccent),
                      ),
                      onPressed: () {
                        setState(() {
                          _regularCount = 0;
                          _premiumCount = 0;
                        });
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
