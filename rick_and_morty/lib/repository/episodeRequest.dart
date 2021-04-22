import 'package:rick_and_morty/models/episode.dart';
import 'dart:convert' as convert;
import 'package:rick_and_morty/repository/baseRequest.dart';
import 'Requests.dart';

class EpisodeRequest extends BaseRequest {
  Future<Episode?> requestId(int id) async {
    return requestUrl(
        "https://rickandmortyapi.com/api/episode/" + id.toString());
  }

  Future<Episode?> requestUrl(String url) async {
    try {
      var response = await Requests.httpGet(url);
      var jsonResponse = convert.jsonDecode(response.body);
      return Episode.fromJson(jsonResponse);
    } catch (e) {
      errorMessage = e.toString();
      return null;
    }
  }
}
