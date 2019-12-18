import 'package:flutter/material.dart';

class ErrorSnackBar extends SnackBar {
  ErrorSnackBar(_message)
      : super(
            content: Text(_message),
            duration: Duration(milliseconds: _message.length * 100));
}
