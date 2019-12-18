import 'package:flutter/widgets.dart';
import 'package:exchanger2/utils/common.dart';

class DeviceScreen {
  //properties only for portrait

  static double _fullWidth;
  static double _fullHeight;

  static double _fivePercentWidth;
  static double _fivePercentHeight;

  static double _statusBar;
  static double _dpi;

  DeviceScreen(BuildContext materialContext) {
    if (_fullHeight != null) return;

    MediaQueryData mqd = MediaQuery.of(materialContext);

    double fullPortraitWidth = mqd.size.width;
    double fullPortraitHeight = mqd.size.height;

    _fullHeight = CommonUtils.max(fullPortraitHeight, fullPortraitWidth);
    _fullWidth = CommonUtils.min(fullPortraitHeight, fullPortraitWidth);

    _fivePercentHeight = _fullHeight * 0.05;
    _fivePercentWidth = _fullWidth * 0.05;

    _statusBar = mqd.padding.top;
    _dpi = mqd.devicePixelRatio;
  }

  static double get fullWidth {
    return _fullWidth;
  }

  static double get fullHeight {
    return _fullHeight;
  }

  static double get safeFullHeight {
    return _fullHeight - _statusBar;
  }

  static double get fivePercentWidth {
    return _fivePercentWidth;
  }

  static double get fivePercentHeight {
    return _fivePercentHeight;
  }

  static double get statusBar {
    return _statusBar;
  }

  static double get dpi {
    return _dpi;
  }
}
