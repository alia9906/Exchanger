import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends AlertDialog {
  ErrorDialog(message)
      : super(
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
          ),
        );
}
