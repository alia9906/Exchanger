import 'package:exchanger2/fragmentscreens/activity.dart';
import 'package:exchanger2/fragmentscreens/profile.dart';
import 'package:exchanger2/fragmentscreens/wallet.dart';
import 'package:exchanger2/helperwidgets/appbars.dart';
import 'package:exchanger2/helperwidgets/drawers.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  List<List<Widget>> _fragments(BuildContext c) { return [
    [ProfileFragment(), AppBars.profileAppBar() , Drawers.getProfileDrawer(c)],
    [ActivityFragment(), AppBars.activitiesAppBar() , null],
    [WalletFragment(), AppBars.walletAppBar() , null]
  ];
  }
  int _current = 0;

  void _switchFragment(int index) {
    if (index != _current) {
      setState(() {
        _current = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _fragments(context)[_current][1],
      drawer: _fragments(context)[_current][2],
      body: SingleChildScrollView(child: _fragments(context)[_current][0]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _switchFragment,
        currentIndex: _current,
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: AppColors.LIME,
        unselectedItemColor: AppColors.ALADDIN_WHITE,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            title: Text('پروفایل'),
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            title: Text('فعالیت ها'),
            icon: Icon(Icons.local_activity),
          ),
          BottomNavigationBarItem(
            title: Text('کیف پول'),
            icon: Icon(Icons.account_balance_wallet),
          ),
        ],
      ),
    );
  }
}
