import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/common.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class UserMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: user.getModiriatMessages(ErrorHandlingType.Future),
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.connectionState == ConnectionState.done) {
              print(snap.data);
              if (!snap.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                itemBuilder: (_, i) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                ErrorDialog((snap.data)[i]['text'].toString()));
                      },
                      title: Text((snap.data)[i]['title'].toString()),
                      subtitle: Text((snap.data)[i]['text'].toString()),
                      trailing: Column(
                        children: <Widget>[
                          Container(
                            width: DeviceScreen.fullWidth * 0.2,
                            child: FittedBox(
                              child: Text(DateFormat().add_yMd().add_Hm().format(
                                  DateTime.tryParse((snap.data)[i]['time']))),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios , color: AppColors.LIME,)
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
                itemCount: (snap.data).length,
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
