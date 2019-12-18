import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final Color _color;
  final String _label;
  final IconData _iconData;
  final Function _ontap;

  ActivityItem(this._color, this._iconData, this._label, this._ontap);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _ontap(_label, context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(DeviceScreen.fivePercentWidth),
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _label,
            ),
            Icon(_iconData)
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_color.withOpacity(0.708), _color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
            DeviceScreen.fivePercentWidth,
          ),
        ),
      ),
    );
  }
}
