import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'alert_dialog.dart';

class ToastMessage {
  static Future<bool?> showToastMessage(
      BuildContext context, String msg, AlertMessagType type) {
    Color? color;
    switch (type) {
      case AlertMessagType.INFO:
        color = Colors.lightBlue[700];
        break;
      case AlertMessagType.ERROR:
        color = Colors.red[700];
        break;
      case AlertMessagType.WARNING:
        color = Colors.orange[700];
        break;
      case AlertMessagType.QUESTION:
        color = Colors.lightBlue[700];
        break;
      case AlertMessagType.SUCCESS:
        color = Colors.green[700];
        break;
      case AlertMessagType.DEFAULT:
        color = Colors.grey.withOpacity(0.9);
        break;
    }

    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
