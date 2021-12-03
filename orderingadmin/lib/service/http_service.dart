import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:orderingadmin/model/category_model.dart';
import 'package:orderingadmin/model/kiosk_model.dart';
import 'package:orderingadmin/model/product_model.dart';
import 'package:orderingadmin/model/user_model.dart';

enum ServerResponse {
  SocketException_Connection_refused,
  Code_200_with_Success,
  Code_200_with_Error,
  Code_404_400_Not_Found_Or_Bad_Request,
  Critical_Error,
  TimeoutException_No_Response_From_Server
}

class HttpService {
  // SharedPref sharedPref = SharedPref();
  // String convertUri(String component) {
  //   return Uri.encodeComponent(component);
  // }

  // final String rootURL = "http://192.168.1.3/";
  // final String rootURLSSL = "http://192.168.1.3/";
  // final String api = "http://192.168.1.3/api/";

  final String rootURL = "http://188.180.100.35/Ordering/";
  final String rootURLSSL = "http://188.180.100.35/Ordering/";
  final String api = "http://188.180.100.35/Ordering/api/";

  Future login(LoginRequest login) async {
    String url = api;
    String endPoint = 'Login';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await post(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(login));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future getUsers() async {
    String url = api;
    String endPoint = 'User';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await get(Uri.parse(url + endPoint), headers: headers);

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future addUser(User user) async {
    String url = api;
    String endPoint = 'User';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await post(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(user));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future updateUser(User user) async {
    String url = api;
    String endPoint = 'User';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await put(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(user));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future removeUser(User user) async {
    String url = api;
    String endPoint = 'User';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await delete(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(user));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future getKiosks() async {
    String url = api;
    String endPoint = 'Kiosk';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await get(Uri.parse(url + endPoint), headers: headers);

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future addKiosk(Kiosk kiosk) async {
    String url = api;
    String endPoint = 'Kiosk';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await post(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(kiosk));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future updateKiosk(Kiosk kiosk) async {
    String url = api;
    String endPoint = 'Kiosk';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await put(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(kiosk));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future updateKioskStatus(int id, bool status) async {
    String url = api;
    String endPoint = 'Kiosk/Status';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await put(
          Uri.parse(url + endPoint + '?id=$id&status=$status'),
          headers: headers);

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future removeKiosk(Kiosk kiosk) async {
    String url = api;
    String endPoint = 'Kiosk';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await delete(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(kiosk));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future getCategories() async {
    String url = api;
    String endPoint = 'Category';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await get(Uri.parse(url + endPoint), headers: headers);

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future addCategory(Category category) async {
    String url = api;
    String endPoint = 'Category';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await post(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(category));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future updateCategory(Category category) async {
    String url = api;
    String endPoint = 'Category';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await put(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(category));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future removeCategory(Category category) async {
    String url = api;
    String endPoint = 'Category';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await delete(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(category));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future getProducts() async {
    String url = api;
    String endPoint = 'Item';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await get(Uri.parse(url + endPoint), headers: headers);

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future addProduct(Product product) async {
    String url = api;
    String endPoint = 'Item';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await post(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(product));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future updateProduct(Product product) async {
    String url = api;
    String endPoint = 'Item';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await put(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(product));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }

  Future removeProduct(Product product) async {
    String url = api;
    String endPoint = 'Item';
    Map<String, String> headers = {
      //   HttpHeaders.authorizationHeader: auth,
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    // print(url);

    try {
      Response result = await delete(Uri.parse(url + endPoint),
          headers: headers, body: json.encode(product));

      return result;
    } on TimeoutException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: Server response timeout...';
      // A timeout occurred.
    } on SocketException catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    } catch (e) {
      print(e.toString());
      return Future.value();
      //  return 'Error: No Network Connection...';
    }
  }
}
