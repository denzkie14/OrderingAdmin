import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/view/profile.dart';
import 'package:orderingadmin/view/users.dart';

appDrawer(BuildContext context) {
  final drawerWidth = MediaQuery.of(context).size.width / 1.3;

  return Container(
    width: drawerWidth,
    child: Drawer(
      child: ListView(
        children: [
          Stack(
            children: [
              Align(
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
                      icon: Icon(
                        Ionicons.pencil,
                        color: Colors.white,
                      )))
            ],
          ),
          ListTile(
            leading: Icon(
              Ionicons.home_outline,
              color: Colors.green,
            ),
            title: Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Ionicons.notifications_outline,
              color: Colors.green,
            ),
            title: Text('Notifications'),
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
            leading: Icon(
              Ionicons.person_outline,
              color: Colors.green,
            ),
            title: Text('Users'),
            onTap: () {
              Get.to(() => UsersPage());
            },
          ),
          Divider(),
          ListTile(
            title: Text('Application Preferences'),
          ),
          ListTile(
            leading: Icon(
              Ionicons.information_circle_outline,
              color: Colors.green,
            ),
            title: Text('Help & Support'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Ionicons.settings_outline,
              color: Colors.green,
            ),
            title: Text('Settings'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Ionicons.exit_outline,
              color: Colors.green,
            ),
            title: Text('Logout'),
            onTap: () {},
          ),
          ListTile(
            title: Text('Version 1.0.0'),
          ),
        ],
      ),
    ),
  );
}
