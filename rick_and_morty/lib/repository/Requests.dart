import 'dart:io';

import 'package:http/http.dart' as http;

import 'Exceptions.dart';

class Requests {
  static Future<http.Response> httpGet(String url) async {
    var response;
    try {
      response = await http.get(Uri.parse(url));
    } on SocketException {
      throw FetchDataException("No Internet connection");
    }
    return response;
   }
}

