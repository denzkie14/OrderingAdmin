import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/confirm_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/view/Category/categories.dart';
import 'package:orderingadmin/view/Kiosk/kiosks.dart';
import 'package:orderingadmin/view/login.dart';
import 'package:orderingadmin/view/profile.dart';
import 'package:orderingadmin/view/users.dart';
import 'package:shared_preferences/shared_preferences.dart';

appDrawer(BuildContext context) {
  final drawerWidth = MediaQuery.of(context).size.width / 1.3;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyConfirm = new GlobalKey<State>();

  return Container(
    width: drawerWidth,
    child: Drawer(
      child: ListView(
        children: [
          Stack(
            children: [
              const Align(
                alignment: Alignment.center,
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    // radius: 100,
                    backgroundImage: AssetImage(
                      'assets/logo.jpg',
                      //  fit: BoxFit.cover,
                    ),
                  ),
                  accountName: Text('User Name'),
                  accountEmail: Text('Full Name'),
                ),
              ),
              Positioned(
                  top: 100,
                  left: drawerWidth - 65,
                  child: IconButton(
                      tooltip: 'Edit Profile',
                      onPressed: () {
                        Navigator.pop(context);
                        Get.to(() => Profile(),
                            transition: Transition.rightToLeft);
                      },
                      icon: const Icon(
                        Ionicons.pencil,
                        color: Colors.white,
                      )))
            ],
          ),
          ListTile(
            leading: const Icon(
              Ionicons.home_outline,
              color: Colors.green,
            ),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Ionicons.notifications_outline,
              color: Colors.green,
            ),
            title: const Text('Notifications'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Ionicons.file_tray_outline,
              color: Colors.green,
            ),
            title: Text('My Orders'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Ionicons.heart_outline,
              color: Colors.green,
            ),
            title: Text('Wishlist'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Ionicons.apps_outline,
              color: Colors.green,
            ),
            title: const Text('Categories'),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => CategoriesPage(),
                  transition: Transition.rightToLeft);
            },
          ),
          ListTile(
            leading: const Icon(
              Ionicons.tablet_portrait_outline,
              color: Colors.green,
            ),
            title: const Text('Kiosks'),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => KiosksPage(), transition: Transition.rightToLeft);
            },
          ),
          ListTile(
            leading: const Icon(
              Ionicons.person_outline,
              color: Colors.green,
            ),
            title: const Text('Users'),
            onTap: () {
              Navigator.pop(context);
              Get.to(() => UsersPage(), transition: Transition.rightToLeft);
            },
          ),
          Divider(),
          // ListTile(
          //   title: Text('Application Preferences'),
          // ),
          // ListTile(
          //   leading: Icon(
          //     Ionicons.information_circle_outline,
          //     color: Colors.green,
          //   ),
          //   title: Text('Help & Support'),
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(
              Ionicons.settings_outline,
              color: Colors.green,
            ),
            title: Text('Settings'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Ionicons.exit_outline,
              color: Colors.green,
            ),
            title: const Text('Logout'),
            onTap: () async {
              final action = await Confirm.showAlertDialog(
                    context,
                    _keyConfirm,
                    'LOG OUT',
                    'Are you sure you want to log-out your account?',
                    AlertMessagType.QUESTION,
                  ) ??
                  false;
              //  final action = await (f as FutureOr<bool>);
              if (action) {
                //Navigator.of(context).pop();
                LoadingDialog.showLoadingDialog(
                    context, _keyLoader, 'Clearing session...');

                Timer(const Duration(milliseconds: 1500), () async {
                  // Navigator.pop(
                  //     _keyLoader.currentContext, _keyLoader);
                  changeUser();
                });
              }
            },
          ),
          ListTile(
            title: Text('Version 1.0.0'),
          ),
        ],
      ),
    ),
  );
}

void changeUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  // await prefs.remove('user');
  // await prefs.remove('establishmentName');
  // await prefs.remove('showedDateTime');
  // await prefs.setBool('isLoggedIn', false);
  // Navigator.of(context).pushReplacementNamed('Login');

  Get.offAll(() => LoginPage());
  // await Provider.of<DrawerProvider>(context, listen: false)
  //     .setSelectedPage(EstablishmentPage.Home);
  // Navigator.of(context).pop();
  // Navigator.pushReplacement(
  //     context,
  //     BouncyPageRoute(
  //         widget: LoginPage(), animationStart: Alignment.bottomCenter));
}
