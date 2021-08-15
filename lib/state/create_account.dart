import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taradsod1/utility/my_constant.dart';
import 'package:taradsod1/utility/my_dialog.dart';
import 'package:taradsod1/widget/show_image.dart';
import 'package:taradsod1/widget/show_progress.dart';
import 'package:taradsod1/widget/show_title.dart';

class CreateService extends StatefulWidget {
  const CreateService({Key? key}) : super(key: key);

  @override
  _CreateServiceState createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  String? typeUser;
  File? file;
  double? lat, lng;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          //Find LatLang
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          //Find Lating
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่?',
          'กรุณาเปิด Location Service ด้วยค่ะ');
    }
  }

  Future<Null> findLatLng() async {
    print('findLatLan ==>Work');
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat =$lat,lng=$lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {}
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Name ด้วยค่ะ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3fStyle(),
              labelText: 'Name:',
              prefixIcon: Icon(
                Icons.fingerprint,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ที่อยู่ ด้วยค่ะ';
              } else {}
            },
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Adress :',
              hintStyle: MyConstant().h3fStyle(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: MyConstant.dark,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก เบอร์โทรศัพท์ ด้วยค่ะ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3fStyle(),
              labelText: 'Phone:',
              prefixIcon: Icon(
                Icons.phone,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก Password ด้วยค่ะ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3fStyle(),
              labelText: 'Password:',
              prefixIcon: Icon(
                Icons.lock_outline,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  Row buildUser(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก User ด้วยค่ะ';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3fStyle(),
              labelText: 'User:',
              prefixIcon: Icon(
                Icons.perm_identity,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildCreateNewAccount(),
        ],
        title: Text('Create New Account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle1('ข้อมูลทั่วไป'),
                buildName(size),
                buildTitle1('ชนิดของUser :'),
                buildRadioBuyer(size),
                buildRadioSeller(size),
                buildRadioRider(size),
                buildTitle1('ข้อมูลพื้นฐาน'),
                buildAddress(size),
                buildPhone(size),
                buildUser(size),
                buildPassword(size),
                buildTitle1('รูปภาพ'),
                buildSubTitle(),
                buildavatar(size),
                buildTitle1('แสดงพิกัดที่คุณอยู่'),
                buidMap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (typeUser == null) {
            print('Non Choose Type User');
            MyDialog().normalDialog(context, 'ยังไม่ได้เลือก ชนิดของ User',
                'กรุณาเลือกชนืดของ User');
          } else {
            print('Process Insert to Database');
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
    );
  }

  Widget buidMap() => Container(
        width: double.infinity,
        height: 300,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 16,
                ),
                onMapCreated: (controller){},
              ),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildavatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
      title:
          'เป็นรูปภาพ ที่แสดงความเป็นตัวตนของ User(แต่ถ้าไมสดวกแชร์เราจะแสดงภาพ defaultแทน)',
      textStyle: MyConstant().h3fStyle(),
    );
  }

  Row buildRadioBuyer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: ('ผู้ซื้อ(Buyer)'),
              textStyle: MyConstant().h3fStyle(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(
                () {
                  typeUser = value as String;
                },
              );
            },
            title: ShowTitle(
              title: ('ผู้ขาย(Seller)'),
              textStyle: MyConstant().h3fStyle(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildRadioRider(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size * 0.6,
          child: RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: ('ผู้ส่ง(Rider)'),
              textStyle: MyConstant().h3fStyle(),
            ),
          ),
        ),
      ],
    );
  }

  Container buildTitle1(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
