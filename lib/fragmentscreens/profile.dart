import 'package:exchanger2/constants/routes.dart';
import 'package:exchanger2/helperwidgets/error_snackbar.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/scaffscreens/user_verification_screen.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceScreen(context);
    User user = Provider.of<User>(context);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: DeviceScreen.fullHeight * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: DeviceScreen.fivePercentWidth * 6,
                  color: AppColors.WHITE,
                ),
                Container(
                  child: Text(
                    user.accountName,
                    style: TextStyle(color: Colors.white),
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          
          Card(
            margin: EdgeInsets.all(DeviceScreen.fivePercentWidth),
            
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.transform, color: Colors.blue),
                  title: Text('حداکثر میزان تراکنش'),
                  subtitle: Text(user.maxTarakonesh),
                ),
                Divider(
                  indent: DeviceScreen.fivePercentWidth,
                  endIndent: DeviceScreen.fivePercentWidth,
                ),
                ListTile(
                  leading: Icon(
                    Icons.verified_user,
                    color:
                        user.isUserVerified ? Colors.lightGreen : Colors.grey,
                  ),
                  title: Text('احراز هویت'),
                  subtitle: user.isUserVerified
                      ? Text('شما شناسایی شده اید!')
                      : user.isVerifying
                          ? Text('ویرایش فایل ها')
                          : Text('شما شناسایی نشده اید!'),
                  trailing: user.isUserVerified
                      ? Container(
                          height: 0,
                          width: 0,
                        )
                      : CircleAvatar(
                          child: Icon(
                            user.isUserVerified
                                ? Icons.check_circle
                                : Icons.error,
                          ),
                          backgroundColor: user.isUserVerified
                              ? AppColors.ALADDIN_SUNRAY
                              : AppColors.ALADDIN_ZERESHKI,
                        ),
                  onTap: () {
                    if (!user.isUserVerified) {
                      Navigator.of(context)
                          .pushNamed(USER_VERIFY_PAGE, arguments: [
                        user.showWhichVerifyPrams,
                        user.isVerifying
                            ? VerificationState.Edit
                            : VerificationState.First
                      ]);
                    }
                  },
                ),
                Divider(
                  indent: DeviceScreen.fivePercentWidth,
                  endIndent: DeviceScreen.fivePercentWidth,
                ),
                ListTile(
                  leading: Icon(Icons.message, color: AppColors.ALADDIN_PURPLE),
                  title: Text('پیام های مدیریت'),
                  subtitle: Text('احراز هویت , ...'),
                  trailing: CircleAvatar(
                    child: Text(user.messagesCount.toString()),
                    backgroundColor: AppColors.ALADDIN_SUNRAY,
                  ),
                  onTap: () {
                    if (user.messagesCount != 0) {
                      Navigator.of(context).pushNamed(USER_MODIRIAT_MESSAGES);
                    }
                  },
                ),
                Divider(
                  indent: DeviceScreen.fivePercentWidth,
                  endIndent: DeviceScreen.fivePercentWidth,
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_basket,
                    color: Colors.indigo,
                  ),
                  title: Text('سفارش های فروش'),
                  subtitle: Text('سفارش های PerfectMoney'),
                  onTap: () {
                    if (user.ordersCount == 0) {
                      Scaffold.of(context)
                          .showSnackBar(ErrorSnackBar("سفارشی ندارید !"));
                    } else {
                      Navigator.of(context).pushNamed(ORDERS_SCREEN);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
