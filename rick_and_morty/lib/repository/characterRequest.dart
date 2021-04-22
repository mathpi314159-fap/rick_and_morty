import 'package:rick_and_morty/models/person.dart';
import 'package:rick_and_morty/repository/baseRequest.dart';
import 'Requests.dart';
import 'dart:convert' as convert;

class CharacterRequest extends BaseRequest {
  Future<Person?> requestId(int id) async {
    return requestUrl(
        "https://rickandmortyapi.com/api/character/" + id.toString());
  }

  Future<Person?> requestUrl(String url) async {
    try {
      var response = await Requests.httpGet(url);
      var jsonResponse = convert.jsonDecode(response.body);
      return Person.fromJson(jsonResponse);
    } catch (e) {
      errorMessage = e.toString();
      return null;
    }
  }
}
