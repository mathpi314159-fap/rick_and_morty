import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/models/packageHeader.dart';
import 'package:rick_and_morty/repository/Requests.dart';
import 'dart:convert' as convert;

import 'package:rick_and_morty/repository/locationsRequest.dart';

class LocationsData {
  List<Location> locations = [];

  late PackageHeader info;
}

class LocationsRepo {
  final LocationsData data = LocationsData();
  var isLoading = false;
  var errorMessage = "";

  Future<bool> loadLocations(String? url) async {
    var locReq = LocationsRequest();
    var locations =
        (url == null) ? await locReq.request() : await locReq.request(url);
    if (locations == null) {
      errorMessage = locReq.errorMessage;
      return false;
    }
    data.info = locReq.packageHeader;
    for (var loc in locations) {
      data.locations.add(loc);
    }
    return true;
  }
}
