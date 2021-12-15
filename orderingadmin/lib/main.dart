import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/util/prefs.dart';
import 'package:orderingadmin/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/order_controller.dart';
import 'view/login.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
//  OrderController().load();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  await GetStorage.init();
  final pref = SharedPref();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getBool('isLogin') ?? false;
  if (isLogin) {
    User _user = User.fromJson(await pref.read('user'));
    runApp(pHome(_user));
    //   Get.off(() => HomePage(_user), transition: Transition.downToUp);
  } else {
    runApp(pLogin());
  }
}

class pLogin extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
      },
      // home: HomePage(),
    );
  }
}

class pHome extends StatelessWidget {
  final User user;
  final cOrder = Get.put(OrderController());
  pHome(this.user);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
      initialRoute: 'home',
      routes: {
        'login': (context) => LoginPage(),
        'home': (context) => HomePage(),
        // LoginScreen.routeName: (context) => const LoginScreen(),
        // DashboardScreen.routeName: (context) => const DashboardScreen(),
      },
      // home: HomePage(),
    );
  }
}

class CustomTheme {
  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat', //3
        buttonTheme: ButtonThemeData(
          // 4
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.green,
        ));
  }

  static IconThemeData get lightIconTheme {
    //1
    return const IconThemeData(
      //2
      color: Colors.green,
      // scaffoldBackgroundColor: Colors.white,
      // fontFamily: 'Montserrat', //3
      // buttonTheme: ButtonThemeData(
      //   // 4
      //   shape:
      //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      //   buttonColor: Colors.red,
      // )
    );
  }
}
