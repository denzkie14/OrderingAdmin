import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'alert_dialog.dart';

class Confirm {
  static Future<bool?> showAlertDialog(BuildContext context, GlobalKey key,
      String title, String msg, AlertMessagType type) async {
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
        color = Colors.green[700];
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

    return showModal<bool>(
        context: context,
        configuration: const FadeScaleTransitionConfiguration(
            barrierDismissible: false,
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 150)),
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: const RoundedRectangleBorder(
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
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      msg,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: Text(
                                    'No',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                ),
                                TextButton(
                                  //  color: Colors.white,
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: color),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                ),
                              ]),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ConfirmBool {
  static Future<bool?> showConfirmDialog(
    BuildContext context,
    String title,
    String message,
    AlertMessagType type,
  ) async {
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
        color = Colors.green[700];
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

    return showModal<bool>(
        configuration:
            const FadeScaleTransitionConfiguration(barrierDismissible: false),
        context: context,
        builder: (context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon!,
                  const SizedBox(
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
              content: Text(message),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.grey),
                      ),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                    ElevatedButton(
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.green),
                      ),
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                    )
                  ],
                ),
              ],
            ));
  }
}
