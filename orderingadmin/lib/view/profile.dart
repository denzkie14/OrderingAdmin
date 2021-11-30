import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/bottom_nav_controller.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final BottomNavController navController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      //  drawer: appDrawer(context),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: 'avatar',
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage: AssetImage(
                    'assets/logo.jpg',
                    //  fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Text('Profile Page'),
          ],
        ),
      ),
    );
  }
}

buildAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      'Profile',
      style: TextStyle(color: Colors.green),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(
        Ionicons.chevron_back_outline,
        color: Colors.green,
      ),
      onPressed: () {
        Get.back();
      },
    ),
  );
}
