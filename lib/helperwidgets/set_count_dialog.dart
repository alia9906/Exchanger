import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart' as vl;

class SetCountDialog extends StatelessWidget {
  final TextEditingController _tec = TextEditingController();
  final Function _onSet;
  final double _max;

  SetCountDialog(this._onSet, this._max);

  void _set(BuildContext context) {
    if (vl.isFloat(_tec.text)) {
      if (double.tryParse(_tec.text) <= _max) {
        if (double.tryParse(_tec.text) <= 0) {
          _tec.text = "";
          showDialog(
              context: context, builder: (_) => ErrorDialog('عدد منفی!'));
          return;
        }
        if (double.tryParse(_tec.text) < 1.0) {
          _tec.text = "";
          showDialog(
              context: context, builder: (_) => ErrorDialog('حداقل مقدار 1.0 است!'));
          return;
        }
        _onSet(_tec.text);
        Navigator.of(context).pop();
      } else {
        _tec.text = "";
        showDialog(
            context: context,
            builder: (_) => ErrorDialog('حداکثر تعداد $_max است!'));
      }
    } else {
      _tec.text = "";
      showDialog(
          context: context, builder: (_) => ErrorDialog('لطفا عدد وارد کنید!'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: DeviceScreen.fivePercentWidth),
      height: DeviceScreen.safeFullHeight * 0.2,
      child: AlertDialog(
        actions: <Widget>[
          FlatButton(
            onPressed: () => _set(context),
            child: Text('تایید'),
          )
        ],
        content: TextField(
          controller: _tec,
          decoration: InputDecoration(labelText: 'تعداد'),
          onSubmitted: (_) => _set(context),
        ),
      ),
    );
  }
}
