import 'package:exchanger2/helperwidgets/billlist.dart';
import 'package:exchanger2/helperwidgets/transactionlist.dart';
import 'package:exchanger2/helperwidgets/walletinfo.dart';
import 'package:exchanger2/helperwidgets/walletlist.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum States { Bill, Trans, Wallet }

class WalletFragment extends StatefulWidget {
  @override
  _WalletFragmentState createState() => _WalletFragmentState();
}

class _WalletFragmentState extends State<WalletFragment> {
  States _state = States.Trans;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return SingleChildScrollView(
      child: SafeArea(
        child: (user.isUserAuthenticated && user.isUserVerified)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FutureBuilder(
                    future: user.getWalletInfo(ErrorHandlingType.Future),
                    builder: (_, snap) {
                      if (snap.hasError) {
                        return WalletInfo(snap.error);
                      }
                      print(snap.data);
                      return WalletInfo(snap.data);
                    },
                  ),
                  Container(
                    height: DeviceScreen.safeFullHeight * 0.1,
                    width: DeviceScreen.fullWidth,
                    padding: EdgeInsets.symmetric(
                        vertical: DeviceScreen.fivePercentWidth * 0.5,
                        horizontal: DeviceScreen.fivePercentWidth),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Container(
                          width: (DeviceScreen.fullWidth * 0.9) / 3.0,
                          child: OutlineButton(
                            child: Text(
                              'تراکنش ها',
                              style: TextStyle(
                                  color: _state == States.Trans
                                      ? AppColors.ALADDIN_SUGAR
                                      : Colors.black),
                            ),
                            onPressed: () {
                              setState(() {
                                _state = States.Trans;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: (DeviceScreen.fullWidth * 0.9) / 3.0,
                          child: OutlineButton(
                            child: FittedBox(
                              child: Text(
                                'قبض ها',
                                style: TextStyle(
                                    color: _state == States.Bill
                                        ? AppColors.ALADDIN_SUGAR
                                        : Colors.black),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _state = States.Bill;
                              });
                            },
                          ),
                        ),
                        Container(
                          width: (DeviceScreen.fullWidth * 0.9) / 3.0,
                          child: OutlineButton(
                            child: FittedBox(
                              child: Text(
                                'کیف پول',
                                style: TextStyle(
                                    color: _state == States.Wallet
                                        ? AppColors.ALADDIN_SUGAR
                                        : Colors.black),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _state = States.Wallet;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: _state == States.Trans
                        ? user.getTransactionList(ErrorHandlingType.Future)
                        : _state == States.Bill
                            ? user.getBillList()
                            : user.getWalletList(),
                    builder: (_, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snap.connectionState == ConnectionState.done) {
                        return _state == States.Trans
                            ? TransactionList(
                                DeviceScreen.safeFullHeight * 0.6, snap.data)
                            : _state == States.Bill
                                ? BillList(snap.data,
                                    DeviceScreen.safeFullHeight * 0.6)
                                : WalletList(snap.data,
                                    DeviceScreen.safeFullHeight * 0.6);
                      } else if (snap.hasError) {
                        return Center(
                          child: Text('error'),
                        );
                      } else {
                        return Center(
                          child: Text('some error happened'),
                        );
                      }
                    },
                  ),
                ],
              )
            : Container(
              height: DeviceScreen.safeFullHeight,
              child :Center(
                child: Text('ابتدا باید احراز هویت شوید!'),
              ),)
      ),
    );
  }
}
