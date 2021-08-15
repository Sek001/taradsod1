import 'package:flutter/material.dart';
import 'package:taradsod1/state/authen.dart';
import 'package:taradsod1/state/buyer_service.dart';
import 'package:taradsod1/state/create_account.dart';
import 'package:taradsod1/state/rider_service.dart';
import 'package:taradsod1/state/seller_service.dart';
import 'package:taradsod1/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/buyerservice': (BuildContext context) => BuyerService(),
  '/createaccount': (BuildContext context) => CreateService(),
  '/riderservice': (BuildContext context) => RiderService(),
  '/sellerservice': (BuildContext context) => SellerService(),
};

String? initlalRoute;

void main(List<String> args) {
  initlalRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}
