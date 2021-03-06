import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/users_controller.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/confirm_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/util/toast_message.dart';
import 'package:orderingadmin/view/user_form.dart';

class UsersPage extends StatelessWidget {
  // const UsersPage({ Key? key }) : super(key: key);
  final UsersController _controller = Get.put(UsersController());
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyConfirm = new GlobalKey<State>();
  final api = HttpService();
  @override
  Widget build(BuildContext context) {
    // _controller.loadUser();

    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: GetBuilder<UsersController>(
            init: UsersController(),
            builder: (value) {
              if (value.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                );
              }

              if (value.usersList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value.errorMessage.value),
                      IconButton(
                        onPressed: () {
                          value.loadUser();
                        },
                        icon: const Icon(Ionicons.refresh_outline),
                        iconSize: Get.height / 16,
                      )
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  value.loadUser();
                  return Future.value();
                },
                child: Center(
                  child: ListView.builder(
                      itemCount: value.usersList.length,
                      itemBuilder: (context, index) {
                        final user = value.usersList.elementAt(index);

                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              onTap: () {},
                              title: Text(user.fname ?? ''),
                              subtitle: Text(user.user_type ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() => UserForm(user: user));
                                      },
                                      color: Colors.green,
                                      icon:
                                          const Icon(Ionicons.pencil_outline)),
                                  IconButton(
                                      color: Colors.red,
                                      onPressed: () async {
                                        final action =
                                            await Confirm.showAlertDialog(
                                                  context,
                                                  _keyConfirm,
                                                  'Delete',
                                                  'Are you sure you want delete the selected record?',
                                                  AlertMessagType.QUESTION,
                                                ) ??
                                                false;
                                        if (action) {
                                          _removeUser(context, user);
                                        }
                                      },
                                      icon: const Icon(Ionicons.trash_outline))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[600],
        child: const Icon(Ionicons.add_outline),
        onPressed: () {
          Get.to(() => UserForm());
        },
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Users',
        style: TextStyle(color: Colors.green),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Ionicons.chevron_back_outline,
          color: Colors.green,
        ),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  _removeUser(BuildContext context, User user) async {
    LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
    try {
      var response = await api.removeUser(user);
      if (response.statusCode == 200) {
        print('Success deleting user!');
        ToastMessage.showToastMessage(
            context, "Record deleted.", AlertMessagType.DEFAULT);
        _controller.loadUser();
      } else {
        var body = jsonDecode(response.body);
        ToastMessage.showToastMessage(context,
            "Failed to delete, please try again.", AlertMessagType.DEFAULT);
        print(response.statusCode.toString() + ': ' + body);
      }
    } catch (e) {
      ToastMessage.showToastMessage(
          context,
          "Error occured: please check your network and try again.",
          AlertMessagType.DEFAULT);
      print('Error adding user: ' + e.toString());
    } finally {
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }
}
