import 'package:flutter/material.dart';


import 'dart:typed_data';
class AppConstants {
  static const appPrimaryColor = Color(0xff0c54be);
  static const appBgColor = Color(0xFFF5F9FD);
  static const appFontcolor = Color(0xFFCED3DC);

  static const h_5 = SizedBox(height: 5);
  static const h_10 = SizedBox(height: 10);
  static const h_20 = SizedBox(height: 20);
  static const h_24 = SizedBox(height: 24);
  static const h_30 = SizedBox(height: 30);
  static const h_40 = SizedBox(height: 40);
  static const h_50 = SizedBox(height: 50);
  static const h_60 = SizedBox(height: 60);

  static const w_5 = SizedBox(width: 5);
  static const w_10 = SizedBox(width: 10);
  static const w_15 = SizedBox(width: 15);
  static const w_20 = SizedBox(width: 20);
  static const w_22 = SizedBox(width: 22);
  static const w_25 = SizedBox(width: 25);
  static const w_30 = SizedBox(width: 30);
  static const w_40 = SizedBox(width: 40);

  static const all_5 = EdgeInsets.all(5);
  static const all_10 = EdgeInsets.all(10);
  static const all_15 = EdgeInsets.all(15);
  static const all_20 = EdgeInsets.all(20);
  static const all_100 = EdgeInsets.all(100);

  static const leftRight_5 = EdgeInsets.only(left: 5, right: 5);
  static const leftRight_10 = EdgeInsets.only(left: 10, right: 10);
  static const leftRight_20 = EdgeInsets.only(left: 20, right: 20);

  static const left10 = EdgeInsets.only(left: 10);
  static const left20 = EdgeInsets.only(left: 20);
  static const left100 = EdgeInsets.only(left: 100);

  static const boxRadius8 = BorderRadius.all(Radius.circular(8));
  static const boxRadiusAll12 = BorderRadius.all(Radius.circular(12));
  static const boxRadius12 = BorderRadius.only(
      bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12));
  static const boxRadius15 = BorderRadius.all(Radius.circular(15));

  static const outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white), borderRadius: boxRadius15);
  static var boxBorderDecorationPrimary = BoxDecoration(
      border: Border.all(color: appPrimaryColor),
      borderRadius: boxRadius8,
      color: appPrimaryColor);

  static InputDecoration toAppInputDecoration2(
      BuildContext context, String hint, String counterText) {
    return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        counterStyle: Theme.of(context).textTheme.caption,
        counterText: counterText,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        border: outlineInputBorder);
  }

  static void showSnackBar(BuildContext context, String msg) {
    final snackBar = SnackBar(
        content: Text(msg, style: Theme.of(context).textTheme.headline4),
        backgroundColor: appPrimaryColor,
        duration: const Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void moveNextstl(BuildContext context, StatelessWidget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
  static void moveNextClearAll(BuildContext context, StatelessWidget widget) {
    Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => widget,
        ),
        ModalRoute.withName(
            "/") //(route) => false, //if you want to disable back feature set to false
        );
  }
  
}

final Uint8List kTransparentImage =  Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);
