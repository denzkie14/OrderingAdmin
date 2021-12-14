import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/hide_navigation_controller.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/prefs.dart';
import 'package:orderingadmin/util/toast_message.dart';
import 'package:orderingadmin/view/orders.dart';
import 'package:orderingadmin/view/wishlist.dart';
import 'package:orderingadmin/widgets/carousel_banner.dart';

import '../controller/bottom_nav_controller.dart';
import '../main.dart';
import '../util/drawer.dart';
import 'notifications.dart';
import 'profile.dart';
import 'search.dart';

class HomePage extends StatefulWidget {
//  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late FirebaseMessaging messaging;

  final HideNavbar hiding = HideNavbar();
  final api = HttpService();
  final navController = Get.put(BottomNavController());
  final List<BottomNavigationBarItem> navItems = [
    BottomNavigationBarItem(
        icon: Icon(Ionicons.notifications_outline), label: 'Notifications'),
    BottomNavigationBarItem(
        icon: Icon(Ionicons.search_outline), label: 'Search'),
    BottomNavigationBarItem(
      icon: Container(), // Icon(Ionicons.storefront_outline),
      label: 'Home',
    ),
    BottomNavigationBarItem(
        icon: Icon(Ionicons.file_tray_outline), label: 'My Orders'),
    BottomNavigationBarItem(
        icon: Icon(Ionicons.heart_outline), label: 'Wishlist'),
  ];

  final profilePage = Profile();

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;

      ToastMessage.showToastMessage(
          context, "Tap again to exit the app.", AlertMessagType.DEFAULT);

      return Future.value(false);
    }

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
      saveToken(value ?? '');
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      // add code to refresh order list
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      // add code to refresh order list
    });
  }

  saveToken(String token) async {
    try {
      if (token.isNotEmpty) {
        final pref = SharedPref();
        User _user = User.fromJson(await pref.read('user'));
        _user.token = token;
        var request = await api.updateToken(_user);
        var body = jsonDecode(request.body);
        if (request.statusCode == 200) {
          print('User Token Updated');
        } else {
          print('Error: SaveToken - ${request.statusCode} ${request.body}');
        }
      }
    } catch (e) {
      print('Error: SaveToken - ${e.toString()} ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: SafeArea(
        child: ValueListenableBuilder(
          builder: (context, bool value, child) {
            return Scaffold(
              // key: _key,
              //  backgroundColor: Colors.grey[300],
              appBar: AppBar(
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: Icon(Icons.sort_outlined),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                }),
                title: Obx(
                  () => Text(
                    navController.selectedPageTitle.toString(),
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.w700),
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: CustomTheme.lightIconTheme,
                actions: [
                  IconButton(
                      onPressed: () {}, icon: Icon(Ionicons.cart_outline)),
                  IconButton(
                      onPressed: () {}, icon: Icon(Ionicons.map_outline)),
                  IconButton(
                    onPressed: () {
                      Get.to(() => Profile(),
                          transition: Transition.rightToLeft);

                      //  navController.setPage(2);
                    },
                    icon: Hero(
                      tag: 'avatar',
                      child: CircleAvatar(
                        // radius: 100,
                        backgroundImage: AssetImage(
                          'assets/logo.jpg',
                          //  fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              drawer: appDrawer(context),
              body: SingleChildScrollView(
                controller: hiding.controller,
                physics: BouncingScrollPhysics(),
                child: GetBuilder<BottomNavController>(builder: (controller) {
                  if (controller.selectedPage == 0) {
                    return Notifications();
                  } else if (controller.selectedPage == 1) {
                    return SearchPage();
                  } else if (controller.selectedPage == 2) {
                    return Home();
                  } else if (controller.selectedPage == 3) {
                    return Orders();
                  } else if (controller.selectedPage == 4) {
                    return Wishlist();
                  } else {
                    return Home();
                  }
                }),
              ),

              bottomNavigationBar: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                height: value ? kBottomNavigationBarHeight : 0.0,
                child: Wrap(
                  children: <Widget>[
                    GetBuilder<BottomNavController>(
                        init: BottomNavController(),
                        builder: (controller) {
                          return BottomNavigationBar(
                            //   elevation: 0.0,
                            currentIndex: controller.selectedPage,
                            selectedIconTheme: CustomTheme.lightIconTheme,
                            //  selectedItemColor: Colors.red,
                            unselectedItemColor: Colors.grey[600],

                            showSelectedLabels: false,
                            selectedItemColor: Colors.green,
                            showUnselectedLabels: false,

                            type: BottomNavigationBarType.fixed,
                            items: navItems,
                            onTap: (index) async {
                              controller.setPage(index);

                              switch (index) {
                                case 0:
                                  break;
                                case 1:
                                  break;
                                case 2:
                                  break;
                                case 3:
                                  break;

                                case 4:
                                  // await Get.to(() => Profile(),
                                  //     transition: Transition.rightToLeft);

                                  // controller.setPage(2);
                                  break;
                              }
                            },
                          );
                        })
                  ],
                ),
              ),

              floatingActionButton: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                height: value ? (kBottomNavigationBarHeight - 15) : 0.0,
                child: Wrap(
                  children: <Widget>[
                    GetBuilder<BottomNavController>(
                        init: BottomNavController(),
                        builder: (controller) {
                          return FloatingActionButton(
                            backgroundColor: Colors.green[600],
                            onPressed: () {
                              controller.setPage(2);
                              // showToast('Test Mesasge', MessageType.ERROR);
                              //      showAlert('Test Alert', MessageType.ERROR);

                              // Alert.showConfirm(
                              //     context,
                              //     'Test Alert',
                              //     'This is a custom alert message ',
                              //     MessageType.ERROR,
                              //     cancelLabel: 'Cancel',
                              //     confirmLabel: 'Remove');
                            },
                            child: Icon(Ionicons.home_outline),
                          );
                        })
                  ],
                ),
              ),

              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          },
          valueListenable: hiding.visible,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<String> data = [
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          const BannerSection(),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Ionicons.megaphone_outline),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Trending Stores',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                      color: Colors.purple[300],
                      padding: EdgeInsets.all(5.0),
                      width: 180,
                      child: Text('${data[index]}')),
                )
                    //visualDensity: VisualDensity.comfortable,
                    ;
              },
            ),
          ),

          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Ionicons.star_outline),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'Top products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          Container(
            // height: 500,
            padding: const EdgeInsets.all(8.0),
            margin: EdgeInsets.only(bottom: 56),
            child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: data.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text(data[index]),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)),
                  );
                }),
            // child: ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   // scrollDirection: Axis.vertical,
            //   itemCount: data.length,
            //   itemBuilder: (context, index) {
            //     return Card(
            //       child: Container(
            //           color: Colors.purple[300],
            //           padding: EdgeInsets.all(5.0),
            //           width: 180,
            //           height: 200,
            //           child: Text('${data[index]}')),
            //     )
            //         //visualDensity: VisualDensity.comfortable,
            //         ;
            //   },
            // ),
          ),

          // Builder(builder: (BuildContext context) {
          //   for (String s in data) {
          //     print(s);
          //     return Card(
          //       child: Container(
          //           height: 200,
          //           color: Colors.purple[300],
          //           padding: EdgeInsets.all(5.0),
          //           width: 180,
          //           child: Text(s)),
          //     );
          //   }

          //   return Container();
          // })
        ],
      ),
    );
  }
}
