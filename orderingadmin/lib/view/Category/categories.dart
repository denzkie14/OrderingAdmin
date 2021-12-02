import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/category_controller.dart';
import 'package:orderingadmin/controller/kiosk_controller.dart';
import 'package:orderingadmin/controller/users_controller.dart';
import 'package:orderingadmin/model/category_model.dart';
import 'package:orderingadmin/model/kiosk_model.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/confirm_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/util/toast_message.dart';
import 'package:orderingadmin/view/Category/category_form.dart';
import 'package:orderingadmin/view/Kiosk/kiosk_form.dart';
import 'package:orderingadmin/view/user_form.dart';

class CategoriesPage extends StatelessWidget {
  // const UsersPage({ Key? key }) : super(key: key);
  final CategoryController _controller = Get.put(CategoryController());
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyConfirm = new GlobalKey<State>();
  final api = HttpService();
  @override
  Widget build(BuildContext context) {
    // _controller.loadUser();

    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: GetBuilder<CategoryController>(
            init: CategoryController(),
            builder: (value) {
              if (value.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                );
              }

              if (value.list.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value.errorMessage.value),
                      IconButton(
                        onPressed: () {
                          value.load();
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
                  value.load();
                  return Future.value();
                },
                child: Center(
                  child: ListView.builder(
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        final category = value.list.elementAt(index);

                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              onTap: () {},
                              title: Text(category.category_desc ?? ''),
                              //  subtitle: Text(category.kiosk_type ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() =>
                                            CategoryForm(category: category));
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
                                                  'Are you sure you want delete the selected item?',
                                                  AlertMessagType.QUESTION,
                                                ) ??
                                                false;
                                        if (action) {
                                          _remove(context, category);
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
          Get.to(() => CategoryForm());
        },
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Categories',
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

  _remove(BuildContext context, Category category) async {
    LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
    try {
      var response = await api.removeCategory(category);
      if (response.statusCode == 200) {
        print('Success deleting category!');
        ToastMessage.showToastMessage(
            context, "Item deleted.", AlertMessagType.DEFAULT);
        _controller.load();
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
      print('Error adding category: ' + e.toString());
    } finally {
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }
}
