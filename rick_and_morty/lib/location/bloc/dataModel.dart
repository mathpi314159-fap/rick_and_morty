import 'package:rick_and_morty/models/location.dart';
import 'package:rick_and_morty/models/packageHeader.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/repository/Requests.dart';
import 'package:rick_and_morty/repository/characterRequest.dart';
import 'dart:convert' as convert;

import 'package:rick_and_morty/repository/locationRequest.dart';

class LocationData {
  Location? location;
  List<Person> persons = [];

  late PackageHeader info;
}

class LocationRepo {
  final LocationData data = LocationData();
  String errorMessage = "";

  Future<bool> loadLocation(int id) async {
    var locReq = LocationRequest();
    if ((data.location = await locReq.requestId(id)) == null) {
      errorMessage = locReq.errorMessage;
      return false;
    }

    var charReq = CharacterRequest();
    for (var url in (data.location!.residents ?? [])) {
      var person = await charReq.requestUrl(url);
      if (person != null) {
        data.persons.add(person);
      }
    }
    return true;
  }
}
