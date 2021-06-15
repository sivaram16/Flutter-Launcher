import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils {
  /// Showing toast message
  static void showToast(String text,
      {Color color = Colors.green,
      ToastGravity? toastGravity,
      String? webColor}) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: toastGravity ?? ToastGravity.BOTTOM,
        backgroundColor: color,
        textColor: Colors.white,
        webBgColor: webColor,
        webShowClose: true,
        timeInSecForIosWeb: 3,
        webPosition: "center",
        fontSize: 14.0);
  }
}
