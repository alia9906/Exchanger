import 'package:exchanger2/utils/device-screen-properties.dart';

class Images {
  
  static String get GOOGLE_ACCOUNT{
    if(DeviceScreen.dpi >= 3.0)
       return 'assets/images/xxhdpi/google_account.png';
  }

}