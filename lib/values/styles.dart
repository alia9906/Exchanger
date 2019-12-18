import 'package:flutter/material.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';

class Styles {
  static TextStyle _FLATBUTTON_TEXT_UNDERLINE_PRIMARY;
  static TextStyle _FLATBUTTON_TEXT_PRIMARY_NORMALSIZE;
  static TextStyle _HEADER;

  Styles(BuildContext mbc) {
    if (_FLATBUTTON_TEXT_UNDERLINE_PRIMARY != null) return;

    _FLATBUTTON_TEXT_UNDERLINE_PRIMARY = TextStyle(
        fontSize: DeviceScreen.fullWidth * 0.055,
        decoration: TextDecoration.underline,
        color: Theme.of(mbc).primaryColorDark);
    _FLATBUTTON_TEXT_PRIMARY_NORMALSIZE =
        TextStyle(color: Theme.of(mbc).primaryColorDark);
    _HEADER = TextStyle(
        color: Theme.of(mbc).primaryColor,
        fontFamily: 'main',
        fontSize: DeviceScreen.fivePercentWidth);
  }

  static get FLATBUTTON_TEXT_UNDERLINE_PRIMARY {
    return _FLATBUTTON_TEXT_UNDERLINE_PRIMARY;
  }

  static get FLATBUTTON_TEXT_PRIMARY_NORMALSIZE {
    return _FLATBUTTON_TEXT_PRIMARY_NORMALSIZE;
  }

  static get HEADER {
    return _HEADER;
  }
}
