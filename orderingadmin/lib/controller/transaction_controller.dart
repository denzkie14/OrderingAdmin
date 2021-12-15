import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:orderingadmin/model/category_model.dart';
import 'package:orderingadmin/model/order_model.dart';
import 'package:orderingadmin/model/product_model.dart';
import 'package:orderingadmin/service/http_service.dart';

class TransactionController extends GetxController {
  final api = HttpService();
  var list = <Order>[];
  Order order = Order();
  var productList = <Product>[];
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    load();
    super.onInit();
  }

  List<Product> get products {
    return productList;
  }

  void load({Category? category}) async {
    //isLoading.toggle();
    toggleLoading();
    try {
      final request =
          await api.getTransactions().timeout(const Duration(seconds: 60));
      var body = jsonDecode(request.body);
      print(request.body);
      if (request.statusCode == 200) {
        list = (body as List).map((i) => Order.fromJson(i)).toList();
        update();
        if (list.isEmpty) {
          errorMessage.value = 'No record found...';
        }
      }
      if (request.statusCode == 404) {
        errorMessage.value = 'No record found...';
      }
    } on TimeoutException catch (e) {
      errorMessage.value =
          'Server failed to response: Please try again later...';
      print('Error load transactions: ' + e.toString());
    } on SocketException catch (e) {
      errorMessage.value = 'Please check your network: Please try again.';
      print('Error load transactions: ' + e.toString());
    } catch (e) {
      errorMessage.value = 'Please check your network: Please try again.';
      print('Error load transactions: ' + e.toString());
    } finally {
      // toglleLoading();
      toggleLoading();
    }
  }

  addProduct(Product p) {
    // order.items?.add(p);
    // productList.where((element) => element.item_id == p.item_id) = p;
    productList.removeWhere((e) => e.item_id == p.item_id);
    productList.add(p);
    update();
  }

  updateProduct(Product p) {
    // order.items?.removeWhere((e) => e.item_id == p.item_id);
    // order.items?.add(p);
    productList.removeWhere((e) => e.item_id == p.item_id);
    productList.add(p);
    update();
  }

  removeProduct(Product p) {
    //order.items?.removeWhere((e) => e.item_id == p.item_id);
    productList.removeWhere((e) => e.item_id == p.item_id);

    // order.items?.add(p);
    update();
  }

  toggleLoading() {
    isLoading.toggle();
    update();
  }

  void add(Product product) async {
    try {
      var request = await api.addProduct(product);

      if (request.statusCode == 200) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } on Exception catch (e) {
      print('Error Adding user: ' + e.toString());
      return Future.value(false);
    }

    // final int index = _items.indexWhere((item) => item.id == id);
    // _items[index].inWishList.value = true;
  }
}
