import 'package:rick_and_morty/models/packageHeader.dart';
import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/repository/baseRequest.dart';
import 'dart:convert' as convert;
import 'Requests.dart';

class CharactersRequest extends BaseRequest {

  late PackageHeader packageHeader;

  Future<List<Person>?> request([String url = "https://rickandmortyapi.com/api/character"]) async {
    List<Person> persons = [];

    try {
      var response = await Requests.httpGet(url);
      var jsonResponse = convert.jsonDecode(response.body);

      var info = jsonResponse["info"];
      packageHeader = PackageHeader.fromJson(info);

      var resultsList = jsonResponse["results"];
      for (var result in resultsList) {
        persons.add(Person.fromJson(result));
      }
    } catch(e) {
      errorMessage = e.toString();
      return null;
    }
    return persons;
  }

}