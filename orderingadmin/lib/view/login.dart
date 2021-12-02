import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/util/prefs.dart';
import 'package:orderingadmin/util/toast_message.dart';
import 'package:orderingadmin/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  // final GlobalKey<State> _keyConfirm = GlobalKey<State>();
  final api = HttpService();
  TextStyle style = const TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.green);
  final pref = SharedPref();
  TextEditingController cUsername = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final datacount = GetStorage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      ToastMessage.showToastMessage(
          context, "Tap again to exit the app.", AlertMessagType.DEFAULT);

      return Future.value(false);
    }

    return Future.value(true);
  }

  checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    if (isLogin) {
      //  User _user = User.fromJson(await pref.read('user'));
      Get.off(() => HomePage(), transition: Transition.downToUp);
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = TextFormField(
      controller: cUsername,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please your Username';
        }
        return null;
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(32.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(32.0),
          )),
    );
    final passwordField = TextFormField(
      controller: cPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please your Password';
        }
        return null;
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(32.0),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.green,
      child: Center(
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //       content: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Processing Request...'),
              //       CircularProgressIndicator()
              //     ],
              //   )),
              // );

              _login();
            }
          },
          child: Text("Login",
              textAlign: TextAlign.center,
              style: style.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: Get.height / 5),
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "assets/logo.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 45.0),
                    username,
                    const SizedBox(height: 25.0),
                    passwordField,
                    const SizedBox(
                      height: 35.0,
                    ),
                    loginButon,
                    const SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _login() async {
    LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
    LoginRequest login = LoginRequest();
    login.username = cUsername.text;
    login.password = cPassword.text;
    try {
      final result = await api.login(login).timeout(Duration(seconds: 60));

      if (result.statusCode == 200) {
        var body = await jsonDecode(result.body);
        User user = User.fromJson(body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        //  prefs.setString('user', user.toString());
        pref.save('user', user);
        Navigator.pop(_keyLoader.currentContext!, _keyLoader);
        Get.offAll(() => HomePage(), transition: Transition.downToUp);
      } else {
        ToastMessage.showToastMessage(context,
            "Invalid Username and/or Password.", AlertMessagType.DEFAULT);
        Navigator.pop(_keyLoader.currentContext!, _keyLoader);
        print(result.toString());
      }
    } on SocketException catch (e) {
      ToastMessage.showToastMessage(context,
          "Please check your network and try again.", AlertMessagType.DEFAULT);
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
      print(e.toString());
    } on TimeoutException catch (e) {
      ToastMessage.showToastMessage(
          context,
          "Server failed to respond, please try again.",
          AlertMessagType.DEFAULT);
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
      print(e.toString());
    } catch (e) {
      ToastMessage.showToastMessage(context,
          "Please check your network and try again.", AlertMessagType.DEFAULT);
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
      print(e.toString());
    }
  }
}
