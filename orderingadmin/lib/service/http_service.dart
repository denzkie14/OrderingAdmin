import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
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

  final String rootURL = "http://192.168.1.3/";
  final String rootURLSSL = "http://192.168.1.3/";
  final String api = "http://192.168.1.3/api/";

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
}
