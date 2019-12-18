import 'package:exchanger2/providers/user.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: user.getOrders(),
          builder: (_, snap) {
            if (snap.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (_, i) {
                  var data = snap.data[i] as Map<dynamic, dynamic>;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: data['status'] == "pending"
                          ? Colors.blue
                          : data['status'] == "successful"
                              ? Colors.green
                              : Colors.red,
                      child: FittedBox(
                          child: Text(
                        data['status'],
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    title: FittedBox(
                        child: Text(
                      "Activation : " + data['activationcode'],
                      style: Theme.of(context).textTheme.title,
                    )),
                    subtitle: FittedBox(
                        child: Text(
                      "Code : " + data['code'],
                      style: Theme.of(context).textTheme.title,
                    )),
                    trailing: Text(DateFormat()
                        .add_yMd()
                        .add_Hm()
                        .format(DateTime.parse(data['time']))),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
