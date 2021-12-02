import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

//import 'package:system_settings/system_settings.dart';

enum AlertMessagType { DEFAULT, INFO, ERROR, WARNING, QUESTION, SUCCESS }

class Alert {
  static Future<void> showAlertDialog(
      BuildContext context, String title, String? msg, AlertMessagType type,
      [Function? fn]) async {
    Icon? icon;
    Color? color;

    switch (type) {
      case AlertMessagType.INFO:
        color = Colors.lightBlue[700];
        icon = Icon(
          Icons.info,
          color: color,
        );
        break;
      case AlertMessagType.ERROR:
        color = Colors.red[700];
        icon = Icon(
          Icons.warning,
          color: color,
        );
        break;
      case AlertMessagType.WARNING:
        color = Colors.orange[700];
        icon = Icon(
          Icons.warning,
          color: color,
        );
        break;
      case AlertMessagType.QUESTION:
        color = Colors.lightBlue[700];
        icon = Icon(
          Ionicons.help,
          color: color,
        );
        break;
      case AlertMessagType.SUCCESS:
        color = Colors.green[700];
        icon = Icon(
          Ionicons.information,
          color: color,
        );
        break;
      case AlertMessagType.DEFAULT:
        color = Colors.grey;
        icon = Icon(
          Ionicons.information,
          color: color,
        );
        break;
    }

    return showModal<void>(
        context: context,
        configuration: FadeScaleTransitionConfiguration(
            barrierDismissible: false,
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 250)),
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon!,
                      Flexible(
                        child: Text(
                          ' $title',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: color),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(
                    color: Colors.white,
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      msg!,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              // FlatButton(
                              //   child: Text(
                              //     'No',
                              //     style: TextStyle(color: Colors.white),
                              //   ),
                              //   onPressed: () {
                              //     Navigator.of(context).pop(false);
                              //   },
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: FlatButton(
                                  color: Colors.white,
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: color),
                                  ),
                                  onPressed: () {
                                    if (fn != null) {
                                      fn();
                                    }
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ])),
                  ),
                ],
              ),
            ),
          );
          // return new WillPopScope(
          //   onWillPop: () async => false,
          //   child: SimpleDialog(
          //     backgroundColor: Colors.white,
          //     elevation: 0.3,
          //     title: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         icon,
          //         Flexible(
          //           child: Text(
          //             ' $title',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w600,
          //                 fontSize: 14,
          //                 color: color),
          //           ),
          //         ),
          //       ],
          //     ),
          //     children: <Widget>[
          //       Center(
          //         child: Column(children: [
          //           // CircularProgressIndicator(),
          //           // SizedBox(
          //           //   height: 10,
          //           // ),
          //           Padding(
          //             padding: const EdgeInsets.all(10.0),
          //             child: Text(
          //               '$msg',
          //               style: TextStyle(color: Colors.black),
          //             ),
          //           )
          //         ]),
          //       ),
          //       // SizedBox(height: 20),
          //       Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: <Widget>[
          //             FlatButton(
          //               child: Text(
          //                 'OK',
          //                 style: TextStyle(color: color),
          //               ),
          //               onPressed: () {
          //                 if (fn != null) {
          //                   fn();
          //                 }
          //                 Navigator.of(context).pop();
          //               },
          //             )
          //           ])
          //     ],
          //   ),
          // );
        });
  }
}
