import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/controller/kiosk_controller.dart';
import 'package:orderingadmin/controller/order_controller.dart';
import 'package:orderingadmin/model/order_model.dart';
import 'package:orderingadmin/model/product_model.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';
import 'package:orderingadmin/util/alert_dialog.dart';
import 'package:orderingadmin/util/confirm_dialog.dart';
import 'package:orderingadmin/util/loading_dialog.dart';
import 'package:orderingadmin/util/prefs.dart';
import 'package:orderingadmin/util/quantity_dialog.dart';
import 'package:orderingadmin/util/toast_message.dart';
import 'package:orderingadmin/view/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  final Order order;

  OrderPage(this.order);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Order _currentOrder = Order();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final GlobalKey<State> _keyConfirm = new GlobalKey<State>();

  final _controller = Get.put(OrderController());

  final kioskController = Get.put(KioskController());

  final api = HttpService();

  final formatter = NumberFormat('#,###,000.00');
  final DateFormat formatDate = DateFormat('MMM dd, yyyy hh:mm:ss');
  TextStyle style = const TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.green);

  buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Ordered Items',
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _currentOrder = widget.order;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Get.height - 220,
                child: ListView.builder(
                    //      shrinkWrap: true,
                    itemCount: _currentOrder.items!.length,
                    itemBuilder: (context, index) {
                      final product = _currentOrder.items!.elementAt(index);
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (_) {},
                        confirmDismiss: (DismissDirection direction) async {
                          final action = await Confirm.showAlertDialog(
                                context,
                                _keyConfirm,
                                'Remove',
                                'Are you sure you want remove the selected item?',
                                AlertMessagType.QUESTION,
                              ) ??
                              false;
                          if (action) {
                            removeItem(context, product);
                            return true;
                          } else {
                            return false;
                          }
                        },
                        background: Container(
                          color: Colors.red,
                          padding: const EdgeInsets.only(left: 25),
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.startToEnd,
                        child: GestureDetector(
                          onTap: () async {
                            int currentValue = product.quantity!;
                            final qty = await QuantityDialog.showAlertDialog(
                                context, product) as int;
                            if (qty > 0 && currentValue != qty) {
                              // Product s = product;
                              // s.quantity = qty;

                              // order.items!.add(s);
                              updateQuantity(context, product, qty);
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          '${api.api}Item/Image/${product.item_id}',
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
                                          const CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.green),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        //       mainAxisAlignment:
                                        //   MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.title ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          Text(
                                            product.item_desc ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          '₱ ' +
                                              formatter.format(product.price),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          '@ ${product.quantity} ${product.unit}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          '₱ ' +
                                              formatter.format((product.price! *
                                                  product.quantity!)),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    //     Row(
                                    //       mainAxisAlignment: MainAxisAlignment.end,
                                    //       children: [
                                    //         // IconButton(
                                    //         //     onPressed: () {},
                                    //         //     color: Colors.green,
                                    //         //     icon: const Icon(
                                    //         //         Ionicons.add_outline)),
                                    //         // IconButton(
                                    //         //     onPressed: () {
                                    //         //       Get.to(() => ProductForm(
                                    //         //           product: product));
                                    //         //     },
                                    //         //     color: Colors.green,
                                    //         //     icon: const Icon(
                                    //         //         Ionicons.pencil_outline)),
                                    //         IconButton(
                                    //             color: Colors.red,
                                    //             onPressed: () async {
                                    //               final action =
                                    //                   await Confirm.showAlertDialog(
                                    //                         context,
                                    //                         _keyConfirm,
                                    //                         'Remove',
                                    //                         'Are you sure you want remove the selected item?',
                                    //                         AlertMessagType.QUESTION,
                                    //                       ) ??
                                    //                       false;
                                    //               if (action) {
                                    //                 removeItem(context, product);
                                    //               }
                                    //             },
                                    //             icon: const Icon(
                                    //                 Ionicons.trash_outline))
                                    //       ],
                                    //     )
                                  ],
                                ),
                              ),
                              elevation: 10,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Visibility(
                visible: _currentOrder.or_number == null ? false : true,
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'OR #: ${_currentOrder.or_number}',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            formatDate.format(
                                _currentOrder.order_date ?? DateTime.now()),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total :  ₱ ' +
                                formatter.format(_currentOrder.items!
                                    .map((e) => e.price)
                                    .fold<num>(0, (sum, e) => sum + e!)),
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _currentOrder.or_number == null ? true : false,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Order Code #: ${_currentOrder.order_code}',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Total :  ₱ ' +
                                formatter.format(_currentOrder.items!
                                    .map((e) => e.price)
                                    .fold<num>(0, (sum, e) => sum + e!)),
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 12),
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.green,
                          child: Center(
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              onPressed: () async {
                                final action = await Confirm.showAlertDialog(
                                      context,
                                      _keyConfirm,
                                      'Confirm Order',
                                      'Are you sure you want to confirm this order?',
                                      AlertMessagType.QUESTION,
                                    ) ??
                                    false;
                                if (action) {
                                  await confirmOrder(context);
                                }

                                //   Get.offAll(() => HomePage());
                              },
                              child: Text("Confirm Order",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  updateQuantity(BuildContext context, Product product, int qty) async {
    // final prefs = await SharedPreferences.getInstance();
    // LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
//_controller
    try {
      var request = await api.updateItemOrder(
          widget.order.order_id!, product.item_id!, qty);
      if (request.statusCode == 200) {
        setState(() {
          _currentOrder.items!
              .where((i) => i.item_id == product.item_id)
              .first
              .quantity = qty;
        });
        ToastMessage.showToastMessage(
            context, 'Quantity updated.', AlertMessagType.DEFAULT);
        _controller.list
            .where((o) => o.order_id == widget.order.order_id)
            .first
            .items!
            .where((i) => i.item_id == product.item_id)
            .first
            .quantity = qty;
        print(_controller.list
            .where((o) => o.order_id == widget.order.order_id)
            .first
            .items!
            .where((i) => i.item_id == product.item_id)
            .first
            .quantity);
      } else {
        ToastMessage.showToastMessage(
            context,
            'Failed to update quantity, please try again.',
            AlertMessagType.DEFAULT);
        print('Error update Quantity: ${request.body}');
      }
    } catch (e) {
      ToastMessage.showToastMessage(
          context,
          'Error: Pelase check your network and try again.',
          AlertMessagType.DEFAULT);
      print('Error PlaceOrder: ${e.toString()}');
    } finally {
      // Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }

  removeItem(BuildContext context, Product product) async {
    // final prefs = await SharedPreferences.getInstance();
    // LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
//_controller
    try {
      var request =
          await api.removeItemOrder(widget.order.order_id!, product.item_id!);
      if (request.statusCode == 200) {
        setState(() {
          _currentOrder.items!.removeWhere((i) => i.item_id == product.item_id);
        });
        ToastMessage.showToastMessage(
            context, 'Item Removed.', AlertMessagType.DEFAULT);
        // _controller.list
        //     .where((o) => o.order_id == widget.order.order_id)
        //     .first
        //     .items!
        //     .removeWhere((i) => i.item_id == product.item_id);
        _controller.load();
      } else {
        ToastMessage.showToastMessage(
            context,
            'Failed to remove item, please try again.',
            AlertMessagType.DEFAULT);
        print('Error Remove Item: ${request.body}');
      }
    } catch (e) {
      ToastMessage.showToastMessage(
          context,
          'Error: Pelase check your network and try again.',
          AlertMessagType.DEFAULT);
      print('Error Remove Item: ${e.toString()}');
    } finally {
      // Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }

  confirmOrder(BuildContext context) async {
    // final prefs = await SharedPreferences.getInstance();
    LoadingDialog.showLoadingDialog(context, _keyLoader, 'Please wait...');
//_controller
    try {
      final pref = SharedPref();
      User _user = User.fromJson(await pref.read('user'));
      var request =
          await api.confirmOrder(widget.order.order_id!, _user.user_id!);
      if (request.statusCode == 200) {
        // setState(() {
        //   _currentOrder.items!.removeWhere((i) => i.item_id == product.item_id);
        // });
        ToastMessage.showToastMessage(
            context, 'Order Confirmed', AlertMessagType.DEFAULT);
        // _controller.list
        //     .where((o) => o.order_id == widget.order.order_id)
        //     .first
        //     .items!
        //     .removeWhere((i) => i.item_id == product.item_id);
        _controller.load();
        Get.back();
      } else {
        ToastMessage.showToastMessage(
            context,
            'Failed to confirm order, please try again.',
            AlertMessagType.DEFAULT);
        print('Error confirm order: ${request.body}');
      }
    } catch (e) {
      ToastMessage.showToastMessage(
          context,
          'Error: Pelase check your network and try again.',
          AlertMessagType.DEFAULT);
      print('Error confirm order: ${e.toString()}');
    } finally {
      Navigator.pop(_keyLoader.currentContext!, _keyLoader);
    }
  }
}
