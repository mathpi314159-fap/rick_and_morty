import 'package:rick_and_morty/models/packageHeader.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/repository/Requests.dart';
import 'dart:convert' as convert;

import 'package:rick_and_morty/repository/charactersRequest.dart';

class PersonData {
  List<Person> persons = [];

  late PackageHeader info;
}

class PersonRepo {
  final PersonData data = PersonData();
  var isLoading = false;
  var errorMessage = "";

  Future<bool> loadPersons(String? url) async {
    var charReq = CharactersRequest();
    var persons =
        (url == null) ? await charReq.request() : await charReq.request(url);
    if (persons == null) {
      errorMessage = charReq.errorMessage;
      return false;
    }
    data.info = charReq.packageHeader;
    for (var person in persons) {
      data.persons.add(person);
    }
    return true;
  }
}
