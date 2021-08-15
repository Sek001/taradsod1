import 'package:flutter/material.dart';

class MyConstant {
//General
  static String appName = 'Taradsod';

  //Rouye
  static String routeAuthen = '/authen';
  static String routeBuyerService = '/buyerservice';
  static String routeCreateAccount = '/createaccount';
  static String routeRiderService = '/riderservice';
  static String routeSellerService = '/sellerservice';

//Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String avatar = 'images/avatar.png';

//Color
  static Color primary = Color(0xfffb8c00);
  static Color dark = Color(0xffc25e00);
  static Color light = Color(0xffffbd45);
//Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3fStyle() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
