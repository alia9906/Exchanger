import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as Intl;

class BillList extends StatelessWidget {
   dynamic _data;
  final double _height;
  BillList(this._data, this._height);

  @override
  Widget build(BuildContext context) {
    if (_data == null) {
      return Center(
        child: Text('خطای غیر مشخصی رخ داد !'),
      );
    }
    try {
      _data.length;
    } catch (e) {
      return Center(
        child: Text('خطای غیر مشخصی رخ داد !'),
      );
    }
    if (_data.length == 0) {
      return Center(
        child: Text('هیچ تراکنشی انجام نداده اید!'),
      );
    }
    _data = _data.reversed.toList();
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
        child: ListView.builder(
          itemBuilder: (_, i) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      _data[i]['status'] == "successful"
                          ? Icons.check
                          : Icons.info,
                    ),
                    backgroundColor: _data[i]['status'] == "successful"
                        ? Colors.lightGreen
                        : Colors.red,
                  ),
                  title: Text(_data[i]['status']),
                  subtitle: Text(
                    Intl.DateFormat()
                        .add_yMd()
                        .add_Hm()
                        .format(DateTime.tryParse(_data[i]['time'])),
                    maxLines: 1,
                  ),
                  trailing: Container(
                      width: DeviceScreen.fullWidth * 0.25,
                      child: FittedBox(
                          child: Text(CommonUtils.createReadablePrice(
                                  _data[i]['amount_irr']) +
                              ' ریال'))),
                ),
                Divider(
                  endIndent: DeviceScreen.fivePercentWidth,
                  indent: DeviceScreen.fivePercentWidth,
                )
              ],
            );
          },
          itemCount: _data.length,
        ),
      ),
    );
  }
}
