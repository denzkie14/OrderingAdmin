import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';

class LoadingDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String msg) async {
    //ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: true);

    return showModal<void>(
        context: context,
        configuration: FadeScaleTransitionConfiguration(
            barrierDismissible: false,
            transitionDuration: const Duration(milliseconds: 500)),
        builder: (BuildContext context) {
          // return Container(
          //     color: Colors.transparent,
          //     child: Center(
          //       child: Image.asset(
          //         "assets/images/cctsspalsh.gif",
          //         width: ScreenUtil().setWidth(220),
          //         height: ScreenUtil().setHeight(220),
          //       ),
          //     ));
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  elevation: 0.3,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          msg,
                          style: TextStyle(color: Colors.grey),
                        )
                      ]),
                    )
                  ]));
        });
  }
}

class DefaultDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key, String msg) async {
    return showModal<void>(
        context: context,
        configuration: FadeScaleTransitionConfiguration(
            barrierDismissible: false,
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 250)),
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  elevation: 0.3,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          msg,
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
