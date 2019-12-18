import 'package:exchanger2/helperwidgets/transactiondetails.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:exchanger2/model/transaction.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:intl/intl.dart' as Intl;

class TransactionList extends StatelessWidget {
  final double _height;
  List<TransactionItem> _transactions;
  TransactionList(this._height, this._transactions);

  @override
  Widget build(BuildContext context) {
    if (_transactions == null) {
      return Center(
        child: Text('خطای غیر مشخصی رخ داد !'),
      );
    }
    _transactions = _transactions.reversed.toList();
    return Container(
      height: _height,
      child: Card(
        elevation: DeviceScreen.fivePercentWidth * 0.15,
        margin: EdgeInsets.symmetric(
            vertical: DeviceScreen.fivePercentWidth * 0.5,
            horizontal: DeviceScreen.fivePercentWidth),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
        ),
        child: _transactions.length == 0
            ? Center(
                child: Text('هیچ تراکنشی انجام نداده اید!'),
              )
            : ListView.builder(
                itemBuilder: (_, i) {
                  bool sell = _transactions[i].status == Status.Sell;
                  print(_transactions[i].status);
                  return Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  TransactionDetails(_transactions[i]));
                        },
                        leading: CircleAvatar(
                          child: Icon(
                            sell ? Icons.shop : Icons.payment,
                          ),
                          backgroundColor: sell ? Colors.green : Colors.blue,
                        ),
                        title: sell ? Text('فروش') : Text('خرید'),
                        subtitle: Text(
                          Intl.DateFormat()
                              .add_yMd()
                              .add_Hm()
                              .format(_transactions[i].time),
                          maxLines: 1,
                        ),
                        trailing: Container(
                            width: DeviceScreen.fullWidth * 0.25,
                            child: FittedBox(
                                child: Text(CommonUtils.createReadablePrice(
                                        _transactions[i].amount) +
                                    'USD'))),
                      ),
                      Divider(
                        endIndent: DeviceScreen.fivePercentWidth,
                        indent: DeviceScreen.fivePercentWidth,
                      )
                    ],
                  );
                },
                itemCount: _transactions.length,
              ),
      ),
    );
  }
}
