import 'dart:io';


import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taradsod1/utility/my_constant.dart';
import 'package:taradsod1/widget/show_image.dart';
import 'package:taradsod1/widget/show_title.dart';

class MyDialog {
  Future<Null> alertLocationService(
      BuildContext context, String titie, String masage) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image1),
          title: ShowTitle(
            title: titie,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: masage,
            textStyle: MyConstant().h3fStyle(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Navigator.pop(context);
              await Geolocator.openLocationSettings();
              exit(0);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<Null> normalDialog(
      BuildContext context, String title, String massage) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image1),
          title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(title: massage, textStyle: MyConstant().h3fStyle()),
        ),children: [TextButton(onPressed: ()=>Navigator.pop(context) , child: Text('OK'))],
      ),
    );
  }
}
