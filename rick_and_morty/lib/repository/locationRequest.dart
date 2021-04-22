import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/repository/baseRequest.dart';
import 'dart:convert' as convert;
import 'Requests.dart';

class LocationRequest extends BaseRequest {
  Future<Location?> requestId(int id) async {
    return requestUrl(
        "https://rickandmortyapi.com/api/location/" + id.toString());
  }

  Future<Location?> requestUrl(String url) async {
    try {
      var response = await Requests.httpGet(url);
      var jsonResponse = convert.jsonDecode(response.body);
      return Location.fromJson(jsonResponse);
    } catch (e) {
      errorMessage = e.toString();
      return null;
    }
  }
}