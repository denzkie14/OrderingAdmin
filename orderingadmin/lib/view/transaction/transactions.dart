import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/product_controller.dart';
import 'package:orderingadmin/controller/transaction_controller.dart';
import 'package:orderingadmin/model/product_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/confirm_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/util/toast_message.dart';
import 'package:orderingadmin/view/Category/category_form.dart';
import 'package:orderingadmin/view/Product/product_form.dart';

import '../order.dart';

class TransactionsPage extends StatelessWidget {
  // const UsersPage({ Key? key }) : super(key: key);
  final ProductController _controller = Get.put(ProductController());
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<State> _keyConfirm = new GlobalKey<State>();
  final api = HttpService();
  var formatter = NumberFormat('#,###,000.00');
  final DateFormat formatDate = DateFormat('MMM dd, yyyy hh:mm:ss');
  @override
  Widget build(BuildContext context) {
    // _controller.loadUser();
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        height: Get.height - 150,
        child: GetBuilder<TransactionController>(
            init: TransactionController(),
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
                child: Container(
                  height: Get.height - 150,
                  child: ListView.builder(
                      //shrinkWrap: true,
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        final order = value.list.elementAt(index);
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: GestureDetector(
                            onTap: () => Get.to(() => OrderPage(order)),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          '${api.api}Item/Image/${order.items!.first.item_id}',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 95.0,
                                        height: 95.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          CircleAvatar(
                                        child: Image.asset('assets/logo.jpg'),
                                      ),
                                      //   const CircularProgressIndicator(
                                      // valueColor: AlwaysStoppedAnimation<Color>(
                                      //     Colors.green),
                                      // ),

                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              order.order_code ?? '',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '₱ ' +
                                                      formatter.format(order
                                                          .items!
                                                          .map((e) =>
                                                              (e.price! *
                                                                  e.quantity!))
                                                          .fold<num>(
                                                              0,
                                                              (sum, e) =>
                                                                  sum + e)),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              formatDate.format(
                                                  order.order_date ??
                                                      DateTime.now()),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              'Type: ${order.kiosk_type}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.end,
                                    //   children: [
                                    //     IconButton(
                                    //         onPressed: () {
                                    //           //   Get.to(() =>
                                    //           //  ProductForm(product: product));
                                    //         },
                                    //         color: Colors.green,
                                    //         icon: const Icon(
                                    //             Ionicons.pencil_outline)),
                                    //     IconButton(
                                    //         color: Colors.red,
                                    //         onPressed: () async {
                                    //           // final action =
                                    //           //     await Confirm.showAlertDialog(
                                    //           //           context,
                                    //           //           _keyConfirm,
                                    //           //           'Delete',
                                    //           //           'Are you sure you want delete the selected item?',
                                    //           //           AlertMessagType.QUESTION,
                                    //           //         ) ??
                                    //           //         false;
                                    //           // if (action) {
                                    //           //   _remove(context, product);
                                    //           // }
                                    //         },
                                    //         icon:
                                    //             const Icon(Ionicons.trash_outline))
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                              elevation: 10,
                            ),
                          ),
                        );
                      }),
                ),
              );
            }),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.green[600],
      //   child: const Icon(Ionicons.add_outline),
      //   onPressed: () {
      //     Get.to(() => ProductForm());
      //   },
      // ),
    );
  }

  buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Transactions',
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

  // _remove(BuildContext context, Product product) async {
  //   LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
  //   try {
  //     var response = await api.removeProduct(product);
  //     if (response.statusCode == 200) {
  //       print('Success deleting category!');
  //       ToastMessage.showToastMessage(
  //           context, "Item deleted.", AlertMessagType.DEFAULT);
  //       _controller.load();
  //     } else {
  //       var body = jsonDecode(response.body);
  //       ToastMessage.showToastMessage(context,
  //           "Failed to delete, please try again.", AlertMessagType.DEFAULT);
  //       print(response.statusCode.toString() + ': ' + body);
  //     }
  //   } catch (e) {
  //     ToastMessage.showToastMessage(
  //         context,
  //         "Error occured: please check your network and try again.",
  //         AlertMessagType.DEFAULT);
  //     print('Error adding category: ' + e.toString());
  //   } finally {
  //     Navigator.pop(_keyLoader.currentContext!, _keyLoader);
  //   }
  // }
}
