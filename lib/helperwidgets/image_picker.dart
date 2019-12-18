import 'dart:io';

import 'package:exchanger2/helperwidgets/error_dialog.dart';
import 'package:exchanger2/utils/device-screen-properties.dart';
import 'package:exchanger2/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as IP;

class ImagePickerWidget extends StatefulWidget {
  int _id;
  Function _onFileChosen;

  ImagePickerWidget(this._id, this._onFileChosen);
  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File _image;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        IP.ImagePicker.pickImage(
                source: IP.ImageSource.gallery,)
            .then((file) async {
              print(file);
          if (await file.length() > 384000) {
            return showDialog(
                context: context,
                builder: (_) =>
                    ErrorDialog("حجم فایل نباید بیش از ۳۸۴ کیلوبایت باشد."));
          }
          setState(() {
            _image = file;
          });
          widget._onFileChosen(widget._id, _image);
        }).catchError((err) => print(err));
      },
      child: Container(
        height: DeviceScreen.fullWidth * 0.2,
        width: DeviceScreen.fullWidth * 0.3,
        alignment: Alignment.center,
        child: _image != null
            ? Image.file(
                _image,
                fit: BoxFit.contain,
                width: DeviceScreen.fullWidth * 0.3,
              )
            : FittedBox(
                child: FlatButton(
                  child: Text(
                    'انتخاب عکس',
                    style: Styles.FLATBUTTON_TEXT_PRIMARY_NORMALSIZE,
                  ),
                ),
              ),
      ),
    );
  }
}
