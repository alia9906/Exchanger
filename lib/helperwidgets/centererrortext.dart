import 'package:exchanger2/utils/common.dart';
import 'package:flutter/material.dart';

class CenterErrorText extends StatelessWidget {
  final String _message;
  CenterErrorText(this._message);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          child: Text(CommonUtils.humanifyErrorMessage(_message))),
    );
  }
}
