import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

showToast(String message, MessageType type) {
  // Color? _color = Colors.green[400];
  // switch (type) {
  //   case MessageType.DEFAULT:
  //     _color = Colors.green[400];
  //     break;
  //   case MessageType.ERROR:
  //     _color = Colors.red;
  //     break;
  //   case MessageType.SUCCESS:
  //     _color = Colors.green;
  //     break;
  //   case MessageType.QUESTION:
  //     _color = Colors.lightBlue;
  //     break;
  //   case MessageType.WARNING:
  //     _color = Colors.lightBlue;
  //     break;
  // }

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      // backgroundColor: Colors.red,
      //  textColor: type == MessageType.DEFAULT ? Colors.black : Colors.white,
      fontSize: 16.0);
}
