import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/models/packageHeader.dart';
import 'package:rick_and_morty/repository/baseRequest.dart';
import 'dart:convert' as convert;
import 'Requests.dart';

class LocationsRequest extends BaseRequest {

  late PackageHeader packageHeader;

  Future<List<Location>?> request([String url = "https://rickandmortyapi.com/api/location"]) async {
    List<Location> locations = [];

    try {
      var response = await Requests.httpGet(url);
      var jsonResponse = convert.jsonDecode(response.body);

      var info = jsonResponse["info"];
      packageHeader = PackageHeader.fromJson(info);

      var resultsList = jsonResponse["results"];
      for (var result in resultsList) {
        locations.add(Location.fromJson(result));
      }
    } catch(e) {
      errorMessage = e.toString();
      return null;
    }
    return locations;
  }

}