import 'package:exchanger2/helperwidgets/centererrortext.dart';
import 'package:exchanger2/helperwidgets/centerprogressbar.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/material.dart';

class ResponseDialog extends StatefulWidget {
  final Future<dynamic> _future;
  Function _onError, _onValue;
  ResponseDialog(this._future, {Function onError, Function onValue}) {
    _onError = onError;
    _onValue = onValue;
  }

  @override
  _ResponseDialogState createState() => _ResponseDialogState();
}

class _ResponseDialogState extends State<ResponseDialog> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget._future,
      builder: (_, snap) {
        Widget content = CenterProgressBar();
        if (snap.hasData && snap.connectionState == ConnectionState.done) {
          if (snap.data == null) {
            content = CenterErrorText("موفقیت آمیز بود!");
          } else {
            content = CenterErrorText(snap.data.toString());
          }
          if (widget._onValue != null) widget._onValue(snap.data);
        }
        if (snap.hasError) {
          content = CenterErrorText(CommonUtils.humanifyErrorMessage(snap.error));
          if (widget._onError != null) widget._onError(snap.error);
        }
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
          ),
          content: Container(
              height: DeviceScreen.safeFullHeight * 0.3, child: content),
        );
      },
    );
  }
}
