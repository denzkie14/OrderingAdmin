import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/kiosk_controller.dart';
import 'package:orderingadmin/controller/users_controller.dart';
import 'package:orderingadmin/model/kiosk_model.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/confirm_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/util/toast_message.dart';
import 'package:orderingadmin/view/Kiosk/kiosk_form.dart';
import 'package:orderingadmin/view/user_form.dart';

class KiosksPage extends StatelessWidget {
  // const UsersPage({ Key? key }) : super(key: key);
  final KioskController _controller = Get.put(KioskController());
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyConfirm = new GlobalKey<State>();
  final api = HttpService();
  @override
  Widget build(BuildContext context) {
    // _controller.loadUser();

    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: GetBuilder<KioskController>(
            init: KioskController(),
            builder: (value) {
              if (value.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                );
              }

              if (value.kioskList.isEmpty) {
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
                      itemCount: value.kioskList.length,
                      itemBuilder: (context, index) {
                        final kiosk = value.kioskList.elementAt(index);

                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              onTap: () {},
                              title: Text(kiosk.kiosk_desc ?? ''),
                              subtitle: Text(kiosk.kiosk_type ?? ''),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() => KioskForm(kiosk: kiosk));
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
                                          _remove(context, kiosk);
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
          Get.to(() => KioskForm());
        },
      ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Kiosk',
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

  _remove(BuildContext context, Kiosk kiosk) async {
    LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
    try {
      var response = await api.removeKiosk(kiosk);
      if (response.statusCode == 200) {
        print('Success deleting kiosk!');
        ToastMessage.showToastMessage(
            context, "Item deleted.", AlertMessagType.DEFAULT);
        _controller.load();
      } else {
        var body = jsonDecode(response.body);
        ToastMessage.showToastMessage(context,
            "Failed to delete, please try again.", AlertMessagType.DEFAULT);
        print(response.statusCode.toString() + ': ' + body);
        print(response.statusCode.toString() + ': ' + body);
      }
    } catch (e) {
      ToastMessage.showToastMessage(
          context,
          "Error occured: please check your network and try again.",
          AlertMessagType.DEFAULT);
      print('Error adding kiosk: ' + e.toString());
    } finally {
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }
}
