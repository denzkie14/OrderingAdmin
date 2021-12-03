import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:orderingadmin/model/category_model.dart';
import 'package:orderingadmin/model/kiosk_model.dart';
import 'package:orderingadmin/model/product_model.dart';
import 'package:orderingadmin/model/user_model.dart';
import 'package:orderingadmin/service/http_service.dart';

class ProductController extends GetxController {
  final api = HttpService();
  var list = <Product>[];
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    load();
    super.onInit();
  }

  List<Product> get categories {
    return list;
  }

  void load() async {
    // isLoading.toggle();
    toggleLoading();
    try {
      final request =
          await api.getProducts().timeout(const Duration(seconds: 60));
      var body = jsonDecode(request.body);

      if (request.statusCode == 200) {
        list = (body as List).map((i) => Product.fromJson(i)).toList();
        update();
        if (list.length == 0) {
          errorMessage.value = 'No record found...';
        }
      }
      if (request.statusCode == 404) {
        errorMessage.value = 'No record found...';
      }
    } on TimeoutException catch (e) {
      errorMessage.value =
          'Server failed to response: Please try again later...';
      print('Error Adding user: ' + e.toString());
    } on SocketException catch (e) {
      errorMessage.value = 'Please check your network: Please try again.';
      print('Error Adding user: ' + e.toString());
    } catch (e) {
      errorMessage.value = 'Please check your network: Please try again.';
      print('Error Adding user: ' + e.toString());
    } finally {
      // toglleLoading();
      toggleLoading();
    }
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
