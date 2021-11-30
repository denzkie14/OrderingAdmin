// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:ustore_market/constants.dart';

// showAlert(String message, MessageType type) {
//   Color? _color = Colors.lightBlue;
//   Icon _icon = Icon(Ionicons.information_circle_outline);
//   switch (type) {
//     case MessageType.DEFAULT:
//       _color = Colors.lightBlue;
//       _icon = Icon(Ionicons.information_circle_outline);
//       break;
//     case MessageType.ERROR:
//       _icon = Icon(Icons.error_outline_rounded);
//       _color = Colors.red;
//       break;
//     case MessageType.SUCCESS:
//       _color = Colors.green;
//       _icon = Icon(Ionicons.information_circle_outline);
//       break;
//     case MessageType.QUESTION:
//       _color = Colors.lightBlue;
//       _icon = Icon(Ionicons.help_circle_outline);
//       break;
//     case MessageType.WARNING:
//       _icon = Icon(Ionicons.warning_outline);
//       _color = Colors.lightBlue;
//       break;
//   }

//   Get.defaultDialog(
//     title: "Alert",
//     titleStyle: TextStyle(color: _color),
//     content: Text(
//       "This is a sample Content",
//     ),
//   );
// }

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../constants.dart';

enum AlertMessagType { INFO, ERROR, WARNING, QUESTION, SUCCESS }

class Alert {
  static showAlert(
      BuildContext context, String title, String msg, MessageType type,
      {String? btnLabel}) async {
    Icon icon;
    Color color;
    switch (type) {
      case MessageType.DEFAULT:
        color = Colors.blue;
        icon = Icon(
          Icons.info,
          color: color,
        );
        break;
      case MessageType.ERROR:
        color = Colors.red;
        icon = Icon(
          Icons.error_outline,
          color: color,
        );
        break;
      case MessageType.WARNING:
        color = Colors.orange;
        icon = Icon(
          Ionicons.warning_outline,
          color: color,
        );
        break;
      case MessageType.QUESTION:
        color = Colors.blue;
        icon = Icon(
          Ionicons.help_circle_outline,
          color: color,
        );
        break;
      case MessageType.SUCCESS:
        color = Colors.green;
        icon = Icon(
          Ionicons.information_circle_outline,
          color: color,
        );
        break;
    }

    return showModal(
        configuration:
            FadeScaleTransitionConfiguration(barrierDismissible: false),
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Text(
                msg,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              actions: <Widget>[
                // FlatButton(
                //   child: Text('No'),
                //   onPressed: () => Navigator.pop(context, false),
                // ),
                TextButton(
                  child: Text(btnLabel ?? 'OK', style: TextStyle(color: color)),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
            ));
  }

  static showConfirm<bool>(
      BuildContext context, String title, String msg, MessageType type,
      {String? confirmLabel, String? cancelLabel}) async {
    Icon icon;
    Color color;
    switch (type) {
      case MessageType.DEFAULT:
        color = Colors.blue;
        icon = Icon(
          Icons.info,
          color: color,
        );
        break;
      case MessageType.ERROR:
        color = Colors.red;
        icon = Icon(
          Icons.error_outline,
          color: color,
        );
        break;
      case MessageType.WARNING:
        color = Colors.orange;
        icon = Icon(
          Ionicons.warning_outline,
          color: color,
        );
        break;
      case MessageType.QUESTION:
        color = Colors.blue;
        icon = Icon(
          Ionicons.help_circle_outline,
          color: color,
        );
        break;
      case MessageType.SUCCESS:
        color = Colors.green;
        icon = Icon(
          Ionicons.information_circle_outline,
          color: color,
        );
        break;
    }

    return showModal(
        configuration:
            FadeScaleTransitionConfiguration(barrierDismissible: false),
        context: context,
        builder: (context) => AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(
                    width: 10.0,
                  ),
                  Flexible(
                    child: Text(
                      title,
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              content: Text(
                msg,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(cancelLabel ?? 'NO',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  onPressed: () => Navigator.pop(context, false),
                ),
                // SizedBox(
                //   width: 5.0,
                // ),
                TextButton(
                  child: Text(confirmLabel ?? 'OK',
                      style:
                          TextStyle(color: color, fontWeight: FontWeight.w400)),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
            ));
  }

  //   var width = MediaQuery.of(context).size.width / 1.2;
  //   return showModal(
  //       configuration:
  //           FadeScaleTransitionConfiguration(barrierDismissible: false),
  //       context: context,
  //       builder: (context) => Dialog(
  //             // title: Row(
  //             //   mainAxisAlignment: MainAxisAlignment.center,
  //             //   children: [
  //             //     icon,
  //             //     SizedBox(
  //             //       width: 10.0,
  //             //     ),
  //             //     Flexible(
  //             //       child: Text(
  //             //         title,
  //             //         style:
  //             //             TextStyle(color: color, fontWeight: FontWeight.bold),
  //             //       ),
  //             //     ),
  //             //   ],
  //             // ),
  //             child: Container(
  //               height: MediaQuery.of(context).size.height / 3.5,
  //               width: width,
  //               child: Stack(
  //                 children: [
  //                   Positioned(
  //                       top: -20,
  //                       left: width / 2.5,
  //                       //  alignment: Alignment.topCenter,
  //                       child: Container(
  //                         child: CircleAvatar(
  //                           radius: 35,
  //                           child: Text('U'),
  //                         ),
  //                       )),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: Text(
  //                       msg,
  //                       style: TextStyle(
  //                           color: Colors.grey[800],
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.w400),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.bottomCenter,
  //                     child: Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           // FlatButton(
  //                           //   child: Text('No'),
  //                           //   onPressed: () => Navigator.pop(context, false),
  //                           // ),
  //                           TextButton(
  //                             child: Text(btnLabel ?? 'OK',
  //                                 style: TextStyle(color: color)),
  //                             onPressed: () {
  //                               Navigator.pop(context, true);
  //                             },
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             // actions: <Widget>[
  //             //   // FlatButton(
  //             //   //   child: Text('No'),
  //             //   //   onPressed: () => Navigator.pop(context, false),
  //             //   // ),
  //             //   TextButton(
  //             //     child: Text(btnLabel ?? 'OK', style: TextStyle(color: color)),
  //             //     onPressed: () {
  //             //       Navigator.pop(context, true);
  //             //     },
  //             //   )
  //             // ],
  //           ));
  // }
}
