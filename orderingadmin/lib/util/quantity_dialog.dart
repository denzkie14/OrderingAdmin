import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:orderingadmin/model/product_model.dart';
import 'package:orderingadmin/util/toast_message.dart';

import 'alert_dialog.dart';

class QuantityDialog {
  static Future<int?> showAlertDialog(
      BuildContext context, Product product) async {
    int quantity = product.quantity ?? 1;
    TextEditingController qty = TextEditingController(
        text: product.quantity == null ? '1' : product.quantity.toString());

    return showModal<int?>(
        context: context,
        configuration: const FadeScaleTransitionConfiguration(
            barrierDismissible: false,
            transitionDuration: const Duration(milliseconds: 350),
            reverseTransitionDuration: const Duration(milliseconds: 150)),
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Ionicons.information_outline,
                        color: Colors.green,
                      ),
                      Flexible(
                        child: Text(
                          ' Quantity',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${product.title}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              quantity--;
                            } else {
                              quantity = 1;
                            }

                            qty.text = quantity.toString();
                          },
                          icon: Icon(
                            Ionicons.remove_circle_outline,
                            color: Colors.red,
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: 120,
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            if (int.parse(value) == 0) {
                              ToastMessage.showToastMessage(
                                  context,
                                  'Please specify correct value',
                                  AlertMessagType.DEFAULT);
                              Navigator.of(context).pop(0);
                            } else {
                              Navigator.of(context).pop(quantity);
                            }
                          },
                          controller: qty,
                          //  initialValue: controller.quantity.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          //  controller: qty,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            //   if (quantity > 1) {
                            quantity++;
                            qty.text = quantity.toString();
                            //   controller.quantity = quantity;
                            // } else {
                            //    quantity = 1;
                            //  }
                          },
                          icon: Icon(
                            Ionicons.add_circle_outline,
                            color: Colors.green,
                          )),
                    ],
                  ),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(0);
                                  },
                                ),
                                TextButton(
                                  //  color: Colors.white,
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(quantity);
                                  },
                                ),
                              ]),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class UpdateQuantityDialog {
  static Future<int?> showAlertDialog(
      BuildContext context, Product product) async {
    int quantity = product.quantity ?? 1;
    TextEditingController qty = TextEditingController(
        text: product.quantity == null ? '1' : product.quantity.toString());

    return showModal<int?>(
        context: context,
        configuration: const FadeScaleTransitionConfiguration(
            barrierDismissible: false,
            transitionDuration: Duration(milliseconds: 350),
            reverseTransitionDuration: Duration(milliseconds: 150)),
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 10,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Ionicons.information_outline,
                        color: Colors.green,
                      ),
                      Flexible(
                        child: Text(
                          ' Quantity',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 4.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${product.title}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              quantity--;
                            } else {
                              quantity = 1;
                            }

                            qty.text = quantity.toString();
                          },
                          icon: Icon(
                            Ionicons.remove_circle_outline,
                            color: Colors.red,
                          )),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: 120,
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            if (int.parse(value) == 0) {
                              ToastMessage.showToastMessage(
                                  context,
                                  'Please specify correct value',
                                  AlertMessagType.DEFAULT);
                              Navigator.of(context).pop(0);
                            } else {
                              Navigator.of(context).pop(quantity);
                            }
                          },
                          controller: qty,
                          //  initialValue: controller.quantity.toString(),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          //  controller: qty,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            //   if (quantity > 1) {
                            quantity++;
                            qty.text = quantity.toString();
                            //   controller.quantity = quantity;
                            // } else {
                            //    quantity = 1;
                            //  }
                          },
                          icon: Icon(
                            Ionicons.add_circle_outline,
                            color: Colors.green,
                          )),
                    ],
                  ),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(32.0),
                              bottomRight: Radius.circular(32.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 2.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(0);
                                  },
                                ),
                                TextButton(
                                  //  color: Colors.white,
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(quantity);
                                  },
                                ),
                              ]),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
